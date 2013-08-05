#ifndef QGALLERYPLUGIN_PLUGIN_H
#define QGALLERYPLUGIN_PLUGIN_H

#include <QQmlExtensionPlugin>

class QGalleryPluginPlugin : public QQmlExtensionPlugin
{
  Q_OBJECT
  Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
  void registerTypes(const char *uri);
  void initializeEngine(QQmlEngine *engine, const char *uri);
};

#endif // QGALLERYPLUGIN_PLUGIN_H
