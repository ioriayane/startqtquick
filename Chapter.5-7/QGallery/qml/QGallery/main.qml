import QtQuick 2.0
import QtMultimedia 5.0
import com.example.qgalleryplugin.operatingsystem 1.0
import "components"

Rectangle {
  id: root
  //サイズを調節
  width: 360
  height: 400
//  color: "#222222"
  gradient: Gradient {
    GradientStop { position: 0.0;  color: "#888888" }
    GradientStop { position: 0.2;  color: "#222222" }
    GradientStop { position: 1.0;  color: "#444444" }
  }
  //プラットフォーム情報
  OperatingSystem { id: os }
  //音楽再生機能
  Audio {
    id: playAudio
    volume: 0.5     //ボリューム
    autoPlay: true  //自動再生ON
  }
  //曲情報
  Information {
    id: information
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.margins: 10
    //曲情報の指定
    title: toStr(controller.player.metaData.title)      //タイトル
    artist: toStr(controller.player.metaData.author)    //アーティスト
    album: toStr(controller.player.metaData.albumTitle) //アルバム
    //再生位置の指定
    position: controller.player.position                //現在位置
    duration: controller.player.duration                //合計時間
    //再生位置の変更依頼
    onPositionRequested: {
      if(controller.player.playbackState === Audio.PlayingState
          && controller.player.seekable){
        //再生中かつシーク可能なときのみ再生位置を変更する
        controller.player.seek(position)
      }
    }
  }
  //操作機能
  Controller {
    id: controller
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: information.bottom
    anchors.margins: 10
    //音楽と動画へのアクセスを中継
    property var player: playAudio
    //再生中を伝える
    playing: player.playbackState === Audio.PlayingState
    //ボタン操作時のシグナルハンドラ
    onPlayClicked: player.play()
    onPauseClicked: player.pause()
    onStopClicked: player.stop()
    onPreviousClicked: player.source = contentsList.getPrevious()
    onNextClicked: player.source = contentsList.getNext()
  }
  //コンテンツリスト
  ContentsList {
    id: contentsList
    anchors.top: controller.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    anchors.margins: 10
    //ローカルとWebの切り替え
    visible: !controller.webMode
    //接頭辞の設定
    pathPrefix: os.pathPrefix
    //コンテンツの選択
    onSelected: {
      setContent(filePath, type)
    }
    //起動したら初期フォルダを設定
    Component.onCompleted: {
      folder = os.homeDirectory
    }
  }
  ContentsGrid {
    id: contentsGrid
    anchors.top: controller.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    anchors.margins: 10
    //ローカルとWebの切り替え
    visible: controller.webMode
    username: "IoriAYANE"   //表示したいユーザー名
    //コンテンツの選択
    onSelected: {
      setContent(filePath, type)
    }
  }
  //動画
  VideoView {
    id: playVideo
    anchors.top: controller.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    visible: false
  }
  //画像
  ImageView {
    id: imageView
    anchors.fill: parent
  }

  //選択したコンテンツをセットする
  function setContent(path, type){
    //一旦停止する
    playAudio.stop()
    playVideo.stop()
    //それぞれ再生
    switch(type){
    case 1: //音楽
      controller.player = playAudio
      playAudio.source = path
      break
    case 2: //動画
      controller.player = playVideo
      playVideo.source = path
      break
    case 3: //画像
      imageView.source = path
      break
    default:
      break
    }
  }
}
