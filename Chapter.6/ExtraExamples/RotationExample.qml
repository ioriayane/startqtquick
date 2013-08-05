import QtQuick 2.0

Rectangle {
    width: 700
    height: 400

    //回転する画像
    Image {
        id: image
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 30
        width: 150
        height: 150
        source: "images/image.png"
        fillMode: Image.PreserveAspectFit
    }
    Grid {
        id: grid
        anchors.left: image.right
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 30
        columns: 3
        rows: 3
        spacing: 20

        //回転前の形と比較用
        Rectangle {
            width: 150
            height: 150
            color: "#22000000"
            //回転する画像
            Image {
                id: image1
                anchors.fill: parent
                source: "images/image.png"
                fillMode: Image.PreserveAspectFit
                antialiasing: true
                transform: Rotation {
                    //回転の中心
                    origin.x: image1.width / 2
                    origin.y: image1.height / 2
                    //回転の軸
                    axis { x: 1; y: 0; z: 0; }
                    //回転の角度
                    angle: 40
                }
            }
        }
        //回転前の形と比較用
        Rectangle {
            width: 150
            height: 150
            color: "#22000000"
            //回転する画像
            Image {
                id: image2
                anchors.fill: parent
                source: "images/image.png"
                fillMode: Image.PreserveAspectFit
                antialiasing: true
                transform: Rotation {
                    //回転の中心
                    origin.x: image2.width / 2
                    origin.y: image2.height / 2
                    //回転の軸
                    axis { x: 0; y: 1; z: 0; }
                    //回転の角度
                    angle: 40
                }
            }
        }
        //回転前の形と比較用
        Rectangle {
            width: 150
            height: 150
            color: "#22000000"
            //回転する画像
            Image {
                id: image3
                anchors.fill: parent
                source: "images/image.png"
                fillMode: Image.PreserveAspectFit
                antialiasing: true
                transform: Rotation {
                    //回転の中心
                    origin.x: image3.width / 2
                    origin.y: image3.height / 2
                    //回転の軸
                    axis { x: 0; y: 0; z: 1; }
                    //回転の角度
                    angle: 40
                }
            }
        }
        //回転前の形と比較用
        Rectangle {
            width: 150
            height: 150
            color: "#22000000"
            //回転する画像
            Image {
                id: image4
                anchors.fill: parent
                source: "images/image.png"
                fillMode: Image.PreserveAspectFit
                antialiasing: true
                transform: Rotation {
                    //回転の中心
                    origin.x: image4.width / 2
                    origin.y: image4.height / 2
                    //回転の軸
                    axis { x: 1; y: 1; z: 0; }
                    //回転の角度
                    angle: 40
                }
            }
        }

        //回転前の形と比較用
        Rectangle {
            width: 150
            height: 150
            color: "#22000000"
            //回転する画像
            Image {
                id: image5
                anchors.fill: parent
                source: "images/image.png"
                fillMode: Image.PreserveAspectFit
                antialiasing: true
                transform: Rotation {
                    //回転の中心
                    origin.x: 0
                    origin.y: 0
                    //回転の軸
                    axis { x: 1; y: 0; z: 0; }
                    //回転の角度
                    angle: 40
                }
            }
        }

        //回転前の形と比較用
        Rectangle {
            width: 150
            height: 150
            color: "#22000000"
            //回転する画像
            Image {
                id: image6
                anchors.fill: parent
                source: "images/image.png"
                fillMode: Image.PreserveAspectFit
                antialiasing: true
                transform: Rotation {
                    //回転の中心
                    origin.x: 0
                    origin.y: 0
                    //回転の軸
                    axis { x: 0; y: 1; z: 0; }
                    //回転の角度
                    angle: 40
                }
            }
        }
    }

}
