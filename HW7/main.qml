import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.LocalStorage 2.15
import Qt.labs.qmlmodels 1.0
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import "DBscripts.js" as DBfunctions


Window {
    id: appWin
    width: 640
    height: 480
    visible: true
    title: qsTr("Yome work №7")
    property int cellHorizontalSpacing: 10
    property var myDB: LocalStorage.openDatabaseSync("DBfromHW7", "1.0", "Data base from home work 7", 1024)


    Component.onCompleted: {
        try {
            myDB.transaction(DBfunctions.createTableContacts)
            myDB.transaction(DBfunctions.createTableStaff)
        } catch (error) {
            console.log("Error creating or updating table in database: " + error)
        }
    }

    function bdDataToModel(tx, model){
        try {
            switch (model){
            case contactsModel:
                myDB.transaction((tx) => {DBfunctions.readContacts(tx, model)})
                break
            case staffModel:
                myDB.transaction((tx) => {DBfunctions.readStaff(tx, model)})
                break
            }
        }catch (error){
            console.log("Error creating or updating table in database: " + error)
        }
    }

    function switchModel(){
        switch(choseTable.currentText){
        case qsTr("Contacts"):
            table.model = contactsModel
            email_position.placeholderText =  qsTr("E-mail")
            phone_salary.placeholderText = qsTr("Номер телефона")
            break
        case qsTr("Staff"):
            table.model = staffModel
            email_position.placeholderText =  qsTr("Должность")
            phone_salary.placeholderText = qsTr("Оклад")
            break
        }
    }

    function addRowToModel(tx, model) {
        var resObj

        try {
            switch (model) {
            case contactsModel:
                myDB.transaction((tx) => {
                    resObj = DBfunctions.addContact(tx, firstName.text,
                                                            lastName.text,
                                                            email_position.text,
                                                            phone_salary.text);
                    if (resObj.rowsAffected !== 0) {
                        model.appendRow({
                            id: resObj.insertId,
                            first_name: firstName.text,
                            last_name: lastName.text,
                            email: email_position.text,
                            phone: phone_salary.text
                        })
                    }
                })
                break
            case staffModel:
                myDB.transaction((tx) => {
                    resObj = DBfunctions.addEmployee(tx, firstName.text,
                                                            lastName.text,
                                                            email_position.text,
                                                            phone_salary.text);
                    if (resObj.rowsAffected !== 0) {
                        model.appendRow({
                            id: resObj.insertId,
                            first_name: firstName.text,
                            last_name: lastName.text,
                            position: email_position.text,
                            salary: phone_salary.text
                        })
                    }
                })
                break
            }
        } catch (error) {
            console.log("Error creating or updating table in database: " + error)
        }
    }

    TableModel {
        id: contactsModel

        TableModelColumn { display: "id" }
        TableModelColumn { display: "first_name" }
        TableModelColumn { display: "last_name" }
        TableModelColumn { display: "email" }
        TableModelColumn { display: "phone" }

        rows: []

        onDataChanged: {
            try{
                myDB.transaction((tx) => {DBfunctions.updateContact(tx, contactsModel, topLeft)})
            }catch(error){
                console.log("error sql: " + error)
            }
        }
    }

    TableModel {
        id: staffModel

        TableModelColumn { display: "id" }
        TableModelColumn { display: "first_name" }
        TableModelColumn { display: "last_name" }
        TableModelColumn { display: "position" }
        TableModelColumn { display: "salary" }

        rows: []

        onDataChanged: {
            try{
                myDB.transaction((tx) => {DBfunctions.updateEmployee(tx, staffModel, topLeft)})
            }catch(error){
                console.log("error sql: " + error)
            }
        }
    }

    ColumnLayout {
        id: rootLayout
        anchors.fill: parent


        ComboBox{
            id: choseTable
            Layout.fillWidth: true
            font.pointSize: 14
            model: [qsTr("Contacts"), qsTr("Staff")]
            onActivated: switchModel()
        }

        TableView {
            id: table
            Layout.fillHeight: true
            Layout.fillWidth: true
            visible: true
            model: contactsModel
            rowSpacing: 1
            delegate:  Rectangle {
                implicitWidth: Math.max(100, /*left*/ cellHorizontalSpacing + innerText.width + /*right*/ cellHorizontalSpacing)
                implicitHeight: 50
                border.width: 1

                TextInput {
                    id: innerText
                    text: model.display
                    selectByMouse: true
                    anchors.centerIn: parent
                    onAccepted: model.display = text
                }
            }

            Component.onCompleted: {
                appWin.bdDataToModel(table.tx, contactsModel)
                appWin.bdDataToModel(table.tx, staffModel)
            }
        }

        Button {
            id: addRow
            //implicitWidth: 200
            //Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true
            text: qsTr("Добавить запись")
            font.pointSize: 14

            onClicked: addDialog.open()
        }
    }

    Dialog {
        id: addDialog
        anchors.centerIn: parent
        title: "Add persone"
        standardButtons: Dialog.Ok | Dialog.Cancel

        function clear(){
            firstName.clear()
            lastName.clear()
            email_position.clear()
            phone_salary.clear()
        }

        Column {
            anchors.fill: parent
            spacing: 5

            TextField {
                id: firstName
                placeholderText: qsTr("Имя")
            }

            TextField {
                id: lastName
                placeholderText: qsTr("Фамилия")
            }

            TextField {
                id: email_position
                placeholderText:  qsTr("E-mail")
            }

            TextField {
                id: phone_salary
                placeholderText: qsTr("Номер телефона")
            }
        }

        onAccepted: {
            addRowToModel(table.tx, table.model)
            addDialog.clear()
        }
    }
}
