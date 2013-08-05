import QtQuick 2.0

Rectangle {
  //横幅は仮の値
  width: 100
  //高さは内容（文字列）に合わせて調節
  height: text.contentHeight * 2
  //枠線がないと境目がわからない
  border.color: "LightGray"
  border.width: 1
  //マウスが押されているとき色を変更する
  color: mouse.pressed ? "Tomato" : "White"
  //モデルから情報を受取るプロパティを追加
  property string value: ""       // [1]

  Text {
    id: text
    anchors.centerIn: parent
    font.pointSize: 14
    //プロパティの内容を表示
    text: value
  }
  MouseArea {
    id: mouse
    anchors.fill: parent
    onClicked: {
      //デリゲートの中で使われることを見越してindexを使用
      text.text = index + ":" + value
    }
  }
}
