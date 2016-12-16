var mysql   = require('mysql');
var db  = require('./db_connection.js');

/* DATABASE CONFIGURATION */
var connection = mysql.createConnection(db.config);

/*
 create or replace view school_view as
 select s.*, a.street, a.zipcode from gym s
 join address a on a.address_id = s.address_id;

 */

exports.getAll = function(callback) {
    var query = 'SELECT * FROM gym_view;';

    connection.query(query, function(err, result) {
        callback(err, result);
    });
};

exports.getById = function(GYM_ID, callback) {
    var query = 'SELECT * FROM gym_view WHERE GYM_ID = ?';
    var queryData = [GYM_ID];

    connection.query(query, queryData, function(err, result) {
        callback(err, result);
    });
};

exports.insert = function(params, callback) {
    var query = 'INSERT INTO Gym (name, street_num, street_name, zip, state) VALUES (?, ?, ?, ?, ?)';

    // the question marks in the sql query above will be replaced by the values of the
    // the data in queryData
    var queryData = [params.name, params.street_num, params.street_name, params.zip, params.state];

    connection.query(query, queryData, function(err, result) {
        callback(err, result);
    });

};

exports.delete = function(GYM_ID, callback) {
    var query = 'DELETE FROM gym WHERE GYM_ID = ?';
    var queryData = [GYM_ID];

    connection.query(query, queryData, function(err, result) {
        callback(err, result);
    });

};

exports.update = function(params, callback) {
    var query = 'UPDATE Gym SET name = ?, street_num = ?, street_name = ?, zip = ?, state = ? WHERE GYM_ID = ?';
    var queryData = [params.name, params.street_num, params.street_name, params.zip, params.state, params.GYM_ID];

    connection.query(query, queryData, function(err, result) {
        callback(err, result);
    });
};

exports.edit = function(GYM_ID, callback) {
    var query = 'Select * from Gym where GYM_ID = ?';
    var queryData = [GYM_ID];

    connection.query(query, queryData, function(err, result) {
        callback(err, result);
    });
};