import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.1

Rectangle{
    id: decorate
    color: "#FF5722"
    width: parent.width
    height: 25
    x:0
    y:0

    MouseArea {
        anchors.fill: parent
        property variant clickPos: "1,1"

        onPressed: {
            clickPos  = Qt.point(mouse.x,mouse.y)
        }

        onPositionChanged: {
            var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
            window.x += delta.x;
            window.y += delta.y;
        }

    }


    Text {
        id: name
        text: qsTr("Server")
        y:5
        x:45
        color: "white"
    }

    Button{
        id:exitButton
        x:630
        y:-7
        width: 30
        height: 36
        flat: true


        Item
        {
            id:obliqueOne
            height: 50
            width: 50
            x: 0
            y: 3

            Canvas
            {
                anchors.fill: parent
                onPaint:
                {
                    var ctx = getContext("2d")

                    ctx.fillStyle = "white"
                    ctx.lineWidth = 2;
                    ctx.strokeStyle = "white"
                    ctx.beginPath()
                    ctx.moveTo(10, 9.5)
                    ctx.lineTo(20, 20)
                    ctx.stroke()

                }
            }
        }
        Item
        {
            id:diagonalLineIncreasing
            height: 50
            width: 50
            x: 9
            y: 3

            Canvas
            {
                anchors.fill: parent
                onPaint:
                {
                    var ctx = getContext("2d")
                    ctx.fillStyle = "white"
                    ctx.lineWidth = 2;
                    ctx.strokeStyle = "white"
                    ctx.beginPath()
                    ctx.moveTo(9.5, 9.5)
                    ctx.lineTo(2,20)
                    ctx.stroke()

                }
            }
        }
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                window.close()
            }
        }
    }
    Button{
        id: maximaize
        x:605
        y:-5
        width: 25
        height: 36
        flat: true


        onClicked: {
            if(sit){
                window.Maximized
                sit = false

            } else{

                sit = true
            }
        }

        Item
        {
            height: 50
            width: 50
            x: -3
            y: 1

            Canvas
            {
                anchors.fill: parent
                onPaint:
                {
                    var ctx = getContext("2d")

                    ctx.fillStyle = "white"
                    ctx.lineWidth = 2;
                    ctx.strokeStyle = "white"
                    ctx.beginPath()
                    ctx.moveTo(10, 10)
                    ctx.lineTo(10, 22)
                    ctx.stroke()

                }
            }
        }
        Item
        {
            height: 50
            width: 50
            x: 8
            y: 1

            Canvas
            {
                anchors.fill: parent
                onPaint:
                {
                    var ctx = getContext("2d")

                    ctx.fillStyle = "white"
                    ctx.lineWidth = 2;
                    ctx.strokeStyle = "white"
                    ctx.beginPath()
                    ctx.moveTo(10, 10)
                    ctx.lineTo(10, 22)
                    ctx.stroke()

                }
            }
        }
        Item
        {
            height: 50
            width: 50
            x: -4
            y: 1

            Canvas
            {
                anchors.fill: parent
                onPaint:
                {
                    var ctx = getContext("2d")

                    ctx.fillStyle = "white"
                    ctx.lineWidth = 2;
                    ctx.strokeStyle = "white"
                    ctx.beginPath()
                    ctx.moveTo(10, 10)
                    ctx.lineTo(22.75, 10)
                    ctx.stroke()

                }
            }
        }
        Item
        {
            height: 50
            width: 50
            x: -4
            y:12
            Canvas
            {
                anchors.fill: parent
                onPaint:
                {
                    var ctx = getContext("2d")

                    ctx.fillStyle = "white"
                    ctx.lineWidth = 2;
                    ctx.strokeStyle = "white"
                    ctx.beginPath()
                    ctx.moveTo(10, 10)
                    ctx.lineTo(22.75, 10)
                    ctx.stroke()

                }
            }
        }

    }
    Button{
        id:restoreDown
        x:580
        width: 25
        height: 36
        y:-5
        flat: true
        onClicked: window.showMinimized()
        Item
        {
            height: 50
            width: 50
            x: -4
            y:13
            Canvas
            {
                anchors.fill: parent
                onPaint:
                {
                    var ctx = getContext("2d")

                    ctx.fillStyle = "white"
                    ctx.lineWidth = 2;
                    ctx.strokeStyle = "white"
                    ctx.beginPath()
                    ctx.moveTo(10, 10)
                    ctx.lineTo(22.75, 10)
                    ctx.stroke()

                }
            }
        }

    }
}
