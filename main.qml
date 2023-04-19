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

    Rectangle {
        id: rigthMenu
        width: 256
        height: parent.height
        anchors.right: parent.right
        color: "#2e2627"

        CustomBtn{
            id: filaBtn
            textContent: "Criar fila"
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 10
        }

        CustomBtn{
            id: topicoBtn
            textContent: "Criar tópico"
            anchors.right: parent.right
            anchors.top: filaBtn.bottom
            anchors.rightMargin: 10
            anchors.topMargin: 20
        }
    }
}
