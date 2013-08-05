import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle {
  width: 400
  height: 400

  //パスの設定
  PathInterpolator {
    id: motion
    //パス経路を定義
    path: Path {
      startX: 0; startY: 0
      PathSvg { path: "M 354.73987,318.58174 233.89218"
                      + ",291.22902 142.7555,374.86115 131.53376"
                      + ",251.95213 23.501033,191.47903 137.41329"
                      + ",142.86978 161.7821,21.863218 243.40548"
                      + ",114.73007 366.49896,100.41701 303.03272,206.42114 z" }
    }
    //パス上での現在地を移動させる
    NumberAnimation on progress {
      loops: Animation.Infinite
      from: 0
      to: 1
      duration: 5000
    }
  }
  //パスと同じ絵で見えるようにする
//  Image {
//    width: 410
//    height: 410
//    smooth: true
//    opacity: 0.5
//    source: "images/star-bg.png"
//  }
  //パスにそって移動する星
  Image {
    id: star
    width: 50; height: 50
    source: "images/star.png"
    //パスの座標にバインドする
    x: motion.x - width / 2
    y: motion.y - height / 2
    //パスに沿った向きにもできる
//    rotation: motion.angle
    //くるくる回す
    NumberAnimation on rotation {
      loops: Animation.Infinite
      from: 0
      to: 360
      duration: 2000
      easing.type: Easing.InOutQuad
    }
  }

  //パーティクル
  ParticleSystem {
    id: particles
    ImageParticle {
      source: "images/star.png"
      opacity: 0.5
      rotationVariation: 360
    }
  }
  //星が通った位置に置いていく
  Emitter {
    anchors.centerIn: star
    system: particles
    emitRate: 10
    lifeSpan: 4000
    size: 24
    endSize: 0
  }
}
