import QtQuick 2.0

Rectangle {
    width: 100
    height: 62

    property color a: Qt.rgba(1,1,1,1)
//    property color a: "green"
//    property color a: "#00ff00"
//    property font b: 0
    property vector2d e: Qt.vector2d(1,1)
    property vector3d f: Qt.vector3d(1,1,1)
    property vector4d g: Qt.vector4d(1,1,1,1)
    property quaternion d: Qt.quaternion(1,1,1,1)
    property matrix4x4 c: Qt.matrix4x4(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16)
    property date h: "2012-01-01"
//    property time i: "22:01:01"
    property point j: Qt.point(1,2)
//    property point j: "1,1"
    property size k: Qt.size(1,1)
    property rect l: Qt.rect(1,1,1,1)
    property int m: 0
    property bool n: false
    property real o: 0
    property double p: 0
    property string q: ""
    property url r: "http://qt-project.org/"
//    property list s: 0
    property var t: 0
//    property enumeration u: 0

    property string ss: "%1 %2".arg("hello").arg("world")
    onSsChanged: {
        console.debug(ss)
    }
}
