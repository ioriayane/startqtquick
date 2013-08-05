import QtQuick 2.0

Rectangle {
  width: 100
  height: 200
  //リスト表示
  ListView {
    id: list
    anchors.fill: parent
    //表示用データ（配列）
    model: [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
    //レイアウトのテンプレート
    delegate: Rectangle {
      //横幅はListViewと同じ
      width: list.width
      //高さは内容（文字列）に合わせて調節
      height: text.contentHeight * 2
      //枠線がないと境目がわからない
      border.color: "LightGray"
      border.width: 1
      Text {
        id: text
        anchors.centerIn: parent
        font.pointSize: 14
        //項目のインデックスとレイアウトに割り当てたら配列の要素を表示する
        text: index + " : " + model.modelData   // [1]
      }
    }
  }
}
