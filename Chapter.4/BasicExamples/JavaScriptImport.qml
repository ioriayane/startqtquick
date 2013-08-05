import QtQuick 2.0
import "JavaScriptExternal.js" as Js          // [1]

Rectangle {
  width: 100
  height: 62
  border.color: "LightGray"
  border.width: 1
  //表示
  Text {
    id: text
    anchors.centerIn: parent
    text: "count"
    //表示を更新する
    function update(){
      text.text = "count=" + Js.getCounter()  // [2]
    }
  }
  //クリック
  MouseArea {
    anchors.fill: parent
    //クリックしたら表示を更新する
    onClicked: text.update()
  }
}

