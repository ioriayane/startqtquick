import QtQuick 2.0

MouseArea {
  id: root
  //マウスオーバー時のイベントを有効にする
  hoverEnabled: true
  //内部エレメントへのエイリアス
  property alias backImage: backImage.source              //背景画像
  property alias foreImage: foreImage.source              //前面画像
  property alias caption: caption.text                    //キャプション文字列
  property alias captionColor: caption.color              //キャプションフォント色
  property alias captionFontSize: caption.font.pointSize  //キャプションフォントサイズ
  //押したときなどの色指定
  property color pressedColor: "#ff0000"                  //押しているときの色
  property color hoverColor: "#0000ff"                    //カーソルがいるときの色

  //ボタン画像
  BorderImage {
    id: backImage
    anchors.fill: parent
    //固定する範囲を設定する
    border.top: 15
    border.left: 15
    border.right: 15
    border.bottom: 15
    //前面画像
    Image {
      id: foreImage
      anchors.centerIn: parent
    }
    //キャプション
    Text {
      id: caption
      anchors.centerIn: parent
    }
  }
  //カラーフィルター用の四角
  Rectangle {
    id: filter
    anchors.fill: parent
    radius: 15              //角を丸くする
    opacity: 0.2            //透過度
    color: "transparent"    //通常時は透明
  }
  //状態管理
  states: [
    State {
      //押しているとき
      name: "press"
      when: root.pressed
      PropertyChanges {
        target: filter
        color: root.pressedColor
      }
    },
    State {
      //カーソルが入っている
      name: "hover"
      when: root.containsMouse
      PropertyChanges {
        target: filter
        color: root.hoverColor
      }
    }
  ]
}
