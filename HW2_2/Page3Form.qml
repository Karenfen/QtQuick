import QtQuick 2.12
import QtQuick.Controls 2.5

Page {
    width: 600
    height: 400

    function openBoock(string){

    }

    Item {
        id: library
        anchors.fill: parent

        ListModel {
            id: libModel

            ListElement {
                coverPath: "covers/cover1.jpg"
                name: "Критика чистого разума"
                genre: "Трактат"
                author: "Иммануил Кант"
            }
            ListElement {
                coverPath: "covers/cover2.jpg"
                name: "Божественная комедия"
                genre: "Эпос"
                author: "Данте Алигьери"
            }
            ListElement {
                coverPath: "covers/cover3.jpg"
                name: "Психология лжи"
                genre: "Литература по саморазвитию"
                author: "Пол Экман"
            }
            ListElement {
                coverPath: "covers/cover4.jpg"
                name: "Будущее одной иллюзии "
                genre: "психоанализ"
                author: "Зигмунд Фрейд"
            }
        }
    }

    ListView {
        id: libWiew
        anchors.fill: parent
        model: libModel
        spacing: 5

        header: Rectangle {
            width: parent.width
            height: 15
            color: "#e6e0c8"

            Text {
                anchors.centerIn: parent
                text: qsTr("Моя библиотека")
                color: "#3d3c34"
            }
        }

        footer: Rectangle {
            width: parent.width
            height: 10
            color: "#e6e0c8"

            Text {
                anchors.centerIn: parent
                text: qsTr("Создатель: Илья Киселёв")
                font.pointSize: 8
                color: "#3d3c34"
            }
        }

        section.delegate: Rectangle {
            width: parent.width
            height: 15
            color: "#e6e0c8"
            Text {
                anchors.centerIn: parent
                text: section
                color: "#3d3c34"
                font.bold: true
                verticalAlignment: Text.AlignVCenter
            }
        }

        section.property: "genre"

        delegate: Rectangle {
            width: libWiew.width
            height: 50
            color: "#f0eee6"

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.RightButton
                onDoubleClicked: libWiew.model.remove(index)
            }

            Row {
                id: row
                anchors.fill: parent
                spacing: 5
                anchors.leftMargin: 1
                anchors.bottomMargin: 1
                anchors.topMargin: 1

                Image {
                    id: cover
                    height: parent.height
                    width: height
                    asynchronous: true
                    fillMode: Image.PreserveAspectFit
                    source: libWiew.model.get(index).coverPath
                }

                Column {
                    id: names
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 1
                    Text {
                        text: qsTr("Название:")
                        font.bold: true
                        horizontalAlignment: Text.AlignRight
                        verticalAlignment: Text.AlignVCenter
                    }
                    Text {
                        text: qsTr("Автор:")
                        font.bold: true
                        horizontalAlignment: Text.AlignRight
                        verticalAlignment: Text.AlignVCenter
                    }
                    Text {

                        text: qsTr("Жанр:")
                        font.bold: true
                        horizontalAlignment: Text.AlignRight
                        verticalAlignment: Text.AlignVCenter
                    }
                }
                Column {
                    id: column
                    width: parent.width - cover.width - names.width - parent.spacing * 2
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 1
                    Text {
                        text: name
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text {
                        text: author
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text {
                        text: genre
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
        }

        focus: true

        populate: Transition {
            PropertyAnimation{
                properties: "scale,opacity"
                from: 0
                to: 1
                duration: 200
            }
        }

        remove: Transition {
            ParallelAnimation{
                PropertyAnimation{
                    property: "opacity"
                    from: 1
                    to: 0
                    duration: 300
                }
                NumberAnimation {
                    property: "x"
                    to: width
                    duration: 300
                }
            }
        }

        Keys.onEnterPressed: openBoock(libWiew.model.get(index).coverPath)
    }
}
