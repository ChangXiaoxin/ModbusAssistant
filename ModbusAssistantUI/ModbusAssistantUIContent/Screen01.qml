

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
    color: "#35bdb3"
    property bool isDialogOpen: false

    Button {
        id: button
        y: 280
        text: qsTr("AddToDo")
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.bottomMargin: 10
        highlighted: false
        flat: false
        icon.cache: true
        icon.color: "#568634"

        Connections {
            target: button
            onClicked: rectangle.isDialogOpen = !rectangle.isDialogOpen
        }
    }

    Rectangle {
        id: addToDoDialog
        x: 263
        y: 379
        width: 375
        height: 153
        visible: rectangle.isDialogOpen
        color: "#de8b19"
        radius: 30

        TextField {
            id: toDoTextInput
            height: 60
            text: "Add To Do"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.leftMargin: 25
            anchors.rightMargin: 25
            anchors.topMargin: 25
            placeholderText: qsTr("Add To Do")
        }

        RowLayout {
            x: 63
            y: 91
            spacing: 50
            Button {
                id: button1
                text: qsTr("cancelButton")
                Layout.fillWidth: true

                Connections {
                    target: button1
                    onClicked: rectangle.isDialogOpen = false
                }

                Connections {
                    target: button1
                    onClicked: toDoTextInput.text = ""
                }
            }

            Button {
                id: button2
                text: qsTr("addButton")
                transformOrigin: Item.Center
                Layout.fillWidth: true

                Connections {
                    target: button2
                    onClicked: rectangle.isDialogOpen = false
                }

                Connections {
                    target: button2
                    onClicked: myListModel.append(myListModel.createListElement())
                }
            }
        }
    }

    Text {
        id: _text
        height: 54
        text: qsTr("To Do")
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.topMargin: 2
        font.pixelSize: 26
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Column {
        id: column
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.topMargin: 50
        anchors.bottomMargin: 100
        spacing: 10

        Repeater {
            id: repeater
            visible: true
            anchors.fill: parent
            model: ListModel {
                id: myListModel
                ListElement {
                    name: "My To Do"
                }
                function createListElement() {
                    return {
                        "name": toDoTextInput.text
                    }
                }
            }

            Rectangle {
                id: toDoItem
                width: 800
                height: 59
                color: "#de8b19"
                radius: 30
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 10
                anchors.rightMargin: 10


                CheckBox {
                    id: checkBox
                    text: name
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 0
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    font.pointSize: 18
                }
            }
        }
    }
    states: [
        State {
            name: "clicked"
        }
    ]
}
