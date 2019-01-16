import QtQuick 2.9
import QtQuick.Controls 2.2

import ru.abrmv.xmpparser 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Stack")

    function sendMessage(userMessage, userName) {
        var http = new XMLHttpRequest()
        var url = "http://host1.demoproject2f.techcd.ru/chatbot/conversation_start.php?";
        var params = 'bot_id=2&say=%1&format=xml&Name=%2'.arg(userMessage).arg(userName)
        http.open("POST", url, true);
        http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        http.setRequestHeader("Content-length", params.length);
        http.setRequestHeader("Connection", "close");

        http.onreadystatechange = function() { // Call a function when the state changes.
            if (http.readyState == 4) {
                if (http.status == 200) {
                    console.log("ok", http.responseText.toLocaleString())
                    xmlparser.setResponse(http.responseText.toLocaleString());
                } else {
                    console.log("error: " + http.status)
                }
            }
        }
        http.send(params);
    }

    MessageParser {
        id: xmlparser
    }

    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                } else {
                    drawer.open()
                }
            }
        }

        Label {
            text: stackView.currentItem.title
            anchors.centerIn: parent
        }
    }

    Drawer {
        id: drawer
        width: window.width * 0.66
        height: window.height

        Column {
            anchors.fill: parent

            ItemDelegate {
                text: qsTr("Page 1")
                width: parent.width
                onClicked: {
                    stackView.push("Page1Form.ui.qml")
                    //console.log("textEditText = ", textEditText)
                    stackView.children[1].textEdit.append(textEditText)
                    drawer.close()
                }
            }
//            ItemDelegate {
//                text: qsTr("Page 2")
//                width: parent.width
//                onClicked: {
//                    stackView.push("Page2Form.ui.qml")
//                    drawer.close()
//                }
//            }
        }
    }

    StackView {
        id: stackView
        initialItem: "HomeForm.ui.qml"
        anchors.fill: parent
    }
    Connections {
        target: xmlparser
        onAppendText: {
            window.textEditText += str;
            if (stackView.children[1])
                stackView.children[1].textEdit.append(str)
        }//stackView.children[0].textEdit.append(str)
    }
    property string textEditText: ""
}
//  host1.demoproject2f.techcd.ru/chatbot/conversation_start.php?bot_id=2&say=привет&format=xml&Name=stas
