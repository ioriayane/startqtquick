import QtQuick 2.0
import QtQuick.Window 2.0   // [1]
import QtWebKit 3.0

Window {                    // [2]
  width: 640
  height: 480
  //ページタイトルを表示
  title: webview.title    // [3]

  //表示してるURLを表示
  Text {
    id: url
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    text: webview.url
    elide: Text.ElideMiddle
  }
  //Webページ
  WebView {
    id: webview
    anchors.top: url.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    url: "http://qt-project.org/"   // [4]

    property url hoveredUrl: ""

    onNavigationRequested: {        // [5]
      //他ドメインへのアクセスをブロック
      var reg = new RegExp("https?:\\/\\/([-_.a-zA-Z0-9]+)\\/?")
      var req_url = request.url.toString().match(reg)    // [6]
      var now_domain = webview.url.toString().match(reg)
      if(req_url === null || now_domain === null){
      }else if(req_url[0] === now_domain[0]){
        //同じドメインへのアクセス
        request.action = WebView.AcceptRequest
      }else{
        //他のドメインへのアクセス
        request.action = WebView.IgnoreRequest
      }
    }
    //リンクにカーソルを合わせた
    onLinkHovered: webview.hoveredUrl = hoveredUrl
    //読込中表示の状態
    states: State {
      when: webview.loading
      PropertyChanges {
        target: statusBar
        text: qsTr("Loading %1%...").arg(webview.loadProgress)
      }
    }
  }
  //カーソルを合わせたリンクや読み込み中を表示
  Text {
    id: statusBar
    anchors.bottom: parent.bottom
    text: webview.hoveredUrl
    //メッセージの背景
    Rectangle {
      anchors.fill: parent
      color: "#aaaaaa"
      opacity: 0.8
      z: -1
    }
  }
}
