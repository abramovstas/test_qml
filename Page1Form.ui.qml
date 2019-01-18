import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Page {
    id: root

    property alias textArea: textArea
    width: 320

    header: ToolBar {
        ToolButton {
            id: toolButton
            text: qsTr("Back")
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
        }

        Label {
            id: pageTitle
            text: qsTr("Chat")
            font.pixelSize: 20
            anchors.centerIn: parent
        }
    }

    Connections {
        target: toolButton
        onClicked: root.StackView.view.pop()
    }

    Connections {
        target: sendButton
        onClicked: sendMessage(messageField.text, "Guest")//sendMessageTest()
    }

    ColumnLayout {
        anchors.fill: parent

        ScrollView {
            id: listView
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.margins: pane.leftPadding + messageField.leftPadding

            TextArea {
                id: textArea
            }
        }

        Pane {
            id: pane
            Layout.fillWidth: true

            RowLayout {
                width: parent.width

                TextArea {
                    id: messageField
                    Layout.fillWidth: true
                    placeholderText: qsTr("Compose message")
                    wrapMode: TextArea.Wrap
                }

                Button {
                    id: sendButton
                    text: qsTr("Send")
                    enabled: messageField.length > 0
//                    onClicked: {
//                        listView.model.sendMessage(inConversationWith, messageField.text);
//                        messageField.text = "";
//                    }
                }
            }
        }
    }
}
