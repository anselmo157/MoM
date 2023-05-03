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
                    backend.publish(inputMessage.text, inputTopicMessage.text)
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

            ScrollView{
                anchors.fill: parent
                anchors.topMargin: 20
                ScrollBar.horizontal.interactive: false
                ScrollBar.vertical.interactive: true

                ListView {
                    id: listMessages
                    height: 520
                    anchors.fill: parent
                    anchors.topMargin: 20
                    property var messages: []
                    model: messages
                    delegate:
                        Rectangle{
                            width: 920
                            height: 30
                            radius: 10
                            anchors.horizontalCenter: parent.horizontalCenter
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 10
                                text: qsTr("Tópico: " + modelData)
                            }
                        }
                }
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
            onClicked: {
                if(inputTopic.text != "" && listTopics.topics.indexOf(inputTopic.text) == -1){
                    listTopics.topics.push(inputTopic.text)
                    listMessages.messages.push(inputTopic.text)
                    inputTopic.text = ""
                    listTopics.model = listTopics.topics
                    listMessages.model = listMessages.messages
                    backend.subscribeTopic(inputTop.text)
                }
            }
        }

        Rectangle{
            width: 200
            height: 400
            anchors.top: topicBtn.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter

            Text{
                height: 20
                text: qsTr("Tópicos")
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
                color: "black"
            }

            ScrollView{
                anchors.fill: parent
                anchors.topMargin: 20
                ScrollBar.horizontal.interactive: false
                ScrollBar.vertical.interactive: true

                ListView {
                    id: listTopics
                    height: 180
                    anchors.fill: parent
                    anchors.topMargin: 20
                    property var topics: []
                    model: topics
                    delegate:
                        Rectangle{
                            width: 200
                            height: 30
                            Text{
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 10
                                text: qsTr(modelData)
                            }
                            Button{
                                anchors.right: parent.right
                                anchors.rightMargin: 10
                                implicitWidth: 50
                                implicitHeight: 25
                                background: Rectangle{
                                    radius: 10
                                    color: "red"
                                }
                                contentItem: Item {
                                    Text{
                                        text: qsTr("Sair")
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        color: "white"
                                    }
                                }
                                onClicked: {
                                   listTopics.topics = Array.from(listTopics.topics).filter(r => r !== listTopics.topics[index])
                                   listTopics.model = listTopics.topics
                                }
                            }
                            property int index
                        }
                }
            }
        }
    }

    Connections{
        target: backend
        
        function onSetName(name){
            
        }
    }
}
