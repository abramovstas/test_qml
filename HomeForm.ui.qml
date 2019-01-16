import QtQuick 2.9
import QtQuick.Controls 2.2

Page {
    id: page
    width: 600
    height: 400
    property alias page: page

    title: qsTr("Techcd.ru")

    //  Надпись введите имя
    Label {
        width: 337
        height: 21
        text: qsTr("Enter you name")
        anchors.verticalCenterOffset: -40
        anchors.horizontalCenterOffset: -110
        anchors.centerIn: parent
    }

    //  Кнопка
    Rectangle {
        id: button
        x: 21
        y: 247 //Имя кнопки

        //Размещаем в центре
        //x: parent.width / 2 - button.width / 2;
        //y: parent.height / 2 - button.height / 2;

        //Размеры кнопки
        width: 100
        height: 30

        //Цвет кнопки
        color: "gray"

        //Текст кнопки
        Text {
            id: buttonLabel
            text: "Начать чат"
            anchors.centerIn: parent
        }

        MouseArea {
            id: mouseArea1
            hoverEnabled: true
            anchors.fill: parent
        }
    }

    //Строка ввода
    Rectangle {
        id: textinputRect
        x: 21
        y: 202 //Имя строки ввода

        //Размещаем ниже
        //x: parent.width / 2 - button.width / 2;
        //y: parent.height / 2 - button.height / 2+40;

        //Размеры строки ввода
        width: 100
        height: 18

        //цвет строки ввода
        color: "gray"

        TextInput {
            id: textinput
            objectName: "textinput"
            color: "#151515"
            selectionColor: "blue"
            font.pixelSize: 12
            width: parent.width - 4
            anchors.centerIn: parent
            focus: true
            text: "stas"
        }
    }

    Connections {
        target: mouseArea1
        onClicked: sendMessage("Привет", textinput.text)
    }
}
