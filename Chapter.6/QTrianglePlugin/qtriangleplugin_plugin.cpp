#include "qtriangleplugin_plugin.h"
#include "triangle.h"

#include <qqml.h>

void QTrianglePluginPlugin::registerTypes(const char *uri)
{
    // @uri com.example.qtriangleplugin
    qmlRegisterType<Triangle>(uri, 1, 0, "Triangle");
}


