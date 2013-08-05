import QtQuick 2.0

Rectangle {
  width: 200
  height: 200
  //回転する四角
  Rectangle {
    id: rect
    anchors.centerIn: parent
    width: 50
    height: 50
    antialiasing: true
    color: "RoyalBlue"

    //アニメーション設定
    NumberAnimation {
      target: rect              //アニメーションさせる対象
      property: "rotation"      //値を変化させるプロパティ
      //            properties: "rotation,width,height"
      from: 0                   //アニメーション開始時の値
      to: 360                   //アニメーション終了時の値
      duration: 5000            //開始から終了までの時間（ミリ秒）
      running: true             //アニメーションの動作状況
      loops: Animation.Infinite //ループ回数（無限）
    }
//    NumberAnimation on rotation {
//      from: 0
//      to: 360
//      duration: 5000
//      loops: Animation.Infinite
//    }
  }
}
