import QtQuick 2.0
import "components"

Row {
  id: root
  //個々のボタンはこの高さに合わせる
  height: 50
  //内側のエレメントの隙間を指定
  spacing: 5
  //再生状態を受ける
  property bool playing: false
  //ローカルとWeb表示の切り替えフラグ
  property bool webMode: false
  //ボタン操作時のシグナルを定義
  signal previousClicked()    //前へ
  signal playClicked()        //再生
  signal pauseClicked()       //一時停止
  signal stopClicked()        //停止
  signal nextClicked()        //次へ

  //前へボタン
  ImageButton {
    id: buttonPrevious
    width: 50
    height: parent.height
    //背景と表示画像
    backImage: "resources/button_border.png"
    foreImage: "resources/button_previous.png"
    //クリックでシグナル通知
    onClicked: root.previousClicked()
  }
  //再生・一時停止ボタン
  ImageButton {
    id: buttonPlay
    width: 70
    height: parent.height
    //背景と表示画像
    backImage: "resources/button_border.png"
    foreImage: "resources/button_play.png"
    //クリックでシグナル通知
    onClicked: {
      if(playing){
        root.pauseClicked();
      }else{
        root.playClicked();
      }
    }
  }
  //停止ボタン
  ImageButton {
    id: buttonStop
    width: 70
    height: parent.height
    //背景と表示画像
    backImage: "resources/button_border.png"
    foreImage: "resources/button_stop.png"
    //クリックでシグナル通知
    onClicked: root.stopClicked()
  }
  //次へボタン
  ImageButton {
    id: buttonNext
    width: 50
    height: parent.height
    //背景と表示画像
    backImage: "resources/button_border.png"
    foreImage: "resources/button_next.png"
    //クリックでシグナル通知
    onClicked: root.nextClicked()
  }
  //Webへ切り替えボタン
  ImageButton {
    id: buttonWeb
    width: 40
    height: parent.height
    //背景画像
    backImage: "resources/button_border.png"
    //キャプション
    caption: !webMode ? qsTr("Web") : qsTr("Local")
    captionColor: "#deffff"
    captionFontSize: 10
    //クリックでシグナル通知
    onClicked: {
      //表示状態を反転する
      webMode = !webMode;
    }
  }
  //状態管理
  states:[
    State {
      //再生中のとき一時停止を表示する
      name: "playing"
      when: playing
      PropertyChanges {
        target: buttonPlay
        foreImage: "resources/button_pause.png"
      }
    }
  ]
}
