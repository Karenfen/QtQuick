import QtQuick 2.15
import QtQuick.Controls 2.15


Rectangle{
    id: root
    color: "#d6d6d6"
    radius: 15
    width: 300
    height: 300
    anchors.centerIn: parent
    property bool register: false
    property string textColor: "#535353"
    property string login: "login"
    property string password: "password"
    property string loginStateName: "login"
    property string signupStateName: "signup"
    state: loginStateName
    signal completed()

    states: [
        State {
            name: loginStateName
            PropertyChanges {
                target: root
                height: 250
            }
            PropertyChanges {
                target: repeatPasswordTextField
                visible: false
            }
            PropertyChanges {
                target: changeStateButton
                text: qsTr("Регистрация")
            }
            PropertyChanges {
                target: submitButton
                text: qsTr("Вход")
            }
        },
        State {
            name: signupStateName
            PropertyChanges {
                target: root
                height: 300
            }
            PropertyChanges {
                target: repeatPasswordTextField
                visible: true
            }
            PropertyChanges {
                target: changeStateButton
                text: qsTr("Вход")
            }
            PropertyChanges {
                target: submitButton
                text: qsTr("Регистрация")
            }
        }
    ]

    transitions: [
        Transition {
            from: loginStateName
            to: signupStateName
            SequentialAnimation {
                PropertyAction {
                    target: repeatPasswordTextField
                    property: "scale"
                    value: 0
                }


                PropertyAction {
                    target: repeatPasswordTextField
                    property: "visible"
                    value: true
                }

                PropertyAnimation {
                    target: root
                    property: "height"
                    duration: 200
                }

                ParallelAnimation {
                    PropertyAnimation {
                        target: repeatPasswordTextField
                        property: "opacity"
                        from: 0
                        to: 1
                        duration: 200
                    }
                    PropertyAnimation {
                        target: repeatPasswordTextField
                        property: "scale"
                        from: 0
                        to: 1
                        duration: 200
                        easing.type: Easing.OutBack
                    }
                }
            }
        },
        Transition {
            from: signupStateName
            to: loginStateName
            SequentialAnimation {
                ParallelAnimation {
                    PropertyAnimation {
                        target: repeatPasswordTextField
                        property: "opacity"
                        from: 1
                        to: 0
                        duration: 200
                    }
                    PropertyAnimation {
                        target: repeatPasswordTextField
                        property: "scale"
                        from: 1
                        to: 0
                        duration: 200
                    }
                }

                PropertyAction {
                    target: repeatPasswordTextField
                    property: "visible"
                    value: false
                }

                PropertyAnimation {
                    target: root
                    property: "height"
                    duration: 200
                }
            }
        }
    ]

    ParallelAnimation{
        id: loginFailAnimation

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
                to: root.textColor
                duration: 400
            }
        }

        SequentialAnimation {
            NumberAnimation {
                target: root
                property: "anchors.horizontalCenterOffset"
                to: -5
                duration: 50
            }

            NumberAnimation {
                target: root
                property: "anchors.horizontalCenterOffset"
                to: 5
                duration: 100
            }

            NumberAnimation {
                target: root
                property: "anchors.horizontalCenterOffset"
                to: 0
                duration: 50
            }
        }
    }

    ParallelAnimation{
        id: signaupFailAnimation

        SequentialAnimation {
            PropertyAnimation {
                targets: [repeatPasswordTextField, passwordTextField]
                property: "color"
                to: "dark red"
                duration: 0
                }

            PropertyAnimation {
                targets: [repeatPasswordTextField, passwordTextField]
                property: "color"
                to: root.textColor
                duration: 400
            }
        }

        SequentialAnimation {
            NumberAnimation {
                target: root
                property: "anchors.horizontalCenterOffset"
                to: -5
                duration: 50
            }

            NumberAnimation {
                target: root
                property: "anchors.horizontalCenterOffset"
                to: 5
                duration: 100
            }

            NumberAnimation {
                target: root
                property: "anchors.horizontalCenterOffset"
                to: 0
                duration: 50
            }
        }
    }

    SequentialAnimation{
        id: successAnimation

        PropertyAnimation {
            targets: root.children
            property: "opacity"
            to: 0
            duration: 200
        }

        PropertyAnimation {
            target: root
            property: "opacity"
            to: 0
            duration: 200
        }

        PropertyAction {
            target: root
            property: "visible"
            value: false
        }
    }


    function checkCredentials() {
        if(state === loginStateName)
        {
            if (login === loginTextField.text && password === passwordTextField.text)
            {
                successAnimation.start()
                completed()
            }
            else
                loginFailAnimation.start()
        }
        else
        {
            if(passwordTextField.text === repeatPasswordTextField.text && correctLogin(loginTextField.text))
            {
                successAnimation.start()
                register = true
                completed()
            }
            else
                signaupFailAnimation.start()
        }
    }

    function changeState(){
        if(state === loginStateName)
            state = signupStateName
        else
            state = loginStateName
    }

    function correctLogin(string){
        return (string.length > 0)
    }

    Column {
        id: column
        anchors.fill: parent
        padding: 15
        spacing: 15

        TextField {
            id: loginTextField
            anchors.horizontalCenter: parent.horizontalCenter
            placeholderText: qsTr("Логин")
            color: root.textColor
            Keys.onEnterPressed: root.checkCredentials()
            Keys.onReturnPressed: root.checkCredentials()
        }

        TextField {
            id: passwordTextField
            echoMode: showPassword.checked ? TextInput.Normal : TextInput.Password
            anchors.horizontalCenter: parent.horizontalCenter
            placeholderText: qsTr("Пароль")
            color: root.textColor
            Keys.onEnterPressed: root.checkCredentials()
            Keys.onReturnPressed: root.checkCredentials()
        }

        Switch {
            id: showPassword
            anchors.horizontalCenter: parent.horizontalCenter
            height: 25
            text: qsTr("Показать пароль")
        }

        TextField {
            id: repeatPasswordTextField
            echoMode: showPassword.checked ? TextInput.Normal : TextInput.Password
            anchors.horizontalCenter: parent.horizontalCenter
            placeholderText: qsTr("Повторите пароль")
            color: root.textColor
            Keys.onEnterPressed: root.checkCredentials()
            Keys.onReturnPressed: root.checkCredentials()
        }
    }

    Button {
        id: submitButton
        width: 200
        height: 40
        background: Rectangle {
            radius: height/2
            color: parent.down ? "#bbbbbb" :
            (parent.hovered ? "#AEDE48" : "#87D65A")
        }
        text: qsTr("Вход")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: changeStateButton.top
        Keys.onEnterPressed: root.checkCredentials()
        Keys.onReturnPressed: root.checkCredentials()
        onClicked: root.checkCredentials()
    }

    Button {
        id: changeStateButton
        text: qsTr("Регистрация")
        font.pointSize: 8
        height: 30
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        onPressed: changeState()
    }
}
