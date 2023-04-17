import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("MQTT")
    Row{
        Column {
            Button {
                width: 100
                height: 100
                text: "Oi"
                background: Rectangle {
                    color: "red"
                }
            }
            Button {
                width: 100
                height: 100
                text: "Bom dia"
            }
        }
        Column {
            Rectangle {
                width: 100
                height: 100
                color: "white"
                Text {
                    anchors.fill: parent
                    text: "Olá"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            Rectangle {
                width: 100
                height: 100
                color: "black"
                Text {
                    anchors.fill: parent
                    text: "Boa"
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
    }
    
}
