var mysql   = require('mysql');
var db  = require('./db_connection.js');

/* DATABASE CONFIGURATION */
var connection = mysql.createConnection(db.config);

exports.getAll = function(callback) {
    var query = 'SELECT * FROM Climber;';

    connection.query(query, function(err, result) {
        callback(err, result);
    });
};

exports.getById = function(CLIMB_ID, callback) {
    var query = 'SELECT * FROM Climber WHERE CLIMB_ID = ?';
    var queryData = [CLIMB_ID];

    connection.query(query, queryData, function(err, result) {
        callback(err, result);
    });
};

//NEW!!
exports.insert = function(params, callback) {
    var query = 'INSERT INTO Climber (email, first, last) VALUES (?, ?, ?)';

    // the question marks in the sql query above will be replaced by the values of the
    // the data in queryData
    var queryData = [params.email, params.first, params.last];

    connection.query(query, queryData, function(err, result) {
        callback(err, result);
    });

};


exports.update = function(params, callback) {
    var query = 'UPDATE Climber SET email = ?, first = ?, last = ?  WHERE CLIMB_ID = ?';
    var queryData = [params.email, params.first, params.last, params.CLIMB_ID];

    connection.query(query, queryData, function(err, result) {
        callback(err, result);
    });
};

exports.edit = function(CLIMB_ID, callback) {
    var query = 'SELECT * FROM Climber WHERE CLIMB_ID = ?';
    var queryData = [CLIMB_ID];

    connection.query(query, queryData, function(err, result) {
        callback(err, result);
    });
};


exports.delete = function(CLIMB_ID, callback) {
    var query = 'DELETE FROM Climber WHERE CLIMB_ID = ?';
    var queryData = [CLIMB_ID];

    connection.query(query, queryData, function(err, result) {
        callback(err, result);
    });

};