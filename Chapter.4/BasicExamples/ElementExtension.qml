import QtQuick 2.0
import "component"          // [1]

Rectangle {
  width: 200
  height: 100
  //作成した新しいエレメント
  ColorfulText {            // [2]
    id: text
    anchors.centerIn: parent
    //表示する文字列
    text: "Qt green"        // [3]
    //フォント色
    foreColor: "#ffffff"
    //背景色
    color: "#74b928"
    //フォントサイズ
    font.pointSize: 32
    //角を丸くする
    radius: 5
  }
  //明るくする
  MouseArea {
    //描画領域全体でクリックを受け付ける
    anchors.fill: parent
    //クリックしたときの処理
    onClicked: {
      text.lighter()
    }
  }
}
