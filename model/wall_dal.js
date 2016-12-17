var mysql   = require('mysql');
var db  = require('./db_connection.js');

/* DATABASE CONFIGURATION */
var connection = mysql.createConnection(db.config);

/*
 create or replace view company_view as
 select s.*, a.street, a.zipcode from company s
 join address a on a.address_id = s.address_id;

 */

exports.getAll = function(callback) {
    var query = 'SELECT * FROM Wall w join Gym g on g.GYM_ID = w.GYM_ID group by WALL_ID;';

    connection.query(query, function(err, result) {
        callback(err, result);
    });
};

exports.getById = function(WALL_ID, callback) {
    var query = 'SELECT * FROM Wall w join Gym g on g.GYM_ID = w.WALL_ID where WALL_ID = ?;';
    var queryData = [WALL_ID];
    console.log(query);

    connection.query(query, queryData, function(err, result) {

        callback(err, result);
    });
};

exports.insert = function(params, callback) {
    var query = 'INSERT INTO Wall (wall_numb, style, height, GYM_ID) VALUES (?, ?, ?, ?)';

    // the question marks in the sql query above will be replaced by the values of the
    // the data in queryData
    var queryData = [params.wall_numb, params.style, params.height, params.GYM_ID];

    connection.query(query, queryData, function(err, result) {
        callback(err, result);
    });

};

exports.delete = function(WALL_ID, callback) {
    var query = 'DELETE FROM Wall WHERE WALL_ID = ?';
    var queryData = [WALL_ID];

    connection.query(query, queryData, function(err, result) {
        callback(err, result);
    });

};
