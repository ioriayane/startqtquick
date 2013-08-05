import QtQuick 2.0

Rectangle {
    width: 360
    height: 360
    Text {
        anchors.centerIn: parent
        text: "Hello World"
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            console.time("onClicked");
            console.log("onClicked:log");
            console.debug("onClicked:debug");
            console.info("onClicked:info");
            console.warn("onClicked:warn");
            console.error("onClicked:error");
            console.timeEnd("onClicked");
//            Qt.quit();
        }
        onDoubleClicked: {
            console.log("onDoubleClicked:log");
            console.debug("onDoubleClicked:debug");
            console.info("onDoubleClicked:info");
            console.warn("onDoubleClicked:warn");
            console.error("onDoubleClicked:error");
            Qt.quit();
        }
    }
    Component.onCompleted: {
        console.debug("completed");
    }
}
