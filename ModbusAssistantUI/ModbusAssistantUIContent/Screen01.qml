

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick
import QtQuick.Controls
import ModbusAssistantUI
import QtQuick.Layouts


Rectangle {
    id: rectangle
    width: 900
    height: 600
    color: "#0bb3a2"
    property string port: "502"
    property string iPAddr: "127.0.0.1"

    signal modbusConnect(string ip, string ipport)

    function testModbusConnect(ip, ipport){
        console.log("Connect to: ", ip, ":", ipport)
    }

    TextField {
        id: addrInput
        x: 245
        y: 280
        width: 186
        height: 40
        color: "#de8b19"
        text: "127.0.0.1"
        selectedTextColor: "#ffffff"
        selectionColor: "#de8b19"
        font.pointSize: 16
        placeholderText: qsTr("127.0.0.1")

        Connections {
            target: addrInput
            onTextEdited: rectangle.iPAddr = addrInput.text
        }
    }

    TextField {
        id: portInput
        x: 445
        y: 280
        width: 90
        height: 40
        visible: true
        color: "#de8b19"
        text: "502"
        clip: false
        selectedTextColor: "#ffffff"
        selectionColor: "#de8b19"
        placeholderText: qsTr("502")
        font.pointSize: 16
        Connections {
            target: portInput
            onTextEdited: rectangle.port = portInput.text
        }
    }

    Text {
        id: _text1
        x: 245
        y: 234
        width: 186
        height: 40
        color: "#000000"
        text: qsTr("IP Address")
        font.pixelSize: 22
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
    }

    Text {
        id: _text2
        x: 445
        y: 234
        width: 90
        height: 40
        color: "#000000"
        text: qsTr("port")
        font.pixelSize: 22
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
    }

    Button {
        id: connectButton
        x: 558
        y: 280
        width: 95
        height: 40
        text: qsTr("Connect")
        font.pointSize: 12

        Connections {
            target: connectButton
            onClicked: modbus_client.connect(iPAddr, port);
            // onClicked: rectangle.testModbusConnect(iPAddr, port)
        }
    }
    states: [
        State {
            name: "clicked"
        }
    ]
}
