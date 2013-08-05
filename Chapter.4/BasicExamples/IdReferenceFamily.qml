import QtQuick 2.0

Rectangle {
  id: root
  width: 200
  height: 200
  color: "Plum"
  Rectangle {
    id: rect
    anchors.centerIn: parent
    width: 50
    height: 50
    color: "Orange"
  }
  //子エレメント
  IdReferenceChild {
  }
}
