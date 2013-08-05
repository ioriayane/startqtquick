import QtQuick 2.0

Rectangle {
  id: root
  width: 100
  height: 62
  //背景色
  color: "LightBlue"
  //枠線の設定
  border.color: "DarkGray"
  border.width: 1
  //プロパティの定義
  property alias caption: caption.text
  //シグナルの定義
  signal clicked(string caption)    // [1]
  //ボタンのキャプション
  Text {
    id: caption
    anchors.centerIn: parent
  }
  //マウスイベント
  MouseArea {
    anchors.fill: parent
    onClicked: {
      root.clicked(caption.text)    // [2]
    }
  }
}
