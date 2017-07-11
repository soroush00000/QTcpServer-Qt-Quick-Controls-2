import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.1

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    property var sit : true
    property var space: 540
    signal sendTextToC(string text)



    title: qsTr("server")

    ListModel {
        id: messageModel
    }


    Label{
        id:logo
        text:"Waiting for Connection..."
        color: "#FF5722"
        font.pixelSize: 20
        x:parent.width/2 - 110
        y:parent.height/2 - 100

    }


    ColumnLayout {
        anchors { fill: parent; margins: 8 }
        spacing: 16


        ListView {

            Layout.fillWidth: true; height: 420
            model: messageModel
            delegate: ItemDelegate { text: model.message; checked: true;}
            preferredHighlightEnd: ListView.StrictlyEnforceRange
            clip: true
        }
        RowLayout {
            spacing: 16
            y:200
            Layout.fillWidth: true; Layout.fillHeight: false
            x:300

            TextField {
                id: textField
                Layout.fillWidth: true; Layout.fillHeight: true
                placeholderText: "Write a message..."
                background: null
                focus: true
                Keys.onPressed: {
                    if (event.key == Qt.Key_Enter && textField.text != "") {
                        logo.visible = false
                        messageModel.append({message: textField.text});
                        sendTextToC(textField.text)
                        textField.text = ""
                    }
                }
            }
            Button {
                id: send
                Material.foreground: "white"; Material.background: Material.DeepOrange
                Layout.fillHeight: true
                text: "Send"
                onClicked: {
                    if(textField.text != "")
                    {
                        logo.visible = false
                        messageModel.append({message: textField.text});
                        sendTextToC(textField.text)
                        textField.text = ""
                        
                    }
                }


            }
        }
    }
    Page1{}

    function setMessage(string){
        messageModel.append({message:"Client: " + string})
    }

    property  string textA : sentMessage.callMeFromQml()
    property string textB
    Timer {
        id:timer;interval: 1; running: true; repeat: true
        onTriggered: {


            if(textA != "" && textA.localeCompare(textB) != 0)
            {
                messageModel.append({message:"Cilent: " + textA})
                textB = textA
                logo.visible = false
            } else{
                textA = sentMessage.callMeFromQml()
            }
        }
    }
}


