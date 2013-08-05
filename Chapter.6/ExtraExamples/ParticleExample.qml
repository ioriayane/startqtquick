import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle {
  width: 300
  height: 300
  color: "#000022"
  //パーティクル
  ParticleSystem {
    anchors.fill: parent
    //パーティクルの素
    ImageParticle {
      source: "images/star.png"
      colorVariation: 0.5             //色の変化量
      rotationVelocityVariation: 100  //回転速度の変化量
    }
    //パーティクルの発生源
    Emitter {
      anchors.centerIn: parent
      emitRate: 20                    //１秒間の発生数
      lifeSpan: 3000                  //生存時間
      //加速
      acceleration: AngleDirection {
        angleVariation: 180           //角度の変化量
        magnitude: 80                 //大きさ
        magnitudeVariation: 40        //大きさの変化量
      }
      size: 0                         //サイズ
      endSize: 50                     //最終サイズ
      sizeVariation: 4                //サイズの変化量
    }
  }
}
