import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import com.Calculate 1.0


Window {
    id: root
    width: 400
    height: 800
    minimumHeight: 600
    minimumWidth: 300
    visible: true
    title: qsTr("Hello World")

    Calculate{
        id: calc
    }

    Rectangle {
        id: task1
        width: parent.width
        height: parent.height/2
        color: "#9fe5fc"

        function calculate(){
            textResult.text = calc.heronArea(spinBoxA.value/100, spinBoxB.value/100, spinBoxC.value/100)
            if(textResult.text == 0)
            {
                textResult.text = qsTr("некоректные данные")
                task1FailAnimation.start()
            }
        }

        ParallelAnimation{
            id: task1FailAnimation

            SequentialAnimation{
                PropertyAnimation {
                    targets: textResult
                    property: "color"
                    to: "dark red"
                    duration: 0
                }

                PropertyAnimation{
                    target: textResult
                    property: "color"
                    to: textResult.color
                    duration: 1000
                }
            }

            SequentialAnimation{
                NumberAnimation {
                    target: buttonCalculate
                    property: "anchors.horizontalCenterOffset"
                    to: -5
                    duration: 50
                }

                NumberAnimation {
                    target: buttonCalculate
                    property: "anchors.horizontalCenterOffset"
                    to: 5
                    duration: 100
                }

                NumberAnimation {
                    target: buttonCalculate
                    property: "anchors.horizontalCenterOffset"
                    to: 0
                    duration: 50
                }
            }
        }

        Image {
            id: image
            anchors.top: parent.top
            width: parent.width
            height: 100
            source: "formul.bmp"
            fillMode: Image.PreserveAspectFit
        }

        Label {
            id: labelA
            x: 9
            y: 106
            width: 80
            height: 30
            text: "a"
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Label {
            id: labelB
            x: 9
            y: 143
            width: 80
            height: 31
            text: qsTr("b")
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Label {
            id: labelC
            x: 9
            y: 180
            width: 80
            height: 29
            text: qsTr("c")
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        SpinBox {
            id: spinBoxA
            x: 95
            y: 106
            wrap: true
            editable: true
            from: 0
            value: 110
            to: 100 * 100
            stepSize: 10

            property int decimals: 2
            property real realValue: value / 100

            validator: DoubleValidator {
                bottom: Math.min(spinBoxA.from, spinBoxA.to)
                top:  Math.max(spinBoxA.from, spinBoxA.to)
            }

            textFromValue: function(value, locale) {
                return Number(value / 100).toLocaleString(locale, 'f', spinBoxA.decimals)
            }

            valueFromText: function(text, locale) {
                return Number.fromLocaleString(locale, text) * 100
            }
        }

        SpinBox {
            id: spinBoxB
            x: 95
            y: 143
            wrap: true
            editable: true
            from: 0
            value: 110
            to: 100 * 100
            stepSize: 10

            property int decimals: 2
            property real realValue: value / 100

            validator: DoubleValidator {
                bottom: Math.min(spinBoxB.from, spinBoxB.to)
                top:  Math.max(spinBoxB.from, spinBoxB.to)
            }

            textFromValue: function(value, locale) {
                return Number(value / 100).toLocaleString(locale, 'f', spinBoxB.decimals)
            }

            valueFromText: function(text, locale) {
                return Number.fromLocaleString(locale, text) * 100
            }
        }

        SpinBox {
            id: spinBoxC
            x: 95
            y: 179
            wrap: true
            editable: true
            from: 0
            value: 110
            to: 100 * 100
            stepSize: 10

            property int decimals: 2
            property real realValue: value / 100

            validator: DoubleValidator {
                bottom: Math.min(spinBoxC.from, spinBoxC.to)
                top:  Math.max(spinBoxC.from, spinBoxC.to)
            }

            textFromValue: function(value, locale) {
                return Number(value / 100).toLocaleString(locale, 'f', spinBoxC.decimals)
            }

            valueFromText: function(text, locale) {
                return Number.fromLocaleString(locale, text) * 100
            }
        }

        Button {
            id: buttonCalculate
            y: parent.height - 50
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.75
            height: 32
            text: qsTr("рассчитать")
            font.pointSize: 10
            spacing: 6
            onClicked: task1.calculate()
        }

        Label {
            id: labelS
            anchors.left: labelC.left
            anchors.top: spinBoxC.bottom
            width: 80
            height: 30
            text: qsTr("S")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            id: textResult
            anchors.left: labelS.right
            anchors.top: labelS.top
            width: 120
            height: 30
            text: qsTr("результат")
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.capitalization: Font.MixedCase
            style: Text.Normal
        }
    }

    Rectangle{
        id:task2
        width: parent.width
        height: parent.height/2
        anchors.top: task1.bottom
        color: "#facaf4"

        function calculate() {
            result2.text = calc.heronArea(inputAx.value, inputAy.value,
                                          inputBx.value, inputBy.value,
                                          inputCx.value, inputCy.value)

            if(result2.text == 0)
            {
                result2.text = qsTr("Ошибка")
                task2FailAnimation.start()
            }
        }

        ParallelAnimation{
            id: task2FailAnimation

            SequentialAnimation{
                PropertyAnimation {
                    targets: result2
                    property: "color"
                    to: "dark red"
                    duration: 0
                }

                PropertyAnimation{
                    target: result2
                    property: "color"
                    to: result2.color
                    duration: 1000
                }
            }

            SequentialAnimation{
                NumberAnimation {
                    target: buttonCalculate2
                    property: "anchors.horizontalCenterOffset"
                    to: -5
                    duration: 50
                }

                NumberAnimation {
                    target: buttonCalculate2
                    property: "anchors.horizontalCenterOffset"
                    to: 5
                    duration: 100
                }

                NumberAnimation {
                    target: buttonCalculate2
                    property: "anchors.horizontalCenterOffset"
                    to: 0
                    duration: 50
                }
            }
        }

//        Image {
//            id: scheme
//            source: "image2"
//            width: parent.width/2
//            height: parent.height/2
//            anchors.top: parent.top
//            anchors.left: parent.left
//            fillMode: Image.PreserveAspectFit
//        }

        Label{
            id: labelA2
            width: 100
            height: 30
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            text: qsTr(" A (x, y)")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Rectangle{
            id: inputA
            width: parent.width
            height: labelA2.height
            anchors.top: labelA2.bottom
            clip: true
            opacity: 0.5
            visible: true

            SpinBox {
                id: inputAy
                height: parent.height
                anchors.left: parent.horizontalCenter
                font.pixelSize: 12
                wrap: true
                editable: true
                stepSize: 1
                from: -100
                to: 100
            }

            SpinBox {
                id: inputAx
                height: parent.height
                anchors.right: parent.horizontalCenter
                font.pixelSize: 12
                wrap: true
                editable: true
                stepSize: 1
                from: -100
                to: 100
            }
        }

        Label{
            id: labelB2
            width: 100
            height: 30
            anchors.top: inputA.bottom
            anchors.left: labelA2.left
            text: qsTr(" B (x, y)")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Rectangle{
            id: inputB
            width: parent.width
            height: labelA2.height
            anchors.top: labelB2.bottom
            clip: true
            opacity: 0.5
            visible: true

            SpinBox {
                id: inputBy
                height: parent.height
                anchors.left: parent.horizontalCenter
                font.pixelSize: 12
                wrap: true
                editable: true
                stepSize: 1
                from: -100
                to: 100
            }

            SpinBox {
                id: inputBx
                height: parent.height
                anchors.right: parent.horizontalCenter
                font.pixelSize: 12
                wrap: true
                editable: true
                stepSize: 1
                from: -100
                to: 100
            }
        }

        Label{
            id: labelC2
            width: 100
            height: 30
            anchors.top: inputB.bottom
            anchors.left: labelB2.left
            text: qsTr(" C (x, y)")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Rectangle{
            id: inputC
            width: parent.width
            height: labelA2.height
            anchors.top: labelC2.bottom
            clip: true
            opacity: 0.5
            visible: true

            SpinBox {
                id: inputCy
                height: parent.height
                anchors.left: parent.horizontalCenter
                font.pixelSize: 12
                wrap: true
                editable: true
                stepSize: 1
                from: -100
                to: 100
            }

            SpinBox {
                id: inputCx
                height: parent.height
                anchors.right: parent.horizontalCenter
                font.pixelSize: 12
                wrap: true
                editable: true
                stepSize: 1
                from: -100
                to: 100
            }
        }

        Label{
            id: labelResult2
            width: 100
            height: 30
            anchors.top: inputC.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Результат")
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        TextField{
            id: result2
            width: parent.width/2
            height: 30
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: labelResult2.bottom
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: qsTr("Результат")
            readOnly: true
        }

        Button{
            id: buttonCalculate2
            y: parent.height - 50
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.75
            height: 30
            text: qsTr("рассчитать")
            font.pointSize: 10
            spacing: 6
            onClicked: task2.calculate()
        }
    }

    Rectangle{
        id: loginWindow
        color: "#d6d6d6"
        anchors.centerIn: parent
        radius: 5
        width: 300
        height: 250
        visible: false
        property string textColor: "#535353"
        property string login: "login"
        property string password: "password"

        ParallelAnimation{
            id: failAnimation

            SequentialAnimation {
                PropertyAnimation {
                    targets: [loginTextField, passwordTextField]
                    property: "color"
                    to: "dark red"
                    duration: 0
                    }

                PropertyAnimation {
                    targets: [loginTextField, passwordTextField]
                    property: "color"
                    to: loginWindow.textColor
                    duration: 400
                }
            }

            SequentialAnimation {
                NumberAnimation {
                    target: loginWindow
                    property: "anchors.horizontalCenterOffset"
                    to: -5
                    duration: 50
                }

                NumberAnimation {
                    target: loginWindow
                    property: "anchors.horizontalCenterOffset"
                    to: 5
                    duration: 100
                }

                NumberAnimation {
                    target: loginWindow
                    property: "anchors.horizontalCenterOffset"
                    to: 0
                    duration: 50
                }
            }
        }

        SequentialAnimation{
            id: successAnimation

            PropertyAnimation {
                targets: [loginTextField, passwordTextField, submitButton]
                property: "opacity"
                to: 0
                duration: 400
            }

            PropertyAnimation {
                target: loginWindow
                property: "opacity"
                to: 0
                duration: 600
            }

            PropertyAction {
                target: loginWindow
                property: "visible"
                value: false
            }
        }


        function checkCredentials() {
            if (login === loginTextField.text && password === passwordTextField.text)
                successAnimation.start()
            else
                failAnimation.start()
        }

        Column {
            anchors.fill: parent
            padding: 32
            spacing: 32

            TextField {
                id: loginTextField
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: qsTr("Логин")
                color: loginWindow.textColor
                Keys.onEnterPressed: loginWindow.checkCredentials()
                Keys.onReturnPressed: loginWindow.checkCredentials()
            }

            TextField {
                id: passwordTextField
                echoMode: TextInput.Password
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: qsTr("Пароль")
                color: loginWindow.textColor
                Keys.onEnterPressed: loginWindow.checkCredentials()
                Keys.onReturnPressed: loginWindow.checkCredentials()
            }

            Button {
                id: submitButton
                width: 200
                height: 40
                background: Rectangle {
                    color: parent.down ? "#bbbbbb" :
                    (parent.hovered ? "#AEDE48" : "#87D65A")
                }
                text: qsTr("Вход")
                anchors.horizontalCenter: parent.horizontalCenter
                Keys.onEnterPressed: loginWindow.checkCredentials()
                Keys.onReturnPressed: loginWindow.checkCredentials()
                onClicked: loginWindow.checkCredentials()
            }
        }
    }
}
