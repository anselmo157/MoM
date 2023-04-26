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

        Rectangle{
            id: publiser
            width: 960
            height: 120
            anchors.top: parent.top
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#d7e7d8"
            border.color: "black"
            border.width: 0.5

            Text{
                text: qsTr("Publicar")
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.left: parent.left
                anchors.leftMargin: 20
                color: "black"
            }

            TextField {
                id: inputTopicMessage
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 20
                placeholderText: qsTr("Digite o tópico")
            }

            TextField {
                id: inputMessage
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: inputTopicMessage.right
                anchors.leftMargin: 20
                placeholderText: qsTr("Digite a mensagem")
            }

            CustomBtn{
                id: sendMessageBtn
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: inputMessage.right
                anchors.leftMargin: 20
                textContent: "Enviar mensagem"
                onClicked: {
                    backend.welcomeText(inputMessage.text)
                }
            }
        }

        Rectangle{
            width: 960
            height: 540
            anchors.top: publiser.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#d7e7d8"
            border.color: "black"
            border.width: 0.5

            Text{
                text: qsTr("Mensagens")
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
                color: "black"
            }
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

        TextField {
            id: inputTopic
            anchors.top: connectBtn.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            placeholderText: qsTr("Digite o nome do tópico")
        }

        CustomBtn{
            id: topicBtn
            anchors.top: inputTopic.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            textContent: "Entrar no tópico"
        }

        Rectangle{
            width: 200
            height: 400
            anchors.top: topicBtn.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter

            Text{
                text: qsTr("Tópicos")
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
                color: "black"
            }
        }
    }

    Connections{
        target: backend
        
        function onSetName(name){
            
        }
    }
}
