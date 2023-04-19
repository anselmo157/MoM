import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "view"

Window {
    width: 1280
    height: 720
    visible: true
    title: qsTr("MoM")
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
