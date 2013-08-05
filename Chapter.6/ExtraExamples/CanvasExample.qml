import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle {
  id: root
  width: 300
  height: 300
  color: "#000000"
  Component.onCompleted: {
    //画像を読み込み開始
    canvas.catImage = "images/cat_entry.png"
    canvas.loadImage(canvas.catImage)
  }

  //絵を描く
  Canvas {
    id:canvas
    anchors.fill: parent

    renderTarget: Canvas.Image
    renderStrategy: Canvas.Immediate
    antialiasing: true

    //パーティクルと連携するためのプロパティ [1]
    property real centerX: width / 2          //原点の位置
    property real centerY: height / 2         //原点の位置
    property real imageWidth: 80              //画像の幅
    property real imageHeight: 110            //画像の高さ
    property string catImage: ""              //読み込み用
    property real rotate : 0                  //魔法陣の回転角度
    property real radius: width / 4           //魔法陣の半径
    property real yPos: -canvas.imageHeight/2 //魔法陣を移動させるための座標
    property real yScaleRate: 0.3             //拡縮率

    //プロパティの変更イベントで再描画させる [2]
    onRotateChanged:requestPaint()

    //アニメーション [3]
    ParallelAnimation {
      running: true
      //回転
      NumberAnimation {
        target: canvas
        property: "rotate"
        from: 0
        to: Math.PI / 4
        duration: 1800
        loops: Animation.Infinite
      }
      //下へ移動
      SequentialAnimation {
        //下へ移動する前のタメ
        PauseAnimation { duration: 1800 }
        //下へ移動する
        NumberAnimation {
          target: canvas
          property: "yPos"
          from: -canvas.imageHeight / 2
          to: canvas.imageHeight / 2 - 1
          duration: 1800
        }
      }
    }
    //描画処理 [4]
    onPaint: {
      var rad = rotate
      var x = 0
      var y = yPos / yScaleRate
      var r = radius
      var ctx = canvas.getContext("2d")
      //状態保存
      ctx.save()
      //描画エリアのクリア
      ctx.clearRect(0, 0, canvas.width, canvas.height)

      //中心をずらす
      ctx.translate(centerX, centerY)
      //猫の画像を描画
      if(isImageLoaded(catImage)){
        ctx.drawImage(catImage, 0, 0
                      , imageWidth, imageHeight / 2 + 1 + yPos
                      , -imageWidth/2, -imageHeight/2
                      , imageWidth, imageHeight / 2 + 1 + yPos)
      }
      //縦方向に縮める
      ctx.scale(1, yScaleRate)
      //色・太さの設定
      ctx.strokeStyle = "#dc9ee7"
      ctx.lineWidth = 1

      //魔法陣の四角
      rect(ctx, x, y, r, rad)
      rect(ctx, x, y, r, rad + Math.PI / 4)
      //魔法陣の円
      circle(ctx, x, y, r * 1.05)
      circle(ctx, x, y, r)                     //四角に外接
      circle(ctx, x, y, r * Math.sqrt(2) / 2)  //四角に内接
      circle(ctx, x, y, r * Math.sqrt(2) / 2 * 0.85)

      //状態復帰
      ctx.restore()
    }
    //中心を指定して四角を描く
    function rect(ctx, cx, cy, r, rad){
      ctx.beginPath()
      ctx.moveTo(r * Math.cos(rad) + cx
                 , r * Math.sin(rad) + cy)
      ctx.lineTo(r * Math.cos(rad + Math.PI / 2) + cx
                 , r * Math.sin(rad + Math.PI / 2) + cy)
      ctx.lineTo(r * Math.cos(rad + Math.PI) + cx
                 , r * Math.sin(rad + Math.PI) + cy)
      ctx.lineTo(r * Math.cos(rad + Math.PI * 3 / 2) + cx
                 , r * Math.sin(rad + Math.PI * 3 / 2) + cy)
      ctx.closePath()   //最後の辺をつなぐ
      ctx.stroke()
    }
    //円を描く
    function circle(ctx, cx, cy, r){
      ctx.beginPath()
      ctx.arc(cx, cy, r, 0, 2 * Math.PI, false)
      ctx.stroke()
    }
  }
  //魔法陣のオーラ的な演出       [5]
  ParticleSystem {
    anchors.fill: canvas
    //パーティクルの素
    ImageParticle {
      source: "images/particle.png"
      color: "#dc9ee7"                        //画像に色をのせる
      rotationVelocityVariation: 100          //回転速度の変化量
    }
    //動きにゆらぎを与える        [6]
    Wander {
      anchors.fill: parent
      xVariance: 100                          //x方向が対象
      pace: 100                               //時間あたりのパーティクルの数
      affectedParameter: Wander.Acceleration  //加速度を対象にする
    }
    //パーティクルを円周上から発生  [7]
    Emitter {
      //位置決め
      x: canvas.centerX - canvas.radius
      y: canvas.centerY - canvas.radius * canvas.yScaleRate + canvas.yPos
      width: canvas.radius * 2                //直径
      height: width * canvas.yScaleRate       //高さはスケーリングされている

      emitRate: 20                            //１秒間の発生数
      lifeSpan: 2500                          //生存時間
      shape: EllipseShape { fill: false }     //円周上で発生 [8]
      //加速
      acceleration: PointDirection {
        y: -20                                //上方向へ
        yVariation: 10                        //変化量
      }
      size: 10                                //サイズ
      sizeVariation: 5                        //サイズの変化量
    }
  }
}
