import QtQuick 2.0

//下段の四角形
Rectangle {
  id: lv1
  x: lv2.x      //子への参照
  y: lv3.y      //孫への参照
  width: 200
  height: 200
  color: "Tomato"
  //中段の四角形（lv1の中心に表示される）
  Rectangle {
    id: lv2
    x: 50
    y: lv3.y    //子への参照
    width: 50
    height: 50
    color: "Plum"
    //上段の四角形（lv2の右下に表示される）
    Rectangle {
      id: lv3
      x: lv2.x  //親への参照
      y: 50
      width: 25
      height: 25
      color: "Lime"
    }
  }
}
