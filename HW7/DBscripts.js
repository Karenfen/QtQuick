function createTableContacts(tx) {
    const sql =
              'CREATE TABLE IF NOT EXISTS contacts (' +
              'contact_id INTEGER PRIMARY KEY,' +
              'first_name TEXT NOT NULL,' +
              'last_name TEXT NOT NULL,' +
              'email TEXT NOT NULL UNIQUE,' +
              'phone TEXT NOT NULL UNIQUE' +
              ');'
    tx.executeSql(sql)
}

function createTableStaff(tx) {
    const sql =
              'CREATE TABLE IF NOT EXISTS staff (' +
              'employee_id INTEGER PRIMARY KEY,' +
              'first_name TEXT NOT NULL,' +
              'last_name TEXT NOT NULL,' +
              'position TEXT NOT NULL,' +
              'salary TEXT NOT NULL' +
              ');'
    tx.executeSql(sql)
}

function readContacts(tx, model) {
    const sql = 'SELECT contact_id, first_name, last_name, email, phone FROM contacts';
    var result = tx.executeSql(sql)

    for(var i = 0; i < result.rows.length; ++i)
    {
        model.appendRow({
                        id: result.rows.item(i).contact_id,
                        first_name: result.rows.item(i).first_name,
                        last_name: result.rows.item(i).last_name,
                        email: result.rows.item(i).email,
                        phone: result.rows.item(i).phone
                        })
    }
}

function readStaff(tx, model) {
    const sql = 'SELECT employee_id, first_name, last_name, position, salary FROM staff';
    var result = tx.executeSql(sql)

    for(var i = 0; i < result.rows.length; ++i)
    {
        model.appendRow({
                        id: result.rows.item(i).employee_id,
                        first_name: result.rows.item(i).first_name,
                        last_name: result.rows.item(i).last_name,
                        position: result.rows.item(i).position,
                        salary: result.rows.item(i).salary
                        })
    }
}

function addContact(tx, first_name, last_name, email, phone) {
    const sql = 'INSERT INTO contacts (first_name, last_name, email, phone)' +
                'VALUES("%1", "%2", "%3", "%4");'.arg(first_name).arg(last_name).arg(email).arg(phone)

     return tx.executeSql(sql)
}

function addEmployee(tx, first_name, last_name, position, salary) {
    const sql = 'INSERT INTO staff (first_name, last_name, position, salary)' +
                'VALUES("%1", "%2", "%3", "%4");'.arg(first_name).arg(last_name).arg(position).arg(salary)

     return tx.executeSql(sql)
}

function updateContact(tx, model, index){
    var parametrs = ['contact_id', 'first_name', 'last_name', 'email', 'phone']
    var row = model.getRow(index.row)

    const sql = 'UPDATE contacts SET ' + parametrs[index.column] +
              ' = \'' + model.data(index, "display") +
              '\' WHERE contact_id = ' + row.id;

    return tx.executeSql(sql)
}

function updateEmployee(tx, model, index){
    var parametrs = ['employee_id', 'first_name', 'last_name', 'position', 'salary']
    var row = model.getRow(index.row)

    const sql = 'UPDATE staff SET ' + parametrs[index.column] +
                ' = \'' + model.data(index, "display") +
                '\' WHERE employee_id = ' + row.id;

    return tx.executeSql(sql)
}
