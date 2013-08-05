import QtQuick 2.0
import com.example.qtriangleplugin 1.0

Rectangle {
  width: 360
  height: 360
  //三角形のエレメントを追加
  Triangle{
    anchors.fill: parent
    anchors.margins: 10
    color: "red"
  }
  Text {
    text: qsTr("Triangle")
    anchors.centerIn: parent
  }
  MouseArea {
    anchors.fill: parent
    onClicked: {
      Qt.quit()
    }
  }
}
