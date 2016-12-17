var express = require('express');
var router = express.Router();
var route_dal = require('../model/route_dal');
var wall_dal = require('../model/wall_dal');


// View All routees
router.get('/all', function(req, res) {
    route_dal.getAll(function(err, result){
        if(err) {
            res.send(err);
        }
        else {
            res.render('route/routeViewAll', { 'result':result });
        }
    });

});

// View the route for the given id
router.get('/', function(req, res){
    if(req.query.ROUTE_ID == null) {
        res.send('ROUTE_ID is null');
    }
    else {
        route_dal.getById(req.query.ROUTE_ID, function(err,result) {
           if (err) {
               res.send(err);
           }
           else {
               console.log(result);
               res.render('route/routeViewById', {'result': result[0]});
           }
        });
    }
});


// Return the add a new routeform
router.get('/add', function(req, res){
    // passing all the query parameters (req.query) to the insert function instead of each individually
    wall_dal.getAll(function(err,result) {
        if (err) {
            res.send(err);
        }
        else {
            res.render('route/routeAdd', {'result': result});
        }
    });
});

// View the route for the given id
router.get('/insert', function(req, res){
    // simple validation
    console.log(req.query);
    if(req.query.WALL_ID == null) {
        res.send('A wall must be provided.');
    }
    else if(req.query.primary_color == null) {
        res.send('A color must be provided');
    }

    else {
        // passing all the query parameters (req.query) to the insert function instead of each individually
        route_dal.insert(req.query, function(err) {
            if (err) {
                res.send(err);
            }
            else {
                //poor practice, but we will handle it differently once we start using Ajax
                res.redirect(302, '/route/all');
            }
        });
    }
});

// Delete a route for the given ROUTE_ID
router.get('/clear', function(req, res){
    if(req.query.ROUTE_ID == null) {
        res.send('ROUTE_ID is null');
    }
    else {
        route_dal.clear(req.query.ROUTE_ID, function(err){
            console.log(req.query);
            if(err) {
                res.send(err);
            }
            else {
                //poor practice, but we will handle it differently once we start using Ajax
                res.redirect(302, '/route/all');
            }
        });
    }
});

router.get('/delete', function(req, res){
    if(req.query.ROUTE_ID == null) {
        res.send('ROUTE_ID is null');
    }
    else {
        route_dal.delete(req.query.ROUTE_ID, function(err){
            console.log(req.query);
            if(err) {
                res.send(err);
            }
            else {
                //poor practice, but we will handle it differently once we start using Ajax
                res.redirect(302, '/route/all');
            }
        });
    }
});


module.exports = router;
