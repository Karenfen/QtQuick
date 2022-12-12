import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3

Rectangle{
    id: border
    width: 480
    height: 640
    color: "#d5e6e6"
    radius: 15
    antialiasing: true
    border.color: "#99b0b0"
    border.width: 2
    property string allInfo: ""
    signal finish()

    SequentialAnimation{
        id: closeAnimation

        PropertyAnimation {
            target: border
            property: "opacity"
            to: 0
            duration: 400
            easing.type: Easing.InQuad
        }

        PropertyAction {
            target: border
            property: "visible"
            value: false
        }
    }

    function sendData(){
        allInfo += "АНКЕТА \n Имя: " + name.text.toString() + "\n Пол: "
        if (myMale.checked) allInfo += qsTr("Муж")
        if (myFemale.checked) allInfo += qsTr("Жен")
        if(myGenderOther.checked) allInfo += qsTr("Другой")
        allInfo += "\n Возраст: " + myAge.value.toString()
              + "\n Город: " + city.text
              + "\n Образование: " + education.currentText
              + "\n Хобби: " + hobby.text
              + "\n О себе: " + aboutMe.text
              + "\nПОЖЕЛАНИЯ"
              + "\n Пол: "
        if(maleTo.checked) allInfo += qsTr("Муж")
        if(femaleTo.checked) allInfo += qsTr("Жен")
        if(anyGenderTo.checked) allInfo += qsTr("любой")
        allInfo += "\n Возвраст: от " + ageTo.first.value.toFixed().toString()
                + " до " + ageTo.second.value.toFixed().toString()
                + "\n Город: " + cityTo.text.toString()
        //print(allInfo)
    }

    Rectangle {
        id: root
        width: parent.width - 10
        height: parent.height - 20
        color: "#d5e6e6"
        radius: 15
        antialiasing: true
        anchors.centerIn: parent

        ScrollView{
            anchors.fill: parent
            clip: true
            contentWidth: parent.width

            ColumnLayout{
                anchors.top: parent.top
                layoutDirection: Qt.LeftToRight
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    text: qsTr("Анкета")
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.fillHeight: false
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                }

                GridLayout{
                    columns: 2
                    columnSpacing: 30
                    rowSpacing: 5
                    Layout.margins: 10
                    visible: true
                    layoutDirection: Qt.LeftToRight
                    flow: GridLayout.LeftToRight
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

                    Text { text: qsTr("ИМЯ"); font.pixelSize: 14; font.bold: true}

                    TextField { id: name; width: 100; height: 20; font.pixelSize: 14; maximumLength: 30
                        placeholderText: qsTr("введите имя")
                        horizontalAlignment: Text.AlignHCenter
                        Layout.fillWidth: true
                        background: Rectangle{
                            color: root.color
                            radius: 15
                            border.color: "grey"
                            border.width: 2
                            anchors.fill: parent
                            antialiasing: true
                            }
                        }

                    Text { text: qsTr("ПОЛ"); font.pixelSize: 14; font.bold: true }

                    RowLayout{
                        RadioButton { id: myMale; text: qsTr("муж") ;font.pointSize: 10 }
                        RadioButton { id: myFemale; text: qsTr("жен") ;font.pointSize: 10 }
                        RadioButton { id: myGenderOther; text: qsTr("другой") ;font.pointSize: 10 }
                    }

                    Text { text: qsTr("ВОЗВРАСТ"); font.pixelSize: 14; font.bold: true }

                    SpinBox { id: myAge; font.pointSize: 12;from: 18; to: 100 }

                    Text { text: qsTr("Город"); font.pixelSize: 14}

                    TextField { id: city; width: 100; height: 100; font.pixelSize: 14; maximumLength: 30
                        placeholderText: qsTr("введите город проживания")
                        horizontalAlignment: Text.AlignHCenter
                        Layout.fillWidth: true
                        background: Rectangle{
                            color: root.color
                            radius: 15
                            border.color: "grey"
                            border.width: 2
                            anchors.fill: parent
                            antialiasing: true
                            }
                    }


                    Text { text: qsTr("Образование"); font.pixelSize: 14 }

                    ComboBox {
                        id: education
                        font.pixelSize: 14
                        Layout.fillWidth: true
                        model: [qsTr("нет"), qsTr("среднее"), qsTr("средне спциальное"),  qsTr("высшее"), qsTr("неоконченное высшее")]
                    }

                    Text { text: qsTr("Хобби"); font.pixelSize: 14 }

                    Rectangle {
                        width: 200
                        height: 100
                        color: root.color
                        radius: 15
                        border.color: "grey"
                        border.width: 2
                        antialiasing: true

                        ScrollView{
                            anchors.fill: parent
                            clip: true

                            TextArea { id: hobby; font.pixelSize: 14; placeholderText: qsTr("укажите ваши хобби")}
                        }
                    }

                    Text { text: qsTr("О себе"); font.pixelSize: 14 }

                    Rectangle{
                        width: 200
                        height: 100
                        color: root.color
                        radius: 15
                        border.color: "grey"
                        border.width: 2
                        antialiasing: true

                        ScrollView{
                            anchors.fill: parent
                            clip: true

                            TextArea { id: aboutMe; font.pixelSize: 14 ; placeholderText: qsTr("напишите немного о себе")}
                        }
                    }
                }

                Text {
                    text: qsTr("Предпочтения")
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.fillHeight: false
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                }

                GridLayout{
                    columns: 2
                    columnSpacing: 30
                    rowSpacing: 5
                    Layout.margins: 10
                    visible: true
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

                    Text { text: qsTr("Пол"); font.pixelSize: 14}

                    RowLayout{
                        RadioButton { id: maleTo; text: qsTr("муж") ;font.pointSize: 10 }
                        RadioButton { id: femaleTo; text: qsTr("жен") ;font.pointSize: 10 }
                        RadioButton { id: anyGenderTo; text: qsTr("не важно") ;font.pointSize: 10 }
                    }

                    Text { text: qsTr("Возвраст"); font.pixelSize: 14}

                    RowLayout{
                        Label {font.pixelSize: 14; text: ageTo.first.value.toFixed()}
                        RangeSlider { id: ageTo; font.pointSize: 12;from: 18; to: 100; stepSize: 1}
                        Label {font.pixelSize: 14; text: ageTo.second.value.toFixed()}
                    }
                    Text { text: qsTr("Город"); font.pixelSize: 14}

                    TextField { id: cityTo; width: 100; height: 100; font.pixelSize: 14; maximumLength: 30
                        placeholderText: qsTr("введите город поиска")
                        horizontalAlignment: Text.AlignHCenter
                        Layout.fillWidth: true
                        background: Rectangle{
                            color: root.color
                            radius: 15
                            border.color: "grey"
                            border.width: 2
                            anchors.fill: parent
                            antialiasing: true
                            }
                    }

                }

                DelayButton{
                    id: acceptButton
                    transformOrigin: Item.Center
                    Layout.fillHeight: false
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    text: qsTr("Подтвердить")
                    delay: 600
                    font.pixelSize: 20

                    background: Rectangle{
                        radius: 15
                        opacity: 0.5
                        anchors.fill: parent
                        color: acceptButton.down ? "#17a81a" : "#80d18a"

                        ProgressBar{
                            anchors.bottom: parent.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width - parent.radius*2
                            from: 0
                            to: 1
                            value: acceptButton.progress
                        }
                    }

                    onActivated: [sendData(), closeAnimation.start(), finish(allInfo)]
                }
            }
        }
    }
}
