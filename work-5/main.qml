import QtQuick 2.15
import QtQuick.Controls 2.15
import "MyScrypt.js" as MyScript

ApplicationWindow {

    width: 480
    height: 480
    visible: true
    title: qsTr("Home work 5")
    property var component: undefined
    property var sprite: undefined

    function loggedIn(){
        tabBar.enabled = true
        destroyObject()
        sprite.completed.disconnect(loggedIn)
        main.clicked()
    }

    function destroyObject(){
        sprite.destroy()
        component.destroy()
    }

    function createSpriteObjects(url) {
        destroyObject()
        component = Qt.createComponent(url);
        sprite = component.createObject(appWindow);

        if (sprite == null) {
            // Error Handling
            console.log("Error creating object");
        }
    }
    Component.onCompleted: {
        component = Qt.createComponent("LoginPage.qml")
        sprite = component.createObject(appWindow)
        sprite.completed.connect(loggedIn)
    }

    Rectangle {
        id: appWindow
        anchors.fill: parent
    }

    footer: TabBar {
        id: tabBar
        enabled: false

        TabButton {
            id: main
            text: qsTr("Главная страница")
            property string value: "Page1.qml"
            onClicked: {createSpriteObjects(value)}
        }
        TabButton {
            text: qsTr("Бешеный квадрат")
            property string value: "Page2.qml"
            onClicked: {createSpriteObjects(value)}
        }
    }
}
