/****************************************************************************
 *
 * Copyright (C) 2018 Pinecone Inc. All rights reserved.
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

#include "JoystickManager.h"
#include "KeyConfiguration.h"

KeyConfiguration::KeyConfiguration(JoystickManager* joystickManager)
    : QObject()
    , _channelDefaultMinValue(400)
    , _channelDefaultMaxValue(1600)
    , _deviceKeyCount(4)
    , _joystickManager(joystickManager)
    , _keySettingGroup("KEYSETTING")
{
    _keySettingCache = new KeySetting_t[_deviceKeyCount*2];
    memset(_keySettingCache, 0, sizeof(KeySetting_t) * _deviceKeyCount * 2);
    _keyNameList << "A" << "B" << "C" << "D";
    _keyStringList << "A short" << "A long" << "B short" << "B long" << "C short" << "C long"
                   << "D short" << "D long";
    _loadSettingToCache();
    _setChannelDefaultValues();
}

KeyConfiguration::~KeyConfiguration()
{
    delete[] _keySettingCache;
}

void KeyConfiguration::_loadSettingToCache()
{
    QSettings settings;
    settings.beginGroup(_keySettingGroup);
    QStringList keys = settings.childKeys();
    for (int i = 0; i < keys.count(); ++i)
    {
        int v = settings.value(keys.at(i)).toInt();
        int keyIndex = (QString(keys.at(i))).toInt();
        if(((v >> 28) & 0xF) > 0)
        {
            _keySettingCache[keyIndex].channel = (v >> 28) & 0xF;
            _keySettingCache[keyIndex].controlMode = (v >> 24) & 0xF;
            _keySettingCache[keyIndex].defaultValue = (v >> 12) & 0xFFF;
            _keySettingCache[keyIndex].value = v & 0xFFF;
        } else if ((v >> 16 && 0xFFFF) > 0) {
            _keySettingCache[keyIndex].channel = (v >> 16) & 0xFFFF;
            _keySettingCache[keyIndex].controlMode = 0;
            _keySettingCache[keyIndex].value = v & 0xFFFF;
            _keySettingCache[keyIndex].defaultValue = 0;
        }
    }
    settings.endGroup();
}

void KeyConfiguration::_setChannelDefaultValues()
{
    if (!_joystickManager->joystickMessageSender()) {
        qWarning() << "The joystickMessageSender is not ready, failed to load set default values!";
        return;
    }
    QMap<int, int> map;
    int channel;
    for (int i = 0; i < _deviceKeyCount * 2; ++i)
    {
        channel = _keySettingCache[i].channel;
        if( channel!= 0) {
            if (_keySettingCache[i].controlMode > 0) {
                _joystickManager->joystickMessageSender()->setChannelValue(channel - 5, _keySettingCache[i].defaultValue);
            } else {
                if((map.contains(channel) && map[channel] > _keySettingCache[i].value) ||
                   !map.contains(channel)) {
                    map[channel] = _keySettingCache[i].value;
                }
            }
        }
    }
    if (map.size() > 0) {
        QMap<int, int>::iterator it;
        for (it = map.begin(); it != map.end(); ++it) {
            _joystickManager->joystickMessageSender()->setChannelValue(it.key()-5, it.value());
        }
    }
}

void KeyConfiguration::setChannelDefaultValue(int channel)
{
    int v = 0;
    for (int i = 0; i < _deviceKeyCount * 2; ++i)
    {
        if (channel == _keySettingCache[i].channel) {
            if (_keySettingCache[i].controlMode > 0) {
                _joystickManager->joystickMessageSender()->setChannelValue(channel-5, _keySettingCache[i].defaultValue);
                return;
            } else {
                if(v > _keySettingCache[i].value || v == 0) {
                    v = _keySettingCache[i].value;
                }
            }
        }
    }
    _joystickManager->joystickMessageSender()->setChannelValue(channel-5, v);
    emit channelValueCountsChanged();
}

int KeyConfiguration::getSeqInChannel(int channel, int value)
{
    QMap<int, int> map;
    for (int i = 0; i < _deviceKeyCount * 2; ++i)
    {
        if(channel == _keySettingCache[i].channel) {
            if (_keySettingCache[i].controlMode > 0) {
                if (value == _keySettingCache[i].defaultValue) {
                    return value >  _keySettingCache[i].value ? 2 : 1;
                } else if (value == _keySettingCache[i].value) {
                    return value >  _keySettingCache[i].defaultValue ? 2 : 1;
                }
            } else {
                map[_keySettingCache[i].value] = i;
            }
        }
    }
    if (map.size() > 0) {
        QMap<int, int>::iterator it;
        int seq = 1;
        for (it = map.begin(); it != map.end(); ++it) {
            if (it.key() == value) {
                return seq;
            }
            seq++;
        }
    }
    return 0;
}

int KeyConfiguration::getChannelValueCount(int channel)
{
    QMap<int, int> map;
    for (int i = 0; i < _deviceKeyCount * 2; ++i)
    {
        if(channel == _keySettingCache[i].channel) {
            if (_keySettingCache[i].controlMode > 0) {
                return 2;
            } else {
                map[_keySettingCache[i].value] = i;
            }
        }
    }
    return map.size();
}

QVariantList KeyConfiguration::channelValueCounts()
{
    QVariantList list;

    for (int i=5; i<10; i++) {
        list += QVariant::fromValue(getChannelValueCount(i));
    }
    return list;
}

bool KeyConfiguration::getChannelValue(int keyCode, KeyAction_t action, int* channel, int* value)
{
    int index = _getKeyIndexFromKeyCode(keyCode, action);
    if (index < 0 || index >= 2 * _deviceKeyCount) {
        return false;
    }
    if (_keySettingCache[index].controlMode != 2 &&
        (action == keyAction_down || action == keyAction_up)) {
        return false;
    }
    *channel = _keySettingCache[index].channel;
    if (_keySettingCache[index].controlMode == 2) {
        if (action == keyAction_down) {
            *value = _keySettingCache[index].value;
        } else if (action == keyAction_up) {
            *value = _keySettingCache[index].defaultValue;
        } else {
            return false;
        }
    } else if (_keySettingCache[index].controlMode == 1) {
        if (_currentChannelValue(_keySettingCache[index].channel) == _keySettingCache[index].value) {
            *value = _keySettingCache[index].defaultValue;
        } else {
            *value = _keySettingCache[index].value;
        }
    } else {
        *value = _keySettingCache[index].value;
    }
    return (*channel != 0);
}

int KeyConfiguration::_currentChannelValue(int channel)
{
    return _joystickManager->joystickMessageSender()->getChannelValue(channel - 5);
}

int KeyConfiguration::_getKeyIndexFromKeyCode(int keyCode, int action)
{
    int index = -1;
    // to check hold mode setting, just use the setting for short
    if (action == KeyConfiguration::keyAction_down || action == KeyConfiguration::keyAction_up) {
        action = 0;
    }
    if(keyCode == 121) // KEYCODE_BREAK
    {
        index = _keyNameList.indexOf("A") * 2 + action;
    }
    else if(keyCode == 4) // KEYCODE_BACK
    {
        index = _keyNameList.indexOf("B") * 2 + action;
    }
    else if(keyCode == 24) // KEYCODE_VOLUME_UP
    {
        index = _keyNameList.indexOf("C") * 2 + action;
    }
    else if(keyCode == 25) // KEYCODE_VOLUME_DOWN
    {
        index = _keyNameList.indexOf("D") * 2 + action;
    }
    return index;
}

// 31-16 bits: channel id; 15-0 bits: value
void KeyConfiguration::saveKeySetting(int keyIndex, int channel, int value)
{
    _keySettingCache[keyIndex].channel = channel;
    _keySettingCache[keyIndex].value = value;
    _keySettingCache[keyIndex].controlMode = 0;
    _keySettingCache[keyIndex].defaultValue = 0;

    QSettings settings;
    settings.beginGroup(_keySettingGroup);
    settings.setValue(QString::number(keyIndex), (channel << 16) | (value & 0xFFFF));
    settings.endGroup();
}

void KeyConfiguration::saveSingleKeySetting(int keyIndex,
                                            int controlMode,
                                            int channel,
                                            int value,
                                            int defaultValue)
{
    if ((controlMode > 15) || (channel > 15) || (value > 4095) || (defaultValue > 4095)) {
        qWarning("input contains invalid value");
        return;
    }
    _keySettingCache[keyIndex].channel = channel;
    _keySettingCache[keyIndex].value = value;
    _keySettingCache[keyIndex].controlMode = controlMode;
    _keySettingCache[keyIndex].defaultValue = defaultValue;

    QSettings settings;
    settings.beginGroup(_keySettingGroup);

    // 31-28 bits: channel id; 27-24 bits: control mode; 23-12 bits: default value; 11-0 bits: value
    settings.setValue(QString::number(keyIndex), (channel << 28) | (controlMode << 24) | (defaultValue << 12) | value);

    if(controlMode == 2) { //hold mode will use both short and long press of the key
        int otherKeyIndex = (keyIndex % 2 == 0) ? (keyIndex + 1) : (keyIndex - 1);
        memcpy(&_keySettingCache[otherKeyIndex], &_keySettingCache[keyIndex], sizeof(KeySetting_t));

        settings.setValue(QString::number(otherKeyIndex), (channel << 28) | (controlMode << 24) | (defaultValue << 12) | value);
    }
    settings.endGroup();
    qDebug() << "single key setting is stored";
}

int KeyConfiguration::keyIsInUse(int keyIndex, int controlMode)
{
    int ch = _keySettingCache[keyIndex].channel;
    if (controlMode == 2 && ch == 0) {
        int otherKeyIndex = (keyIndex % 2 == 0) ? (keyIndex + 1) : (keyIndex - 1);
        ch = _keySettingCache[otherKeyIndex].channel;
    }
    return ch;
}

int KeyConfiguration::getKeyCount(int channel)
{
    int count = 0;
    for (int i = 0; i < _deviceKeyCount * 2; ++i)
    {
        if(_keySettingCache[i].channel == channel) {
            if (_keySettingCache[i].controlMode != 0) {
                count = 1;
                break;
            }
            count++;
        }
    }
    return count;
}

QString KeyConfiguration::getKeySettingString(int channel)
{
    QString keyString;
    QMap<int, int> map;
    for (int i = 0; i < _deviceKeyCount * 2; ++i)
    {
        if(_keySettingCache[i].channel == channel) {
            if (_keySettingCache[i].controlMode == 2) {
                keyString = getKeyNameFromIndex(i) + ", " + "Reset after key release";
                return keyString;
            } else if (_keySettingCache[i].controlMode == 1) {
                keyString = getKeyStringFromIndex(i) + ", " + "Keep after key release";
                return keyString;
            } else {
                map[_keySettingCache[i].value] = i;
            }
        }
    }
    if (map.size() > 0) {
        QMap<int, int>::iterator it;
        for (it = map.begin(); it != map.end(); ++it) {
            if(!keyString.isEmpty()) {
                keyString += ", ";
            }
            keyString += getKeyStringFromIndex(it.value());
        }
    }
    if(keyString.isEmpty()) {
        keyString = "Undefined";
    }
    return keyString;
}

int KeyConfiguration::getKeyIndex(int channel, int seq, int count)
{
    QMap<int, int> map;
    for (int i = 0; i < _deviceKeyCount * 2; ++i)
    {
        if(_keySettingCache[i].channel == channel) {
            count--;
            map[_keySettingCache[i].value] = i;
            if (count <= 0) {
                break;
            }
        }
    }
    if (map.size() > 0) {
        QMap<int, int>::iterator it;
        for (it = map.begin(); it != map.end(); ++it) {
            seq--;
            if (seq == 0) {
                return it.value();
            }
        }
    }
    return 0;
}

int KeyConfiguration::getValue(int channel, int seq, int count)
{
    QMap<int, int> map;
    for (int i = 0; i < _deviceKeyCount * 2; ++i)
    {
        if(_keySettingCache[i].channel == channel) {
            count--;
            map[_keySettingCache[i].value] = i;
            if (count <= 0) {
                break;
            }
        }
    }
    if (map.size() > 0) {
        QMap<int, int>::iterator it;
        for (it = map.begin(); it != map.end(); ++it) {
            seq--;
            if (seq == 0) {
                return it.key();
            }
        }
    }
    if (count < 1) {
        return 0;
    }
    if (count == 1) {
        return _channelDefaultMaxValue;
    }
    return _channelDefaultMinValue + (seq-1) * (_channelDefaultMaxValue-_channelDefaultMinValue) / (count-1);
}

int KeyConfiguration::getDefaultValue(int channel)
{
    for (int i = 0; i < _deviceKeyCount * 2; ++i)
    {
        if(_keySettingCache[i].channel == channel) {
            return _keySettingCache[i].defaultValue;
        }
    }
    return _channelDefaultMinValue;
}

int KeyConfiguration::getControlMode(int channel)
{
    for (int i = 0; i < _deviceKeyCount * 2; ++i)
    {
        if(_keySettingCache[i].channel == channel) {
            return _keySettingCache[i].controlMode;
        }
    }
    return 0;
}

void KeyConfiguration::resetKeySetting(int channel)
{
    QSettings settings;
    settings.beginGroup(_keySettingGroup);

    for (int i = 0; i < _deviceKeyCount * 2; ++i)
    {
        if(_keySettingCache[i].channel == channel) {
            memset(&_keySettingCache[i], 0 ,sizeof(KeySetting_t));
            settings.setValue(QString::number(i), 0);
        }
    }
    settings.endGroup();
    setChannelDefaultValue(channel);
}

QString KeyConfiguration::getKeyStringFromIndex(int index)
{
    if (index < _keyStringList.count()) {
        return _keyStringList[index];
    }
    return "";
}

QString KeyConfiguration::getKeyNameFromIndex(int index)
{
    if (index / 2  < _keyNameList.count()) {
        return _keyNameList[index/2];
    }
    return "";
}
