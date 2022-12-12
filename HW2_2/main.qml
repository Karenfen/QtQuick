import QtQuick 2.12
import QtQuick.Controls 2.5

ApplicationWindow {
    width: 600
    height: 800
    visible: true
    title: qsTr("Home work 2.2")

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page1Form {
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
}
