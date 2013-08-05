import QtQuick 2.0

Rectangle {
  width: 100
  height: 200
  //リスト表示
  ListView {
    id: list
    anchors.fill: parent
    //表示用データ（モデル）
    model: ListModel {                   // [1]
      //データのまとまりを登録する
      ListElement { value: "Item1" }   // [2]
      ListElement { value: "Item2" }
      ListElement { value: "Item3" }
      ListElement { value: "Item4" }
      ListElement { value: "Item5" }
      ListElement { value: "Item6" }
      ListElement { value: "Item7-1\nItem7-2" }    // [3]
      ListElement { value: "Item8" }
      ListElement { value: "Item9" }
    }
    //レイアウトのテンプレート
    delegate: Rectangle {                // [4]
      //横幅はListViewと同じ
      width: list.width
      //高さは内容（文字列）に合わせて調節
      height: text.contentHeight * 2
      //枠線がないと境目がわからない
      border.color: "LightGray"
      border.width: 1
      //マウスが押されているとき色を変更する
      color: mouse.pressed ? "Tomato" : "White"
      Text {
        id: text
        anchors.centerIn: parent
        font.pointSize: 14
        //モデルの値を表示する
        text: model.value           // [5]
      }
      //レイアウトごとでマウス入力を受け付ける
      MouseArea {
        id: mouse
        anchors.fill: parent
        onClicked: {
          //クリックされたら内容に項目のインデックスを追加する
          text.text = "%1 : %2".arg(index).arg(model.value)  // [6]
        }
      }
    }
  }
}
