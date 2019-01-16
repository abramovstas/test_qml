import QtQuick 2.9
import QtQuick.Controls 2.2

Page {
    id: page1
    width: 600
    height: 400
    property alias scrollView: scrollView
    property alias textEdit: textEdit

    title: qsTr("Page 1")

    Label {
        text: qsTr("Сообщения чата")
        anchors.right: parent.right
        anchors.rightMargin: 90
        anchors.left: parent.left
        anchors.leftMargin: 7
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 385
        anchors.top: parent.top
        anchors.topMargin: 2
    }

    //Поле ввода/вывода сообщений чата

    //  Надпись введите имя
    Label {
        text: qsTr("Enter you message")
        styleColor: "#db3333"
        anchors.right: parent.right
        anchors.rightMargin: 243
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 188
        anchors.top: parent.top
        anchors.topMargin: 191
        anchors.left: parent.left
        anchors.leftMargin: 14
    }

    ScrollView {
        id: scrollView
        clip: true
        anchors.right: parent.right
        anchors.rightMargin: 15
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 224
        anchors.top: parent.top
        anchors.topMargin: 24
        anchors.left: parent.left
        anchors.leftMargin: 13

        Flickable {
            id: flickable
            x: 36
            y: 24
            width: 300
            height: 300
            flickableDirection: Flickable.VerticalFlick

            TextEdit {
                id: textEdit
                width: 525
                color: "#7e797f"
                text: qsTr("")
                readOnly: true
                clip: true
                anchors.rightMargin: -572
                anchors.bottomMargin: -137
                anchors.leftMargin: 0
                anchors.topMargin: 0
                anchors.fill: parent
                font.pixelSize: 12
            }
        }
    }

    Button {
        id: button
        text: qsTr("Отправить сообщение")
        checkable: true
        anchors.right: parent.right
        anchors.rightMargin: 382
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 105
        anchors.top: parent.top
        anchors.topMargin: 255
        anchors.left: parent.left
        anchors.leftMargin: 15
    }


    TextInput {
        id: textinput
        height: 20
        color: "#7e797f"
        text: qsTr("")
        anchors.right: parent.right
        anchors.rightMargin: 243
        anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 162
        anchors.top: parent.top
        anchors.topMargin: 218
        font.pixelSize: 12
    }

    Connections {
        target: button
        onClicked: sendMessage(textinput.text, "stas")
    }
}


















/*##^## Designer {
    D{i:2;anchors_width:337}D{i:5;anchors_width:565}
}
 ##^##*/
