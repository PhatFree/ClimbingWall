var express = require('express');
var router = express.Router();
var climber_dal = require('../model/climber_dal');


// View All climbers
router.get('/all', function(req, res) {
    climber_dal.getAll(function(err, result){
        if(err) {
            res.send(err);
        }
        else {
            res.render('climber/climberViewAll', { 'result':result });
        }
    });

});

// View the climber for the given id
router.get('/', function(req, res){
    if(req.query.CLIMB_ID == null) {
        res.send('CLIMB_ID is null');
    }
    else {
        climber_dal.getById(req.query.CLIMB_ID, function(err,result) {
           if (err) {
               res.send(err);
           }
           else {
               res.render('climber/climberViewById', {'result': result[0]});
           }
        });
    }
});


// Return the add a new climber form
router.get('/add', function(req,res){

    res.render('climber/climberAdd');
});

// View the climber for the given id
router.get('/insert', function(req, res){
    // simple validation
    if(req.query.email == null) {
        res.send('Email must be provided.');
    }
    else if(req.query.firstme == null) {
        res.send('First Name must be provided');
    }
    else if(req.query.last == null) {
        res.send('Last Name must be provided');
        }

    else {
        // passing all the query parameters (req.query) to the insert function instead of each individually
        climber_dal.insert(req.query, function(err) {
            if (err) {
                res.send(err);
            }
            else {
                //poor practice, but we will handle it differently once we start using Ajax
                res.redirect(302, '/climber/all');
            }
        });
    }
});


router.get('/edit', function(req, res){
    if(req.query.CLIMB_ID == null) {
        res.send('A climber id is required');
    }
    else {
        climber_dal.edit(req.query.CLIMB_ID, function(err, result){
            //console.log(result[0]);
            res.render('climber/climberUpdate', {'result': result[0]});
        });
    }

});

router.get('/update', function(req, res) {
    climber_dal.update(req.query, function(err, result){
        res.redirect(302, '/climber/all');
    });
});


// Delete a climber for the given CLIMB_ID
router.get('/delete', function(req, res){
    if(req.query.CLIMB_ID == null) {
        res.send('CLIMB_ID is null');
    }
    else {
        climber_dal.delete(req.query.CLIMB_ID, function(err){
            if(err) {
                res.send(err);
            }
            else {
                //poor practice, but we will handle it differently once we start using Ajax
                res.redirect(302, '/climb/all');
            }
        });
    }
});

module.exports = router;
