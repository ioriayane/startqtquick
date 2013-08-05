import QtQuick 2.0

Item {
  id: root
  width: 100
  height: 20
  //位置情報
  property int max: 4         //最大値
  property int min: 0         //最小値
  property int position: 0    //現在値
  //色の設定
  property color guideColor: "#ffffff"
  property color handleColor: "#ffffff"
  property color guideBkColor: "#ffffff"
  property color handleBkColor: "#ffffff"
  property real radius: 0
  //ハンドル位置変更のシグナル
  signal handleMoved(int position)

  //エレメント開始
  Component.onCompleted: {
    setHandlePosition()
  }
  //場所の変更されたシグナルハンドラ
  onPositionChanged: {
    setHandlePosition()
  }
  //ハンドルの座標を再計算
  function setHandlePosition(){
    if(root.max != 0){
      handle.x = guide.width * root.position / root.max
          - handle.width * 0.5 + guide.x
    }else{
      handle.x = -handle.width * 0.5 + guide.x
    }
  }
  //ガイド
  Rectangle {
    id: guide
    anchors.centerIn: parent
    width: parent.width * 0.9
    height: parent.height * 0.5
    color: root.guideBkColor
    border.color: root.guideColor
    border.width: 1
    radius: root.radius
    //ハンドルの操作
    MouseArea {
      anchors.fill: parent
      //クリックでハンドルを移動
      onClicked: root.handleMoved(calcPosition(mouse.x))
      //エリアをドラッグでマウスを移動
      onPositionChanged: root.handleMoved(calcPosition(mouse.x))
      //ハンドルの位置を計算
      function calcPosition(x){
        var position = Math.ceil(root.max * x / guide.width)
        if(position > max){
          position = max
        }else if(position < min){
          position = min
        }
        return position
      }
    }
  }
  //ハンドル
  Rectangle {
    id: handle
    anchors.verticalCenter: parent.verticalCenter
    x: -width * 0.5 + guide.x
    width: height
    height: parent.height * 0.8
    color: root.handleBkColor
    border.color: root.handleColor
    border.width: 1
    radius: height * 0.5
  }
}
