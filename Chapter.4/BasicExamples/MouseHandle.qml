import QtQuick 2.0

Rectangle {
  width: 200
  height: 200
  //シグナルの到達を確認する
  MouseArea {
    anchors.centerIn: parent
    width: parent.width / 2
    height: parent.height / 2
    //すべてのボタンを受け付ける
    acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
    //クリックのみ受け付ける
    onClicked: console.debug("click under element")
  }
  //マウスエリアの可視化用
  Rectangle {
    anchors.centerIn: parent
    width: parent.width / 2
    height: parent.height / 2
    radius: 10
    antialiasing: true
    //背景色（マウスカーソルが乗っていると濃い青になる）
    color: mouseArea.containsMouse ? "RoyalBlue" : "LightSkyBlue" // [1]
    //枠線の定義（マウスがダウン状態のとき赤くなる）
    border.color: mouseArea.pressed ? "Red" : "DarkGray"          // [2]
    border.width: 3
    //マウスイベント
    MouseArea {
      id: mouseArea
      anchors.fill: parent
      //処理するマウスのボタン
      acceptedButtons: Qt.LeftButton | Qt.RightButton     // [3]
      //ホバーイベントを使用するか
      hoverEnabled: true                                  // [4]
      //シグナルハンドラ
      onCanceled: console.debug("canceled")
      onClicked: console.debug("click(" + mouse.x + "," + mouse.y + ")")
      onDoubleClicked: console.debug("double click")
      onEntered: console.debug("entered")
      onExited: console.debug("exited")
      onPositionChanged: console.debug("position changed("
                                       + mouse.x + "," + mouse.y + ")")
      onPressAndHold: console.debug("press and hold")
      onPressed: {
        console.debug("pressed")
        //                mouse.accepted = false
      }
      onReleased: console.debug("released")
      onWheel: console.debug("wheel")
    }
  }
  //MouseAreaの状態を表示
  Column {
    Text { text: "containsMouse=" +  mouseArea.containsMouse    }
    Text { text: "pressed=" +  mouseArea.pressed    }
    Text { text: "pressedButtons=" + mouseArea.pressedButtons  }
  }
}
