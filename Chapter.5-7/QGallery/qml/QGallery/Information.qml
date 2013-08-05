import QtQuick 2.0
import "components"

Column {
  id: root
  spacing: 5  //隙間
  //曲情報
  property alias title: title.text    //タイトル
  property string artist: ""          //アーティスト名
  property string album: ""           //アルバム名
  //時間
  property int position: 0            //現在位置
  property int duration: 0            //合計時間
  //再生位置の変更通知
  signal positionRequested(int position)

  //タイトル
  Text {
    id: title
    anchors.left: parent.left
    anchors.right: parent.right
    horizontalAlignment: Text.AlignHCenter
    elide: Text.ElideRight
    color: "#deffff"
    font.pointSize: 16
    text: " "            //1文字もないと高さがなくなってレイアウトが崩れるため
  }
  //アーティスト/アルバム
  Text {
    anchors.left: parent.left
    anchors.right: parent.right
    horizontalAlignment: Text.AlignHCenter
    elide: Text.ElideRight
    color: "#deffff"
    text: artist + " / " + album
    font.pointSize: 9
  }
  //時間とシークバー
  Row {
    anchors.horizontalCenter: parent.horizontalCenter
    spacing: 2
    //現在の時間
    Text {
      anchors.verticalCenter: parent.verticalCenter
      text: formatSeconds(position)
      color: "#deffff"
    }
    //現在の時間とシーク操作
    Slider {
      width: 150
      height: 16
      guideColor: "#deffff"
      handleColor: "#deffff"
      guideBkColor: "#00000000"
      handleBkColor: "#4e6f6f"
      min: 0
      max: duration
      position: root.position
      //ハンドル位置変更
      onHandleMoved: root.positionRequested(position)
    }
    //合計時間
    Text {
      anchors.verticalCenter: parent.verticalCenter
      text: formatSeconds(duration)
      color: "#deffff"
    }
  }
  //フォーマットを指定して成形する
  function formatSeconds(pos) {
    var date = new Date
    date.setTime(pos)
    return Qt.formatDateTime(date, "mm:ss")
  }
  //曲情報がundefinedか確認
  function toStr(text){
    return text === undefined ? " " : text
  }
}
