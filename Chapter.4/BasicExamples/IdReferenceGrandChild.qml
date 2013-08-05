import QtQuick 2.0

Rectangle {
  x: rect.x / 2               // [1]
  y: rect.y / 2
  width: 50
  height: 50
  border.width: 1
  border.color: "DarkGray"
  color: root.color           //[2]
}
