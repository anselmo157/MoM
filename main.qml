import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "view"

Window {
    width: 1280
    height: 720
    visible: true
    title: qsTr("MoM")
    flags: Qt.Window | Qt.FramelessWindowHint

    Rectangle{
        width: 1024
        height: parent.height

        TextField {
            id: input
            anchors.centerIn: parent
            placeholderText: qsTr("Digite a mensagem")
        }

        Button {
            anchors.left: input.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 10
            text: "Enviar mensagem"
            onClicked: console.log(input.text)
        }
    }

    Rectangle {
        id: rigthMenu
        width: 256
        height: parent.height
        anchors.right: parent.right
        color: "#2e2627"

        Rectangle {
            id:isConnect
            anchors.top: parent.top
            anchors.horizontalCenter: rigthMenu.horizontalCenter
            anchors.topMargin: 10

            Text{
                text: qsTr("Desconectado")
                anchors.horizontalCenter: parent.horizontalCenter
                color: "red"
            }
        }

        TextField {
            id: inpuUsername
            anchors.top: isConnect.top
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            placeholderText: qsTr("Digite o seu nome")
        }

        CustomBtn{
            id: connectBtn
            anchors.top: inpuUsername.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            textContent: "Conectar"
        }
    }
}
