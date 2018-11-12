/****************************************************************************
 *
 * Copyright (C) 2018 Pinecone Inc. All rights reserved.
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

#pragma once

#include <QObject>
#include "LinkInterface.h"
#include "QGCMAVLink.h"

class MAVLinkProtocol;

class SystemMessageHandler : public QObject
{
    Q_OBJECT
public:
    SystemMessageHandler(MAVLinkProtocol* protocol);

private slots:
    void _receiveMessage(LinkInterface* link, mavlink_message_t message);

private:
    void _handleTimeSyncMessage(LinkInterface* link, mavlink_message_t& message);

    MAVLinkProtocol* _mavlinkProtocol;
};
