import QtQuick 2.12
import QtQuick.Controls 2.12

import ru.abrmv.xmpparser 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 320
    height: 480
    title: qsTr("Techcd.ru")

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

    function sendMessageTest() {
        var resp = "<program_o>
    <version>2.6.8</version>
    <status>
        <success>1</success>
    </status>
    <bot_id>2</bot_id>
    <bot_name>Test2</bot_name>
    <user_id>1295</user_id>
    <user_name>Guest</user_name>
    <chat>
        <line>
            <input>Hello</input>
            <response>Затрудняюсь ответить.</response>
        </line>
    </chat>
</program_o>"
        xmlparser.setResponse(resp);
    }

    MessageParser {
        id: xmlparser
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: "HomeForm.ui.qml"
    }

    Connections {
        target: xmlparser
        onAppendText: {
            window.textEditText += str;
            if (stackView.children[1]) {
                stackView.children[1].textArea.append(str)
            }
        }
    }
    property string textEditText: ""
}
