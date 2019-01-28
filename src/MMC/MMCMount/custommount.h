#ifndef CUSTOMMOUNT_H
#define CUSTOMMOUNT_H

#include "mountinfo.h"
class Vehicle;

class CustomMount : public MountInfo
{
    Q_OBJECT
public:
    CustomMount(Vehicle* vehicle);

    int     mountType(void) const final { return MOUNT_CUSTOM; }
    void    handleInfo(const can_data& data){ Q_UNUSED(data); }
    void    saveJson(QJsonObject& dataJson);
private:
    int readId() const final { return mountType(); }
};

#endif // CUSTOMMOUNT_H
