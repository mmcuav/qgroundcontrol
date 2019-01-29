/****************************************************************************
 *
 * Copyright (C) 2018 Pinecone Inc. All rights reserved.
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

#include "QGCApplication.h"
#include "RfSettings.h"
#include "QGCMapEngine.h"
#include "AppSettings.h"
#include "SettingsManager.h"
#include "AndroidInterface.h"

#include <QQmlEngine>
#include <QtQml>


const char* RfSettings::rfSettingsGroupName =          "RF";
const char* RfSettings::rfAuthenticationSettingsName = "RFAuthentication";

RfSettings::RfSettings(QObject* parent)
    : SettingsGroup(rfSettingsGroupName, QString(), parent)
    , _rfAuthenticationFact(NULL)
    , _rfConfigPropName("persist.sys.d2d.auth.cfg")
{
    QQmlEngine::setObjectOwnership(this, QQmlEngine::CppOwnership);
    qmlRegisterUncreatableType<RfSettings>("QGroundControl.SettingsManager", 1, 0, "RfSettings", "Reference only");
}

Fact* RfSettings::rfAuthentication(void)
{
    if (!_rfAuthenticationFact) {
        _rfAuthenticationFact = _createSettingsFact(rfAuthenticationSettingsName);
        connect(_rfAuthenticationFact, &Fact::rawValueChanged, this, &RfSettings::_newRfAuthentication);
    }
    QString defValue = QString::fromLatin1("0");
    QString value = AndroidInterface::getSystemProperty(_rfConfigPropName, defValue);
    _rfAuthenticationFact->setRawValue(value.toInt());

    return _rfAuthenticationFact;
}

void RfSettings::_newRfAuthentication(QVariant value)
{
    uint index = value.toUInt();
    // set wifi
    QString countryCode[] = {"CN", "US", "FR", "CN", "JP"};
    WifiSettings* wifi = qgcApp()->toolbox()->settingsManager()->videoSettings()->videoShareSettings();
    if (wifi != NULL) {
        wifi->setCountryCode(countryCode[index], true);
    }
    // set d2d
    _setToD2dService(index);
}

void RfSettings::_setToD2dService(uint32_t value) {
    _localSocket.connectToServer("/tmp/qgccmd");
    if (!_localSocket.waitForConnected(1000))
    {
       qWarning() << "localSocket connectToServer failed.";
       return;
    }

    QString rfAuthCmdString = "QGCRFAUTHCFG:" + QString::number(value);
    uint32_t len = rfAuthCmdString.length();

    QByteArray byte;
    byte.append((0xff000000 & len) >> 24);
    byte.append((0x00ff0000 & len) >> 16);
    byte.append((0x0000ff00 & len) >> 8);
    byte.append(0x000000ff & len);
    byte.append(rfAuthCmdString.toLatin1());

    if((_localSocket.write(byte))!= byte.count())
    {
        qWarning() << "localSocket Send failed." ;
    }
    _localSocket.flush();
    _localSocket.disconnectFromServer();
}
