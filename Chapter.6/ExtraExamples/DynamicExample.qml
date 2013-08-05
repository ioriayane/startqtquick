import QtQuick 2.0

Rectangle {
  id: container
  width: 300
  height: 300

  //ドロップ先の定義
  DropArea {
    id: dropArea
    anchors.fill: parent
    //ドロップしたらオブジェクトを生成
    onDropped: {
      var component = Qt.createComponent("SelfDestroyingItem.qml")  // [1]
      var object = component.createObject(container)                // [2]
      //ドラッグしたテンプレートと同じ位置にする
      object.x = drag.source.x        // [3]
      object.y = drag.source.y
      //テンプレートは元の位置に戻して一番手前にする
      drag.source.x = 0
      drag.source.y = 0
      drag.source.z = object.z + 1    // [4]
    }
  }
  //テンプレートとしての画像
  Image{
    source: "images/cat_entry.png"
    //ドラッグ機能を付加
    Drag.active: dragArea.drag.active
    Drag.hotSpot.x: width / 2
    Drag.hotSpot.y: height / 2
    //ドラッグに必要なマウス処理
    MouseArea {
      id: dragArea
      anchors.fill: parent
      //ドラッグする対象を指定
      drag.target: parent
      //離したときにドロップの処理を実行
      onReleased: parent.Drag.drop()
    }
  }
}
