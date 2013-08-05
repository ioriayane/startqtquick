include(qgalleryplugin.pri)

TEMPLATE = lib
TARGET = QGalleryPlugin
CONFIG += qt plugin

TARGET = $$qtLibraryTarget($$TARGET)
uri = jp.xii.relog.qgalleryplugin

# Input
SOURCES += \
    qgalleryplugin_plugin.cpp

HEADERS += \
    qgalleryplugin_plugin.h

OTHER_FILES = qmldir


!equals(_PRO_FILE_PWD_, $$OUT_PWD) {
    copy_qmldir.target = $$OUT_PWD/qmldir
    copy_qmldir.depends = $$_PRO_FILE_PWD_/qmldir
    copy_qmldir.commands = $(COPY_FILE) \"$$replace(copy_qmldir.depends, /, $$QMAKE_DIR_SEP)\" \"$$replace(copy_qmldir.target, /, $$QMAKE_DIR_SEP)\"
    QMAKE_EXTRA_TARGETS += copy_qmldir
    PRE_TARGETDEPS += $$copy_qmldir.target
}

qmldir.files = qmldir
unix {
    installPath = $$[QT_INSTALL_IMPORTS]/$$replace(uri, \\., /)
    qmldir.path = $$installPath
    target.path = $$installPath
    INSTALLS += target qmldir
}

