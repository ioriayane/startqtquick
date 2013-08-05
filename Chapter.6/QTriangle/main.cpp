#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include "triangle.h"

int main(int argc, char *argv[])
{
  QGuiApplication app(argc, argv);

  qmlRegisterType<Triangle>("com.example.qtriangleplugin", 1, 0, "Triangle");

  QtQuick2ApplicationViewer viewer;
  viewer.setMainQmlFile(QStringLiteral("qml/QTriangle/main.qml"));
  viewer.showExpanded();

  return app.exec();
}
