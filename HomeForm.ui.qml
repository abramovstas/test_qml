import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.0

Page {
    id: page
    property alias page: page

    header: ToolBar {
        Label {
            text: qsTr("Contact")
            font.pixelSize: 20
            anchors.centerIn: parent
        }
    }

    Connections {
        target: sendButton
        onClicked: {
            sendMessage("Привет", firstName.text)
            //sendMessageTest()
            page.StackView.view.push("qrc:/Page1Form.ui.qml")
            stackView.children[1].textArea.append(textEditText)
        }
    }

    Pane {
        id: pane
        Layout.fillWidth: true
        anchors.centerIn: parent

        ColumnLayout {
            width: parent.width
            anchors.centerIn: parent

            TextField {
                id: firstName
                Layout.minimumWidth: 140
                Layout.fillWidth: true
                Layout.columnSpan: 3
                placeholderText: qsTr("Введите имя")
            }

            Button {
                id: sendButton
                width: 200
                text: qsTr("Начать чат")
                Layout.fillWidth: true
                enabled: firstName.length > 0
            }
        }
    }
}
