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
    color: "LightSkyBlue"
    border.color: "DarkGray"
    border.width: 3
    //マウスイベント
    MouseArea {
      id: mouseArea
      anchors.fill: parent
      //ホバーイベントを使用する
      hoverEnabled: true
    }
    //状態の定義
    states: [
      //マウスを押しているときの状態
      State {
        //状態名
//        name: "pressed"
        //遷移条件
        when: mouseArea.pressed
        //変更するプロパティ（赤くする）
        PropertyChanges {
          target: rect
          color: "Crimson"
          border.color: "DarkRed"
        }
      },
      //マウスが範囲内に入っているときの状態
      State {
        //状態名
//        name: "hover"
        //遷移条件
        when: mouseArea.containsMouse
        //変更するプロパティ（青くする）
        PropertyChanges {
          target: rect
          color: "RoyalBlue"
          border.color: "MidnightBlue"
        }
      }
    ]
    //状態の変化に合わせてアニメーション
    transitions: [
      Transition {
//        from: "hover"
//        to: "pressed"
        //色の変化をアニメーションする
        ColorAnimation {
          target: rect
          property: "color"
          duration: 200
        }
      }
    ]
  }
}
