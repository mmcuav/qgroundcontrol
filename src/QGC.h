/****************************************************************************
 *
 *   (c) 2009-2016 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/


#ifndef QGC_H
#define QGC_H

#include <QDateTime>
#include <QColor>
#include <QThread>

#include "QGCConfig.h"

#define GENERATE_QML_PROPERTY(Name,Type,comment) \
    public : \
Q_PROPERTY(Type Name READ Name WRITE set_##Name NOTIFY Name##Changed) \
Q_PROPERTY(QString Name##Comment READ Name##Comment CONSTANT) \
    private : \
        Type _##Name; \
    public : \
        Type Name() const{return _##Name;} \
        void set_##Name(Type value){ if(_##Name == value) return; \
            _##Name = value; \
         emit Name##Changed(); } \
        QString Name##Comment() const{return tr(comment);} \
    Q_SIGNALS : \
        void Name##Changed();

#define GENERATE_QML_PROPERTY_ONSET(Name,Type,comment) \
    public : \
Q_PROPERTY(Type Name READ Name WRITE set_##Name NOTIFY Name##Changed) \
Q_PROPERTY(QString Name##Comment READ Name##Comment CONSTANT) \
    private : \
        Type _##Name; \
    public : \
        Type Name() const{return _##Name;} \
        void set_##Name(Type value); \
        QString Name##Comment() const{return tr(comment);} \
    Q_SIGNALS : \
        void Name##Changed();

namespace QGC
{

/**
 * @brief Get the current ground time in microseconds.
 * @note This does not have microsecond precision, it is limited to millisecond precision.
 */
quint64 groundTimeUsecs();
/** @brief Get the current ground time in milliseconds */
quint64 groundTimeMilliseconds();
/** 
 * @brief Get the current ground time in fractional seconds
 * @note Precision is limited to milliseconds.
 */
qreal groundTimeSeconds();
/** @brief Returns the angle limited to -pi - pi */
float limitAngleToPMPIf(float angle);
/** @brief Returns the angle limited to -pi - pi */
double limitAngleToPMPId(double angle);

const static int MAX_FLIGHT_TIME = 60 * 60 * 24 * 21;

class SLEEP : public QThread
{
    Q_OBJECT
public:
    using QThread::sleep;
    using QThread::msleep;
    using QThread::usleep;
};

quint32 crc32(const quint8 *src, unsigned len, unsigned state);

//------------------------------------------------------------------------------
//--函数名：  mount_crc
//--函数功能：软件cr8校验
//--输入参数： ptr，len
//--输出参数： crc
//------------------------------------------------------------------------------
unsigned char mount_crc(unsigned char *ptr, unsigned char len);

}

#define QGC_EVENTLOOP_DEBUG 0

#endif // QGC_H
