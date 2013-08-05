import QtQuick 2.0

Rectangle {
  width: 600
  height: 400
  color: "black"
  //グラデーションをかける対象の四角
  Rectangle {
    id: rect
    anchors.centerIn: parent
    width: 100
    height: 200
    antialiasing: true
    //親の四角にグラデーションをかける
    GradientEx {
      id: grad
      anchors.fill: parent
      gradient: Gradient {
        GradientStop { position: 0.0; color: "red" }
        GradientStop { position: 0.33; color: "yellow" }
        GradientStop { position: 1.0; color: "green" }
      }
      //グラデーションが適切なサイズか確認するために一時的にクリップを解除
      clip: false
      //グラデーション確認用に角度を変化させる
      NumberAnimation on rotation {
        loops: Animation.Infinite
        duration: 5000
        from: 0
        to: 360
      }
    }
    //グラデーションが適切なサイズになっているか確認する用の四角
    Rectangle {
      anchors.fill: parent
      opacity: 0.5
    }
    //グラデーション確認用に横幅を変化させる
    SequentialAnimation on width {
      loops: Animation.Infinite
      NumberAnimation { duration: 1000; to: 300 }
      NumberAnimation { duration: 1000; to: 100 }
      PauseAnimation { duration: 500 }
    }
    //グラデーション確認用に高さを変化させる
    SequentialAnimation on height {
      loops: Animation.Infinite
      NumberAnimation { duration: 1000; to: 100 }
      NumberAnimation { duration: 1000; to: 200 }
      PauseAnimation { duration: 500 }
    }
  }
}
