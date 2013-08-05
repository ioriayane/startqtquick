import QtQuick 2.0
import QtMultimedia 5.0
import Qt.labs.folderlistmodel 1.0

ListView {
  id: root
  clip: true
  //パス作成時の接頭辞(LinuxとMacでは、"file://"とする）
  property string pathPrefix: "file:///"
  //対象フォルダの指定
  property alias folder: folderlist.folder
  //ファイル・フォルダを選択したときのシグナル
  signal selected(string filePath, int type)
  //対応拡張子の登録（音楽：1, 動画:2, 画像:3）
  property var suffix2Type: {
    'mp3': 1, 'm4a': 1, 'wma': 1
    , 'mpg': 2, 'mp4': 2, 'wmv': 2
    , 'png': 3, 'jpg': 3, 'bmp': 3
  }

  //ファイル一覧をモデルで取得
  model: FolderListModel {
    id: folderlist
    //フォルダを一番上にまとめるか（falseはファイルと一緒にソートされる）
    showDirsFirst: true
    //親フォルダを示すドット2つとカレントフォルダを示すドット1つを表示するか
    showDotAndDotDot: true
    //フィルタ作成（関数の中も評価してくれる）
    nameFilters: makeFilter()
    function makeFilter() {
      var ret = []
      for (var suffix in suffix2Type) {
        ret.push("*." + suffix)
      }
      return ret
    }
  }
  //選択アイテムのハイライト用レイアウト
  highlight: Rectangle {
    color: "#22ffffff"
  }
  //レイアウト
  delegate: MouseArea {
    id: item
    width: root.width
    height: info.height * 1.1
    //外部から個々の情報にアクセスできるように保存する
    property string filePath: model.filePath
    property int type: model.fileIsDir ? 0 : suffix2Type[model.fileSuffix]
    //アイテムを選択
    onClicked: {
      if(type === 0){
        //表示するフォルダを変更する
        currentIndex = -1       //フォルダ選択時はハイライトを解除する
        folderlist.folder = pathPrefix + model.filePath
      }else{
        //選択したファイルのパスをシグナルで通知
        currentIndex = index    //ハイライトの位置を移動する
        selected(pathPrefix + model.filePath, type)
      }
    }
    //情報
    Row {
      id: info
      anchors.verticalCenter: parent.verticalCenter
      spacing: 5
      smooth: true
      //アイコンを表示
      Image {
        id: icon
        width: 40
        height: 35
        fillMode: Image.PreserveAspectFit
        source: "resources/icon_folder.png"
        states: [
          State {  //音楽ファイルのとき
            when: type === 1
            PropertyChanges {
              target: icon
              source: "resources/icon_music.png"
            }
          }
          ,State { //動画ファイルのとき
            when: type === 2
            PropertyChanges {
              target: icon
              source: "resources/icon_move.png"
            }
          }
          ,State { //画像ファイルのとき
            when: type === 3
            PropertyChanges {
              target: icon
              //プラグインを使用してサムネイル表示する
              source: "image://thumbnail/" + model.filePath
            }
          }
        ]
      }
      //ファイル名
      Column {
        anchors.verticalCenter: parent.verticalCenter
        Text {
          text: model.fileName
          color: "#ffffff"
        }
      }
    }
  }
  //次の曲のパスを取得する
  function getNext(){
    var path = ""
    var path_old = currentItem.filePath
    var type_old = currentItem.type
    var index_old = currentIndex
    //1つ次へ
    incrementCurrentIndex()
    for(var i=currentIndex; i<count; i++){
      currentIndex = i
      if(currentItem.type === type_old){
        //最初に見つかったものを結果とする
        path = currentItem.filePath
        break
      }
    }
    if(path.length < 1){
      //何も見つからなかったら現在の情報に戻す
      path = path_old
      currentIndex = index_old
    }
    return path
  }
  //前の曲のパスを取得する
  function getPrevious(){
    var path = ""
    var path_old = currentItem.filePath
    var type_old = currentItem.type
    var index_old = currentIndex
    //1つ前へ
    decrementCurrentIndex()
    for(var i=currentIndex; i>=0; i--){
      if(currentItem.type === type_old){
        //最初に見つかったものを結果とする
        currentIndex = i
        path = currentItem.filePath
        break
      }
    }
    if(path.length < 1){
      //何も見つからなかったら現在の情報に戻す
      path = path_old
      currentIndex = index_old
    }
    return path
  }
}
