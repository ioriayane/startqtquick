import QtQuick 2.0

Rectangle {
  width: 200
  height: 200
  //ボタンをイメージした円
  Rectangle {
    id: circle
    anchors.centerIn: parent
    width: parent.width / 2
    height: parent.height / 2
    //角を丸くして円にする
    radius: width / 2
    //なめらかに描画する
    antialiasing: true
    //背景色
    color: "LightGray"
    //枠線の定義
    border.color: "DarkGray"
    border.width: 3
    //マウスイベント
    MouseArea {
      id: mouseArea
      anchors.fill: parent
      //処理するマウスのボタン
      acceptedButtons: Qt.LeftButton | Qt.RightButton
      //ホバーイベントを使用するか
      hoverEnabled: true
      //シグナルハンドラ              [1]
      onClicked: {
        switch(checkState.state){
        case "red":
          //赤から青へ変化
          checkState.state = "blue"
          console.debug("red -> blue")
          break
        case "blue":
          //青から赤へ変化
          checkState.state = ""
          console.debug("blue -> none")
          break
        case "":
          //初期状態（青）から赤へ変化
          checkState.state = "red"
          console.debug("none -> red")
          break
        default:
          break
        }
      }
    }
    //マウス操作に対する状態の定義            [2]
    StateGroup {
      states: [
        //マウスを押しているときの状態
        State {
          //遷移条件
          when: mouseArea.pressed
          //変更するプロパティ
          PropertyChanges {
            target: circle
            border.color: "DarkRed"
          }
        },
        //マウスが範囲内に入っているときの状態
        State {
          //遷移条件
          when: mouseArea.containsMouse
          //変更するプロパティ
          PropertyChanges {
            target: circle
            border.color: "MidnightBlue"
          }
        }
      ]
    }
    //チェック状態を管理する状態の定義        [3]
    StateGroup {
      id: checkState
      states: [
        //赤色の状態
        State {
          //状態名
          name: "red"             // [4]
          //変更するプロパティ
          PropertyChanges {
            target: circle
            color: "MistyRose"
          }
        },
        //青色の状態
        State {
          //状態名
          name: "blue"            // [5]
          //変更するプロパティ
          PropertyChanges {
            target: circle
            color: "AliceBlue"
          }
        }
      ]
    }
  }
}
