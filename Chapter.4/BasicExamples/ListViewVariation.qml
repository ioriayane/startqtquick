import QtQuick 2.0

Rectangle {
  width: 100
  height: 200
  //リスト表示
  ListView {
    id: list
    anchors.fill: parent
    //表示用データ（モデル）
    model: ListViewModel {}
    //レイアウトのテンプレート
    delegate: ListViewDelegate {
      //横幅は外から指定する
      width: list.width       // [1]
      //モデルの値を表示する
      value: model.value      // [2]
    }
  }
}
