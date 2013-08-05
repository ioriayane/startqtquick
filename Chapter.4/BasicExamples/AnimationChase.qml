import QtQuick 2.0

Rectangle {
  width: 360
  height: 360
  color: "#000000"
  //移動する四角
  Rectangle {
    id: rect
    x: 50
    y: 50
    width: 50
    height: 50
    radius: 10
    antialiasing: true
    color: "RoyalBlue"
    //xが変化したらアニメーション開始
    Behavior on x {
      NumberAnimation {
        //0.5秒で移動する
        duration: 500
        //バウンドするような動きをつける
        easing.type: Easing.OutBounce
      }
    }
    //yが変化したらアニメーション開始
    Behavior on y {
      NumberAnimation {
        //0.5秒で移動する
        duration: 500
        //バウンドするような動きをつける
        easing.type: Easing.OutBounce
      }
    }
  }
  //移動先を決める
  MouseArea {
    anchors.fill: parent
    onClicked: {
      //移動先の座標を指定する
      rect.x = mouse.x - rect.width / 2
      rect.y = mouse.y - rect.height / 2
    }
  }
}
