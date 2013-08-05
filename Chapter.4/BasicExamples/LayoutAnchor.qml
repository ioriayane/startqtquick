import QtQuick 2.0

Rectangle {
  width: 300
  height: 300

  //マージンを指定した配置
  Rectangle {
    id: rect1
    anchors.left: parent.left
    anchors.top: parent.top
    anchors.leftMargin: 10
    anchors.topMargin: 10
    color: "lightGray"
    width: 100
    height: 100
    //rect1の中心に配置
    Rectangle {
      id: rect2
      anchors.centerIn: parent        // [1]
      color: "Gray"
      width: 40
      height: 40
    }
  }
  //rect1の右下に配置
  Rectangle {
    id: rect3
    anchors.top: rect1.bottom
    anchors.left: rect1.right
    color: "lightGray"
    width: 150
    height: 150
  }
  //rect3の横方向の中心と縦方向の中心に配置
  Rectangle {
    id: rect4
    anchors.horizontalCenter: rect3.horizontalCenter    // [2]
    anchors.verticalCenter: rect3.verticalCenter
    color: "Gray"
    width: 80
    height: 80
    //親(rect4)の全体に配置
    Rectangle {
      id: rect5
      anchors.fill: parent        // [3]
      color: "Black"
    }
  }
}
