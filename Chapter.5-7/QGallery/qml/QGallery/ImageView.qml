import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import "javascripts/Database.js" as DB
import "components"

Rectangle {
  id: root
  width: 100
  height: 62
  color: "#cc000000"
  //画像の読み込み状態で表示状態を決定する
  visible: image.status == Image.Ready || image.status == Image.Loading
  //画像のパス
  property alias source: image.source
  //画像の読み込みで表示状態を切り替える
  onVisibleChanged: {
    if(visible){
      //表示する
      image.y = 0
      openAnim.start()
      scale.xScale = 1
      scale.yScale = 1
      //拡縮設定を初期状態にする
      image.width = flick.width
      image.height = flick.height
      flick.contentX = 0
      flick.contentY = 0
      //コメントを読み込む
      comment.text = DB.readData(image.source, "");
    }else{
    }
  }
  //マウス入力を下に伝えないようにする
  MouseArea {
    anchors.fill: parent
    acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
    onWheel: wheel.accepted = true
    onClicked: {
      //右クリックで閉じる
      if(mouse.button == Qt.RightButton){
        closeAnim.start()
      }
    }
  }
  //ドロップエリア
  DropArea {
    anchors.fill: parent
    onDropped: closeAnim.start();
  }
  //画像を表示する領域
  Flickable {
    id: flick
    anchors.top: parent.top;
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: information.top
    anchors.margins: 10
    //Flickableの中に表示するエレメントのサイズを指定する
    contentWidth: image.width
    contentHeight: image.height
    clip: true
    //画像
    Image {
      id: image
      //parentのサイズを参照すると画像のサイズを取得してしまう
      width: flick.width
      height: flick.height
      smooth: true
      fillMode: Image.PreserveAspectFit
      //回転に関する設定
      transform: Rotation {
        id: rotate
        //回転の中心
        origin.x: image.width / 2
        origin.y: image.height / 2
        //回転の軸
        axis.x: 0
        axis.y: 1
        axis.z: 0
      }
      //ドラッグ機能を付加
      Drag.active: mouseArea.drag.active
      //ドロップとの当たり判定の位置
      Drag.hotSpot.x: width / 2
      Drag.hotSpot.y: height / 2
      //表示するときのアニメ
      NumberAnimation {
        id: openAnim
        target: rotate
        property: "angle"
        from: 90
        to: 0
        duration: 200
      }
      //非表示にするときのアニメーション
      NumberAnimation {
        id: closeAnim
        target: image
        property: "y"
        to: -flick.height
        duration: 200
        //アニメーションが終わったら閉じる
        onStopped: root.source = ""
      }
    }
  }
  //画像の操作
  //Flickableの中に配置すると画像と一緒にclipされてしまうため外に配置する
  MouseArea {
    id: mouseArea
    anchors.fill: flick

//    onPressed: mouse.accepted = false 状態管理へ移動

    //ドラッグする対象を指定しているのでエレメントの位置は離れていてもOK
    drag.target: image
    //ドラッグできる方向を指定
    drag.axis: Drag.YAxis
    //ドラッグできる範囲を指定
    drag.minimumY: -flick.height
    drag.maximumY: 0
    //離したときにドロップの処理を実行
    onReleased: image.Drag.drop()

    onWheel: {
      var diff_w = image.width * 0.1
      var diff_h = image.height * 0.1
      if(wheel.angleDelta.y > 0){
        //拡大
        image.width += diff_w
        image.height += diff_h
        flick.contentX += diff_w / 2
        flick.contentY += diff_h / 2
      }else if(width < (image.width - diff_w)){
        //拡大しているときだけ縮小
        image.width -= diff_w
        image.height -= diff_h
        flick.contentX -= diff_w / 2
        flick.contentY -= diff_h / 2
      }else{
        //初期状態
        image.width = width
        image.height = height
        flick.contentX = 0
        flick.contentY = 0
      }
    }
  }
  StateGroup {
    states: [
      State {
        //少しでも拡大しているときはFlickableを使えるようにする
        when: image.width != flick.width || image.height != flick.height
        PropertyChanges {
          target: mouseArea
          //Flickableにpressを伝える
          onPressed: mouse.accepted = false
          //ドラッグの設定を無効にする
          drag.target: undefined
          onReleased: undefined
        }
      }
    ]
  }
  //画像情報
  Item {
    id: information
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    anchors.margins: 10
    //背の高い方を高さにする
    height: comment.height > buttonUpdate.height ? comment.height : buttonUpdate.height
    //コメントの表示
    TextEdit {
      id: comment
      anchors.verticalCenter: parent.verticalCenter
      anchors.left: parent.left
      anchors.right: buttonUpdate.left
      anchors.rightMargin: 5
      focus: true                 //フォーカスがないと入力できない
      wrapMode: TextEdit.WordWrap //折り返し設定
      text: ""
      color: "#ffffff"
      font.pointSize: 10
    }
    //更新ボタン
    ImageButton {
      id: buttonUpdate
      anchors.verticalCenter: parent.verticalCenter
      anchors.right: parent.right
      width: 100
      height: 30
      backImage: "resources/button_border.png"
      caption: qsTr("Update")
      captionColor: "#deffff"
      captionFontSize: 12
      onClicked: {
        //保存する
        DB.saveData(image.source, comment.text)
      }
    }
  }
}
