import QtQuick 2.0
import "component"

Rectangle {
  id: root
  width: buttons.width
  height: 200

  //ボタンを横方向へ並べる
  Row {
    id:buttons
    Button {
      caption: "complete"
      onClicked: anim.complete()
    }
    Button {
      caption: "pause"
      onClicked: anim.pause()
    }
    Button {
      caption: "restart"
      onClicked: anim.restart()
    }
    Button {
      caption: "resume"
      onClicked: anim.resume()
    }
    Button {
      caption: "start"
      onClicked: anim.start()
    }
    Button {
      caption: "stop"
      onClicked: anim.stop()
    }
  }
  //プロパティの状態表示
  Text {
    anchors.top: buttons.bottom
    text: "running : %1, paused : %2".arg(anim.running).arg(anim.paused)
  }
  //アニメーションの制御対象
  Rectangle {
    id: rect
    anchors.verticalCenter: parent.verticalCenter
    //描画領域の1割のサイズにする
    width: root.width * 0.1
    height: root.height * 0.1
    color: "Tomato"
    //横方向へアニメーション
    NumberAnimation {
      id: anim
      target: rect                //対象指定
      property: "x"               //x座標のみ動かす
      from: 0                     //開始位置は左端
      to: root.width * 0.9        //終了位置は四角形の幅を考慮した位置まで移動
      loops: Animation.Infinite   //無限ループ
      duration: 2000              //2秒で移動
      //プロパティが変化したらログを出力
      onRunningChanged: console.debug("Running:" + running)
      onPausedChanged: console.debug("Paused:" + paused)
    }
  }
}
