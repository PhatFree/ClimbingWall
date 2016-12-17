var mysql   = require('mysql');
var db  = require('./db_connection.js');

/* DATABASE CONFIGURATION */
var connection = mysql.createConnection(db.config);

exports.getAll = function(callback) {
    var query = 'SELECT * FROM route_view;';

    connection.query(query, function(err, result) {
        callback(err, result);
    });
};

exports.getById = function(ROUTE_ID, callback) {
    var query = 'SELECT * FROM route_view WHERE ROUTE_ID = ?';
    var queryData = [ROUTE_ID];

    connection.query(query, queryData, function(err, result) {
        callback(err, result);
    });
};

//NEW!!
exports.insert = function(params, callback) {
    var query = 'INSERT INTO Route (primary_color, date_set, name, WALL_ID) VALUES (?, current_date, ?, ?)';

    // the question marks in the sql query above will be replaced by the values of the
    // the data in queryData
    var queryData = [params.primary_color, params.name, params.WALL_ID];

    connection.query(query, queryData, function(err, result) {
        callback(err, result);
    });

};


exports.update = function(params, callback) {
    var query = 'UPDATE Route SET  date_cleared = ?, name = ?,  WHERE ROUTE_ID = ?';
    var queryData = [ params.date_cleared,params.name, params.ROUTE_ID];

    connection.query(query, queryData, function(err, result) {
        callback(err, result);
    });
};

exports.edit = function(ROUTE_ID, callback) {
    var query = 'SELECT * FROM Route WHERE ROUTE_ID = ?';
    var queryData = [ROUTE_ID];

    connection.query(query, queryData, function(err, result) {
        callback(err, result);
    });
};



exports.clear = function(ROUTE_ID, callback) {
    var query = 'Update Route set date_cleared = current_date where ROUTE_ID = ?';
    var queryData = [ROUTE_ID];

    connection.query(query, queryData, function (err, result) {
        callback(err, result);
    });
};

exports.delete = function(ROUTE_ID, callback) {
    var query = 'Delete From Route where ROUTE_ID = ?';
    var queryData = [ROUTE_ID];

    connection.query(query, queryData, function (err, result) {
        callback(err, result);
    });
};
