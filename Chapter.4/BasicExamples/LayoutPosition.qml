import QtQuick 2.0

Rectangle {
  //描画領域のサイズ
  width: 360
  height: 360
  //相対位置に配置する文字列
  Text {
    //親エレメントの縦横2割の位置に配置する
    x: parent.width * 0.2
    y: parent.height * 0.2
    //表示するメッセージ
    text: "Layout Relative Position"
  }
}
