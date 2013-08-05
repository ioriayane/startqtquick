import QtQuick 2.0

Rectangle {
  width: 200
  height: 200

  Rectangle {
    id: rect
    width: 50
    height: 50
    color: "Tomato"
    //アニメーションを連続実行
    SequentialAnimation {    // [1]
      //自動実行
      running: true
      //無限ループ
      loops: Animation.Infinite
      //左から右へ移動
      NumberAnimation { target: rect; property: "x"; to: 150; duration: 1000; }
      //スクリプトを実行（四角の色を変更する）
      ScriptAction { script: rect.changeColor() }      // [2]
      //複数のアニメーションをセットにして左下へ斜めに移動
      ParallelAnimation {                              // [3]
        NumberAnimation { target: rect; property: "x"; to: 0; duration: 1000; }
        NumberAnimation { target: rect; property: "y"; to: 150; duration: 1000; }
      }
      //スクリプトを実行（四角の色を変更する）
      ScriptAction { script: rect.changeColor() }
      //下から上へ移動
      NumberAnimation { target: rect; property: "y"; to: 0; duration: 1000; }
      //スクリプトを実行（四角の色を変更する）
      ScriptAction { script: rect.changeColor() }
    }
    //ランダムな色に変更
    function changeColor(){
      color = Qt.rgba(Math.random(), Math.random(), Math.random(), 1)
    }
  }
}
