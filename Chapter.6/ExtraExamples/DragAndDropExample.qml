import QtQuick 2.0

Item {
  id: root
  width: 400
  height: 400
  Text {
    id: text
    font.pointSize: 14
    text: ""
  }
  //ドロップ先の定義
  DropArea {
    id: dropArea
    anchors.centerIn: parent
    width: 100
    height: 100
    //このキーが一致しないとドロップエリアが反応しない
//    keys: ["xaxis"]
    //ドロップエリアを可視化
    Rectangle {
      anchors.fill: parent
      color: "Plum"
      //ドロップエリアに入ったら透過度を調節
      opacity: parent.containsDrag ? 1.0 : 0.4
    }
    //シグナルのタイミングで表示
    onDropped: text.text = "dropped:" + drag.source.name
    onEntered: text.text = "entered:" + drag.source.name
    onExited: text.text = "exited:" + drag.source.name
  }
  //横方向のみドラッグできる
  Image {
    id: image
    //アンカーで場所を指定するとドラッグできない方向ができる
//    anchors.top: parent.top
    x: 0
    y: root.height / 2 - height / 2
    width: 50
    height: 50
    source: "images/star.png"
    //このキーが一致しないとドロップエリアが反応しない
//    Drag.keys: ["xaxis"]

    //ドロップ後に識別するための名称
    property string name: "x axis only"

    //ドラッグ機能を付加
    Drag.active: xAxisDrag.drag.active
    //ドロップとの当たり判定の位置
    Drag.hotSpot.x: width / 2
    Drag.hotSpot.y: height / 2
    //ドラッグに必要なマウス処理
    MouseArea {
      id: xAxisDrag
      anchors.fill: parent
      //ドラッグする対象を指定
      drag.target: parent
      //ドラッグできる方向を指定
      drag.axis: Drag.XAxis
      //離したときにドロップの処理を実行
      onReleased: parent.Drag.drop()

      //            //子のMouseAreaのシグナルを処理しつつドラッグも行う
      //            drag.filterChildren: true

      //            Rectangle {
      //                anchors.fill: parent
      //                color: "orange"
      //                opacity: 0.2
      //                MouseArea {
      //                    anchors.fill: parent
      //                    onPressed: console.log("Pressed")
      //                    onClicked: console.log("Clicked")
      //                }
      //            }
    }
  }
  //自由にドラッグできる
  Image {
    x: image.x
    y: root.height * 0.1
    width: 50
    height: 50
    source: "images/star.png"

    //ドロップ後に識別するための名称
    property string name: "free drag"

    //ドラッグ機能を付加
    Drag.active: freeDrag.drag.active
    //ドロップとの当たり判定の位置
    Drag.hotSpot.x: width / 2
    Drag.hotSpot.y: height / 2
    //ドラッグに必要なマウス処理
    MouseArea {
      id: freeDrag
      anchors.fill: parent

      //ドラッグする対象を指定
      drag.target: parent
      //ドラッグできる範囲を指定
      drag.minimumX: root.width * 0.1
      drag.maximumX: root.width * 0.9 - parent.width
      drag.minimumY: root.height * 0.1
      drag.maximumY: root.height * 0.9 - parent.height

      //離したときにドロップの処理を実行
      onReleased: parent.Drag.drop()
    }
  }
}
