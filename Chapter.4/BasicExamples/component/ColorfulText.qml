import QtQuick 2.0

Rectangle {
  //背景のサイズは文字列より少し大きめにする
  width: text.contentWidth * 1.1
  height: text.contentHeight * 1.1
  //なめらかに描画する
  antialiasing: true
  //独自のプロパティを定義
  property string text: ""              //表示文字列
  property alias foreColor: text.color  //フォント色
  property alias font: text.font        //フォント
  //文字列
  Text {
    id: text
    anchors.centerIn: parent
    text: parent.text
  }
  //明るくする
  function lighter(){
    color = Qt.lighter(color);
  }
}
