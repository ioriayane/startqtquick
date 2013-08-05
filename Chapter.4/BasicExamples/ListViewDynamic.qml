import QtQuick 2.0

Rectangle {
  width: 100
  height: 200

  //リスト表示
  ListView {
    id: list
    anchors.fill: parent
    //表示用データ（動的に追加するので空）
    model: ListModel { id: listModel }  // [1]
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
        //モデルの値を表示する
        text: model.value               // [2]
      }
    }
  }
  MouseArea {
    anchors.fill: parent
    //登録数の総計をカウント
    property int counter: 0
    onPressed: {
      //10個を上限にする
      if(list.count >= 10){
        //10個登録済みだったら先頭を削除
        list.model.remove(0)            // [3]
      }
      //JSON形式でモデルへ追加
      listModel.append({"value": "append" + counter}) // [4]
      counter++
      //イベントを通過させる
      mouse.accepted = false
    }
  }
}
