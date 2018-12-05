#ifndef JOYSTICKANDROID_H
#define JOYSTICKANDROID_H

#include "Joystick.h"
#include "Vehicle.h"
#include "MultiVehicleManager.h"
#include "JoystickManager.h"

#include <jni.h>
#include <QtCore/private/qjni_p.h>
#include <QtCore/private/qjnihelpers_p.h>
#include <QtAndroidExtras/QtAndroidExtras>
#include <QtAndroidExtras/QAndroidJniObject>


class JoystickAndroid : public Joystick, public QtAndroidPrivate::GenericMotionEventListener, public QtAndroidPrivate::KeyEventListener
{
public:
    JoystickAndroid(const QString& name, int axisCount, int buttonCount, int id, MultiVehicleManager* multiVehicleManager, JoystickManager* joystickManager);
    ~JoystickAndroid();

    static QMap<QString, Joystick*> discover(MultiVehicleManager* _multiVehicleManager, JoystickManager* _joystickManager);

private:
    bool handleKeyEvent(jobject event);
    bool handleGenericMotionEvent(jobject event);

    virtual bool _open();
    virtual void _close();
    virtual bool _update();

    virtual bool _getButton(int i);
    virtual int _getAxis(int i);
    virtual uint8_t _getHat(int hat,int i);
    void handleKeyEventInner(int keycode, int action);
    int getKeyIndexByCode(int code);
    void sendChannelValue(int ch, int value);
    bool getChannelValue(int keyCode, KeyConfiguration::KeyAction_t action, int *ch, int *value);

    int *btnCode;
    int *axisCode;
    bool *btnValue;
    int *axisValue;

    enum Keys {
        KEY_A = 0,
        KEY_B,
        KEY_C,
        KEY_D,
        KEY_MAX
    };

    typedef struct {
        quint64 startTime;
        bool isPressed;
        bool isLongPress;
    } KeyState_t;

    KeyState_t _keyEvents[KEY_MAX];
    int _keyCodes[KEY_MAX];

    static void _initStatic();
    static int * _androidBtnList; //list of all possible android buttons
    static int _androidBtnListCount;

    static int ACTION_DOWN, ACTION_UP;

    static int KEYCODE_A;//button A
    static int KEYCODE_B;//button B
    static int KEYCODE_C;//button C
    static int KEYCODE_D;//button D
    static QMutex m_mutex;

    int deviceId;
};

#endif // JOYSTICKANDROID_H
