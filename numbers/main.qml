import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15



Window {
    id: appWin
    width: 480
    height: 640
    minimumHeight: 400
    minimumWidth: 400
    visible: true
    title: qsTr("Numbers")

    property string host: "http://numbersapi.com/"
    property string numbType: ""

    function searching(){
        var xmlhttp = new XMLHttpRequest();
        var url = host + ((numbText.text == "")? "random" : numbText.text) + numbType + "?json"

        xmlhttp.onreadystatechange = function() {
            if (xmlhttp.readyState == XMLHttpRequest.DONE) {
                if(xmlhttp.status == 200)
                {
                    var jsonObj = JSON.parse(xmlhttp.responseText)
                    if(jsonObj.found != true)
                    {
                        resultWindow.result = qsTr("Nothing found")
                    }
                    else
                    {
                        resultWindow.result = jsonObj.text
                    }
                }
                else
                {
                    resultWindow.result = qsTr("Ошибка: ") + xmlhttp.statusText
                }

                rootRect.state = rootRect.resultShowState
            }
        }
        xmlhttp.open("GET", url, true);
        xmlhttp.setRequestHeader('Content-Type', 'application/json')
        xmlhttp.send();
    }

    function setStateDefault(){
        rootRect.state = rootRect.defaultState
    }

    Rectangle {
        id: rootRect
        anchors.fill: parent
        color: "#f0f4fa"
        property string defaultState: "default"
        property string searchingState: "searching"
        property string resultShowState: "resultShow"
        state: defaultState
        states: [
            State {
                name: rootRect.searchingState
                PropertyChanges {
                    target: searchButtom
                    enabled: false
                }
                PropertyChanges {
                    target: numbText
                    enabled: false
                }
                PropertyChanges {
                    target: proccesIndicator
                    running: true
                }
            },

            State {
                name: rootRect.resultShowState
                PropertyChanges {
                    target: searchButtom
                    enabled: false
                }
                PropertyChanges {
                    target: numbText
                    enabled: false
                }
                PropertyChanges {
                    target: proccesIndicator
                    running: false
                }
                PropertyChanges {
                    target: resultWindow
                    visible: true
                }
            }
        ]

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 10
            TextField {
                id: numbText
                width: 200
                height: 50
                Layout.alignment: Qt.AlignHCenter
                horizontalAlignment: "AlignHCenter"
                font.pointSize: 20
                visible: true
                placeholderText: qsTr("Enter a number")
                inputMethodHints: Qt.ImhDigitsOnly
            }

            RowLayout{
                Layout.alignment: Qt.AlignHCenter
                RadioButton { id: mathRB; text: qsTr("Math") ;font.pointSize: 10;
                    property string value: "/math"; onClicked: appWin.numbType = "/math" }
                RadioButton { id: truvuaRB; text: qsTr("Ttivia") ;font.pointSize: 10;
                    property string value: "/trivia"; onClicked: appWin.numbType = "/trivia" }
                RadioButton { id: dateRB; text: qsTr("Date") ;font.pointSize: 10;
                    property string value: "/date"; onClicked: appWin.numbType = "/date" }
                RadioButton { id: yearRB; text: qsTr("Year") ;font.pointSize: 10;
                    property string value: "/year"; onClicked: appWin.numbType = "/year" }
                RadioButton { id: allRB; text: qsTr("All") ;font.pointSize: 10; checked: true;
                    property string value: ""; onClicked: appWin.numbType = "" }
            }

            Button {
                id:searchButtom
                Layout.preferredWidth: 200
                Layout.preferredHeight: 50
                Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                text: qsTr("Search")
                font.pointSize: 14
                state: "default"

                background: Rectangle {
                    id: searchButtomBack
                    anchors.fill: parent
                    color: "#0fd142"
                    radius: width/2
                }

                states: State {
                    name: "pressed"
                    when: searchButtom.down
                    PropertyChanges {
                        target: searchButtomBack
                        color: "#93faaf"
                    }
                }

                onClicked: {
                    rootRect.state = rootRect.searchingState
                    searching()
                }
            }
        }
    }

    BusyIndicator {
        id: proccesIndicator
        anchors.centerIn: rootRect
        width: 100
        height: 100
        running: false

    }

    ResultInfoWin {
        id: resultWindow
        width: appWin.minimumWidth
        height: appWin.minimumHeight
        anchors.centerIn: parent
        visible: false
        Component.onCompleted: {
            ok.connect(appWin.setStateDefault)
            searchAgain.connect(appWin.searching)
        }
    }
}
