import QtQuick 2.0

AnimatedSprite {
  id: root
  width: 80
  height: 110

  source: "images/cat.png"
  frameCount: 20          //フレーム数            // [1]
  frameDuration: 500      //1フレームあたりの時間    // [2]
  interpolate: false      //フレーム間補正停止     // [3]
  loops: 1                //1回だけ
  onPausedChanged: console.debug(paused)

  //最後のフレームに来たら透明になる
  onCurrentFrameChanged: {                    // [4]
    if(currentFrame == (frameCount - 1)){
      animation.start()
    }
  }
  //アニメーションで透明になりきったら自滅する
  NumberAnimation {
    id: animation
    target: root
    property: "opacity"
    to: 0
    duration: 1000
    onStopped: root.destroy()              // [5]
  }
}
