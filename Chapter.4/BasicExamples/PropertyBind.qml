import QtQuick 2.0

Rectangle {
  //エレメントと一意に特定する名前
  id: root                              // [1]
  //ルートエレメントのサイズがウインドウサイズに影響する
  width: 360
  height: 160
  //文字列の背景用の四角形
  Rectangle {
    id: rect
    //親の中心に配置
    anchors.centerIn: parent
    //文字列を基準にサイズを決める
    width: text.contentWidth * 1.1      // [2]
    height: text.contentHeight * 1.1    // [3]
    //色を赤にする
    color: "red"
    //文字列
    Text {
      id: text
      //親の中心に配置
      anchors.centerIn: parent
      text: "Hello World"
      //フォントサイズをルートエレメントの高さを基準に決める
      font.pixelSize: root.height * 0.3 // [4]
    }
  }
  //マウス操作
  MouseArea {
    //親全体に配置
    anchors.fill: parent
    //クリックイベント
    onClicked: {
      //文字列のフォントサイズを変更する
      text.font.pixelSize = 20
    }
  }
}
