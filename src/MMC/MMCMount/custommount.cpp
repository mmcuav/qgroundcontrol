#include "custommount.h"

CustomMount::CustomMount(Vehicle *vehicle)
    : MountInfo(vehicle)
{

}

void CustomMount::saveJson(QJsonObject &dataJson)
{
    MountInfo::saveJson(dataJson);
}
