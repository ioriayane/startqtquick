include(../QGalleryPlugin/qgalleryplugin.pri)

# Add more folders to ship with the application, here
CONFIG(release, release|debug){
}else{
folder_01.source = qml/QGallery
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01
}

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp

# Installation path
# target.path =

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

# icon
win32{
    RC_FILE = QGallery.rc
}
mac{
    ICON = QGallery.icns
}

CONFIG(release, release|debug){
RESOURCES += \
    QGallery.qrc
}
