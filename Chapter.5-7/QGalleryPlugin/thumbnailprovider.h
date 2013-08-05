#include <qqmlextensionplugin.h>
#include <qqmlengine.h>
#include <qquickimageprovider.h>
#include <QImage>
#include <QFile>

class ThumbnailProvider : public QQuickImageProvider
{
public:
  ThumbnailProvider()
    : QQuickImageProvider(QQuickImageProvider::Image
                          , QQuickImageProvider::ForceAsynchronousImageLoading)
  {
  }

  QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize)
  {
    int width = requestedSize.width() > 0 ? requestedSize.width() : 100;
    int height = requestedSize.height() > 0 ? requestedSize.height() : 100;

    if (size)
      *size = QSize(width, height);
    
    QImage image(id);
    if (!image.isNull())
      image = image.scaled(width, height, Qt::KeepAspectRatio);

    return image;
  }
};

