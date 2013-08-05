import QtQuick 2.0
import QtQuick.XmlListModel 2.0
import "components"

GridView {
  id: root
  clip: true
  //対象ユーザー
  property string username: ""
  //ファイル・フォルダを選択したときのシグナル
  signal selected(string filePath, int type)

  //TwitPicの解析
  model: XmlListModel {
    id: xmllist
    source: "http://api.twitpic.com/2/users/show.xml?username=" + username
    query: "/user/images/image"
    //画像のIDを抽出する
    XmlRole { name: "image_id"; query: "short_id/string()" }
  }
  //選択項目のハイライト
  highlight: Rectangle {
    color: "#22ffffff"
  }
  //レイアウト
  delegate: Rectangle {
    id: item
    width: 100
    height: 100
    color: "transparent"
    clip: true
    property string filePath: "http://twitpic.com/show/thumb/" + model.image_id
    property int type: 3

    //画像（サムネイル）
    Image {
      id: image
      anchors.fill: parent
      anchors.margins: 5
      fillMode: Image.PreserveAspectCrop
      source: filePath
    }
    //マウス入力
    MouseArea {
      anchors.fill: parent
      onClicked: {
        currentIndex = index   //ハイライトの位置を移動する
        root.selected("http://twitpic.com/show/large/" + model.image_id, type)
      }
    }
  }
}
