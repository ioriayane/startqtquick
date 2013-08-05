import QtQuick 2.0

Rectangle {
  width: 200
  height: 200
  //ボタンをイメージした四角
  Rectangle {
    id: rect
    anchors.centerIn: parent
    width: parent.width / 2
    height: parent.height / 2
    radius: 10
    antialiasing: true
    //背景色
    color: "LightSkyBlue"       // [1]
    //枠線の定義
    border.color: "DarkGray"    // [2]
    border.width: 3
    //マウスイベント
    MouseArea {
      id: mouseArea
      anchors.fill: parent
      //処理するマウスのボタン
      acceptedButtons: Qt.LeftButton | Qt.RightButton
      //ホバーイベントを使用するか
      hoverEnabled: true
      //シグナルハンドラ
      onClicked: console.debug("click(" + mouse.x + "," + mouse.y + ")")
    }
    //状態の定義
    states: [                      // [3]
      //マウスを押しているときの状態
      State {
        //遷移条件
        when: mouseArea.pressed
        //変更するプロパティ
        PropertyChanges {          // [4]
          target: rect
          color: "Crimson"
          border.color: "DarkRed"
        }
      },
      //マウスが範囲内に入っているときの状態
      State {
        //遷移条件
        when: mouseArea.containsMouse
        //変更するプロパティ
        PropertyChanges {
          target: rect
          color: "RoyalBlue"
          border.color: "MidnightBlue"
        }
      }
    ]
  }
}
