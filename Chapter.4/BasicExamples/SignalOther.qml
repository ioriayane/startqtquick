import QtQuick 2.0
import "component"

Rectangle {
  width: 200
  height: 200
  //エレメントを縦に並べる
  Column {
    anchors.centerIn: parent
    spacing: 10     //間隔を設定
    //ボタン1つ目
    Button {
      id: button1
      caption: "Button1"
      onClicked: {                            // [1]
        console.debug("click " + caption)
      }
    }
    //ボタン2つ目
    Button {
      id: button2
      caption: "Button2"
      onClicked: {
        console.debug("click " + caption)
      }
    }
  }
}
