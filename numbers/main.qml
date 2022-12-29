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


    SwipeView {
        anchors.fill: parent

        Task1Page {

        }

        Task2Page {

        }
    }
}
