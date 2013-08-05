import QtQuick 2.0
import QtMultimedia 5.0

//動画再生
Video {
  id: root
  volume: 0.5
  autoPlay: true
  source: ""
  //sourceにパスが指定されていたら表示、なければ非表示にする
  //動画の読み込みや再生が始まってからvisibleの切り替えができないため
  //パスの設定をしたときに切り替える
  onSourceChanged: {
    if(source.toString().length > 0){
      visible = true
    }else{
      visible = false
    }
  }
  //背景
  Rectangle {
    anchors.fill: parent
    //Videoの後ろへ
    z: -1
    //背景は少し透けた黒
    color: "#000000"
    opacity: 0.8
    //マウスイベント
    MouseArea {
      anchors.fill: parent
      //3つボタンすべてを受け取る
      acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
      //ホイール操作を後ろに伝えない
      onWheel: wheel.accepted = true
      //右クリックのときは動画のパスを削除してVideoViewを非表示にする
      onClicked: {
        if(mouse.button == Qt.RightButton){
          playVideo.source = ""
        }
      }
    }
  }
}
