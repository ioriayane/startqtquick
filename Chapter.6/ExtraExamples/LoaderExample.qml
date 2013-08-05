import QtQuick 2.0

Rectangle {
  id: root
  width: 100
  height: 62

  //文字をクリックで読み込み
  Text {
    id: text
    anchors.centerIn: parent
    text: loader.status == Loader.Ready ? "Ready!" : "Click me!"
//    text: loader.status == Loader.Ready ? "Click me!" : "Unload!"
    MouseArea {
      anchors.fill: parent
      onClicked: loader.sourceComponent = component
//      onClicked: loader.sourceComponent = undefined
//      onClicked: loader.source = "GradientExample.qml"
    }
  }
  //読み込むエレメントの定義
  Component {
    id: component
    Rectangle {
      color: "Tomato"
      opacity: 0.5
    }
  }
  //読み込む場所の定義
  Loader {
    id: loader
    anchors.fill: parent
//    sourceComponent: component
  }
}
