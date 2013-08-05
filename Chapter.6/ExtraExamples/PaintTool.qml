import QtQuick 2.0

Rectangle {
  width: 400
  height: 360

  //座標記録用の配列
  property var listPointX: []
  property var listPointY: []

  //ツールバー [1]
  Column {
    id: column
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.margins: 5
    spacing: 2
    //保存と読み込み
    Repeater {
      model: ListModel {   // [2]
        ListElement { text: "Save"; mode: 0 }
        ListElement { text: "Load"; mode: 1 }
        ListElement { text: "Clear"; mode: 2 }
      }
      Rectangle {
        width: 40
        height: 40
        border.width: 1
        border.color: "Gray"
        Text {
          anchors.centerIn: parent
          text: model.text
        }
        MouseArea {
          anchors.fill: parent
          onClicked: {            // [3]
            switch(model.mode){
            case 0:
              //保存
              canvas.save("image.png")
              break
            case 1:
              //読み込み
              canvas.doClear = true
              canvas.loadImageUrl = "image.png"
              canvas.loadImage(canvas.loadImageUrl)
              break
            case 2:
              //クリア
              canvas.doClear = true
              break
            default:
              break
            }
          }
        }
      }
    }
    //色の選択
    Repeater {
      model: ListModel {   // [4]
        ListElement { color: "#000000" }
        ListElement { color: "#ff0000" }
        ListElement { color: "#00ff00" }
        ListElement { color: "#0000ff" }
      }
      Rectangle {
        width: 40
        height: 40
        border.width: 1
        border.color: "Gray"
        color: model.color
        MouseArea {
          anchors.fill: parent
          onClicked: canvas.strokeColor = color   // [5]
        }
      }
    }
  }
  //キャンバス [6]
  Canvas {
    id: canvas
    anchors.top: parent.top
    anchors.left: column.right
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    anchors.margins: 5

    //描画設定 [7]
    renderTarget: Canvas.Image          //描画先を指定
    renderStrategy: Canvas.Immediate    //描画スレッドの指定
    antialiasing: true                  //描画を滑らかにする

    property color strokeColor: "#000000"
    property int lineWidth: 3
    property bool doClear: true         //クリアトリガー
    property string loadImageUrl: ""    //読み込み用

    //画像の読み込み完了 [8]
    onImageLoaded: requestPaint()
    //クリア
    onDoClearChanged: {
      if(doClear){
        requestPaint()
      }
    }
    //描画処理  [9]
    onPaint: {
      var x1
      var y1
      var ctx = canvas.getContext("2d")
      //状態保存
      ctx.save()
      //描画エリアのクリア
      if(doClear){
        clearPoint()
        ctx.clearRect(0, 0, canvas.width, canvas.height)
        doClear = false
      }
      //色と太さ
      ctx.strokeStyle = strokeColor
      ctx.lineWidth = lineWidth
      //画像の読み込み
      if(isImageLoaded(loadImageUrl)){
        ctx.drawImage(loadImageUrl, 0, 0)
        loadImageUrl = ""
      }
      //パス描画の開始
      ctx.beginPath()
      //ドラッグして溜まっている座標データで描画
      if(listPointX.length > 1 && listPointY.length > 1){
        x1 = listPointX.shift()
        y1 = listPointY.shift()
        ctx.moveTo(x1, y1)
        while(listPointX.length > 0){
          x1 = listPointX.shift()
          y1 = listPointY.shift()
          ctx.lineTo(x1, y1)
        }
        //開始場所として入れ直す
        listPointX.push(x1)
        listPointY.push(y1)
      }
      //ストロークを適用
      ctx.stroke()
      //状態復帰
      ctx.restore()
    }
    //操作用のマウスエリア    [10]
    MouseArea {
      anchors.fill: parent
      onPressed: {
        clearPoint()
        updatePoint(mouse)
        canvas.requestPaint()
      }
      onPositionChanged: {
        updatePoint(mouse)
        canvas.requestPaint()
      }
      onReleased: {
        updatePoint(mouse)
        canvas.requestPaint()
      }
    }
  }
  //座標管理
  function clearPoint(){
    listPointX = []
    listPointY = []
  }
  function updatePoint(mouse){
    listPointX.push(mouse.x)
    listPointY.push(mouse.y)
  }
}
