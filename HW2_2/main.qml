import QtQuick 2.12
import QtQuick.Controls 2.5

ApplicationWindow {
    id: main
    width: 600
    height: 800
    visible: true
    title: qsTr("Home work 2.2")

    property string loginStateName: "login"
    property string formFillingStateName: "form_filling"
    property string searchStateName: "searching"
    property string defaultStateName: "default"

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex
        state: loginStateName
        states: [
            State {
                name: loginStateName
                PropertyChanges {
                    target: logWin
                    visible: true
                }
                PropertyChanges {
                    target: swipeView
                    enabled: false
                }
                PropertyChanges {
                    target: searchHeader
                    visible: false
                }
                PropertyChanges {
                    target: tabBar
                    enabled: false
                }
            },
            State {
                name: formFillingStateName
                when: logWin.register && !formWin.finish
                PropertyChanges {
                    target: formWin
                    visible: true
                }
                PropertyChanges {
                    target: swipeView
                    enabled: false
                }
                PropertyChanges {
                    target: searchHeader
                    visible: false
                }
                PropertyChanges {
                    target: tabBar
                    enabled: false
                }
            },
            State {
                name: defaultStateName
                when: !logWin.visible && !formWin.visible && !searchHeader.running
                PropertyChanges {
                    target: swipeView
                    enabled: true
                }
                PropertyChanges {
                    target: searchHeader
                    visible: true
                }
                PropertyChanges {
                    target: tabBar
                    visible: true
                    enabled: true
                }
            },
            State {
                name: searchStateName
                when: searchHeader.running
                PropertyChanges {
                    target: swipeView
                    enabled: false
                }
                PropertyChanges {
                    target: tabBar
                    enabled: false
                }
            }
        ]

        transitions: [
            Transition {
                from: loginStateName + "," + formFillingStateName
                to: defaultStateName
                SequentialAnimation {
                    PropertyAction {
                        target: searchHeader
                        properties: "scale,opacity"
                        value: 0
                    }

                    PropertyAction {
                        targets: searchHeader.children
                        property: "scale"
                        value: 0
                    }

                    PropertyAction {
                        target: searchHeader
                        properties: "visible"
                        value: true
                    }

                    PropertyAnimation {
                        target: searchHeader
                        properties: "scale,opacity"
                        to: 1
                        duration: 200
                    }

                    PropertyAnimation {
                        targets: searchHeader.children
                        property: "scale"
                        to: 1
                        duration: 200
                        easing.type: Easing.OutBack
                    }
                }
            },
            Transition {
                from: loginStateName
                to: formFillingStateName
                PropertyAnimation {
                    target: formWin
                    properties: "opacity,scale"
                    from: 0
                    to: 1
                    duration: 500
                }
            }
        ]

        Page1Form {
            id: page1
            info: formWin.allInfo
        }

        Page2Form {
        }
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: qsTr("Task 1")
        }
        TabButton {
            text: qsTr("Task 2")
        }
    }

    header: Header {
        id: searchHeader
        width: parent.width
    }

    Questionary{
        id: formWin
        visible: false
        anchors.centerIn: parent
    }

    LoginForm{
        id: logWin
        anchors.centerIn: parent
        visible: true
    }
}
