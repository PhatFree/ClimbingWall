var mysql   = require('mysql');
var db  = require('./db_connection.js');

/* DATABASE CONFIGURATION */
var connection = mysql.createConnection(db.config);

exports.aboutStats = function(callback) {
    var query = 'SELECT * FROM db_stats;';

    connection.query(query, function(err, result) {
        callback(err, result);
    });
};
