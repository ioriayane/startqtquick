import QtQuick 2.0

Rectangle {
  width: 200
  height: 100
  //プロパティの定義
  property real area: width * height
  //プロパティの変化シグナルハンドラ
  onAreaChanged: {
    console.debug("area=" + area)
  }
  //標準プロパティの変化シグナルハンドラ
  onWidthChanged: {
    console.debug("width=" + width)
  }
  onHeightChanged: {
    console.debug("height=" + height)
  }
}
