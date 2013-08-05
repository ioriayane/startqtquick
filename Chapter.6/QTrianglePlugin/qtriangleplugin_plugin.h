#ifndef QTRIANGLEPLUGIN_PLUGIN_H
#define QTRIANGLEPLUGIN_PLUGIN_H

#include <QQmlExtensionPlugin>

class QTrianglePluginPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")
    
public:
    void registerTypes(const char *uri);
};

#endif // QTRIANGLEPLUGIN_PLUGIN_H

