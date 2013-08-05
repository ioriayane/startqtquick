#include <QtGui/QGuiApplication>
#include <QtCore/QTranslator>
#include <QtCore/QLocale>
#include "qtquick2applicationviewer.h"
#include "thumbnailprovider.h"
#include "operatingsystem.h"

int main(int argc, char *argv[])
{
  QGuiApplication app(argc, argv);

#if defined(Q_OS_MAC) && !defined(QT_NO_DEBUG)
  //Mac OS X用のパスを作成する
  QString dir = QString("%1/../Resources/qml/QGallery/i18n")
                .arg(QCoreApplication::applicationDirPath());
#else
  //WindowsとLinux用のパスを作成する
  QString dir("qml/QGallery/i18n");
#endif
  QTranslator translator;
  //言語ファイルの読み込み
  translator.load(QString("qml_%1" ).arg(QLocale::system().name()), dir);
  //言語データを登録する
  app.installTranslator(&translator);

  //プラグインを登録（setMainQmlFileより前に）
  qmlRegisterType<OperatingSystem>("com.example.qgalleryplugin.operatingsystem"
                                   , 1, 0, "OperatingSystem");

  QtQuick2ApplicationViewer viewer;
  //プラグインを登録（setMainQmlFileの前であること）
  viewer.engine()->addImageProvider(QStringLiteral("thumbnail")
                                    , new ThumbnailProvider);
#if defined(QT_NO_DEBUG)
  //リリース時はリソースを使用する
  viewer.setSource(QUrl("qrc:///qml/QGallery/main.qml"));
#else
  //デバッグ時は通常のQMLファイルを使用する
  viewer.setMainQmlFile(QStringLiteral("qml/QGallery/main.qml"));
#endif
  viewer.showExpanded();

  return app.exec();
}
