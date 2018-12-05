/****************************************************************************
 *
 * Copyright (C) 2018 Pinecone Inc. All rights reserved.
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

#pragma once

#include "Joystick.h"

class JoystickManager;

class KeyConfiguration : public QObject
{
    Q_OBJECT

public:
    typedef enum {
        keyAction_shortPress,
        keyAction_longPress,
        keyAction_down,
        keyAction_up,
    } KeyAction_t;

    typedef struct
    {
        int channel;
        int value;
        int controlMode;
        int defaultValue;
    } KeySetting_t;

    KeyConfiguration(JoystickManager* joystickManager);
    ~KeyConfiguration();

    Q_PROPERTY(QVariantList channelValueCounts READ channelValueCounts NOTIFY channelValueCountsChanged)

    Q_INVOKABLE QString  getKeyStringFromIndex(int index);
    Q_INVOKABLE QString  getKeyNameFromIndex(int index);
    Q_INVOKABLE void saveKeySetting(int keyIndex, int channel, int value);
    Q_INVOKABLE void saveSingleKeySetting(int keyIndex,
                                          int controlMode,
                                          int channel,
                                          int value,
                                          int defaultValue);
    Q_INVOKABLE int keyIsInUse(int keyIndex, int controlMode);
    Q_INVOKABLE int getKeyCount(int channel);
    Q_INVOKABLE QString getKeySettingString(int channel);
    Q_INVOKABLE void resetKeySetting(int channel);
    Q_INVOKABLE int getKeyIndex(int channel, int seq, int count);
    Q_INVOKABLE int getValue(int channel, int seq, int count);
    Q_INVOKABLE int getDefaultValue(int channel);
    Q_INVOKABLE int getControlMode(int channel);
    Q_INVOKABLE void setChannelDefaultValue(int channel);

    int getSeqInChannel(int channel, int value);
    int getChannelValueCount(int channel);

    bool getChannelValue(int keyCode, KeyAction_t action, int* channel, int* value);
    QVariantList channelValueCounts();

signals:
    void channelValueCountsChanged();

private:
    int _currentChannelValue(int channel);
    int _getKeyIndexFromKeyCode(int keyCode, int action);
    void _loadSettingToCache();
    void _setChannelDefaultValues();

    int _channelDefaultMinValue;
    int _channelDefaultMaxValue;
    int _deviceKeyCount;
    QStringList chBtnListQStr;
    JoystickManager* _joystickManager;
    QString _keySettingGroup;
    KeySetting_t* _keySettingCache;
    QStringList _keyNameList;
    QStringList _keyStringList;
};
