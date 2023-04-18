import QtQuick 2.15
import QtQuick.Controls 2.15

Button{
    id: customBtn

    property color colorDefault: "#55aaff"
    property color colorMouseOver: "#cccccc"
    property color colorPressed: "#333333"
    property string textContent

    QtObject{
        id: internal

        property var dynamicColor:
            if(customBtn.down){
                customBtn.down ? colorPressed : colorDefault
            } else {
                customBtn.hovered ? colorMouseOver : colorDefault
            }

        property string dynamicText:  customBtn.textContent
    }

    text: internal.dynamicText
    implicitWidth: 200
    implicitHeight: 40
    background: Rectangle{
        radius: 10
        color: internal.dynamicColor
    }
    contentItem: Item {
        Text{
            id: textBtn
            text: qsTr(customBtn.text)
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
        }
    }
}
