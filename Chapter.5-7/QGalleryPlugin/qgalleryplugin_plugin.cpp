#include "qgalleryplugin_plugin.h"
#include "thumbnailprovider.h"
#include "operatingsystem.h"
#include <qqml.h>

void QGalleryPluginPlugin::registerTypes(const char *uri)
{
  // @uri com.example.qgalleryplugin
  qmlRegisterType<OperatingSystem>("com.example.qgalleryplugin.operatingsystem", 1, 0, "OperatingSystem");
}

void QGalleryPluginPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
  engine->addImageProvider("thumbnail", new ThumbnailProvider);
}
