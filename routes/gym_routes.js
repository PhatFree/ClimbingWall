var express = require('express');
var router = express.Router();
var gym_dal = require('../model/gym_dal');
var address_dal = require('../model/address_dal');


// View All Gyms
router.get('/all', function(req, res) {
    gym_dal.getAll(function(err, result){
        if(err) {
            res.send(err);
        }
        else {
            console.log(result);
            res.render('gym/gymViewAll', {title: 'All Gyms', result:result });
        }
    });

});

// View the Gym for the given id
router.get('/', function(req, res){
    if(req.query.GYM_ID == null) {
        res.send('GYM_ID is null');
    }
    else {
        gym_dal.getById(req.query.GYM_ID, function(err,result) {
           if (err) {
               res.send(err);
           }
           else {
               res.render('gym/gymViewById', {'result': result[0]});
           }
        });
    }
});

// Return the add a new gym form
router.get('/add', function(req, res){
    // passing all the query parameters (req.query) to the insert function instead of each individually
            res.render('gym/gymAdd');
    });

// View the gym for the given id
router.get('/insert', function(req, res){
    // simple validation
    if(req.query.name == null) {
        res.send('Name must be provided.');
    }
    else if(req.query.street_num == null) {
        res.send('An Address must be selected');
    }
    else if(req.query.street_name == null) {
        res.send('An Address must be selected');
    }
    else if(req.query.zip == null) {
        res.send('An Address must be selected');
    }
    else if(req.query.state == null) {
        res.send('An Address must be selected');
    }
    else {
        // passing all the query parameters (req.query) to the insert function instead of each individually
        gym_dal.insert(req.query, function(err,result) {
            if (err) {
                console.log(err)
                res.send(err);
            }
            else {
                //poor practice for redirecting the user to a different page, but we will handle it differently once we start using Ajax
                res.redirect(302, '/gym/all');
            }
        });
    }
});

router.get('/edit', function(req, res){
    if(req.query.GYM_ID == null) {
        res.send('A gym id is required');
    }
    else {
        gym_dal.edit(req.query.GYM_ID, function(err, result){
            console.log(result);
            res.render('gym/gymUpdate', {results: result[0]});
        });
    }

});

router.get('/edit2', function(req, res){
   if(req.query.GYM_ID == null) {
       res.send('A gym id is required');
   }
   else {
       gym_dal.getById(req.query.GYM_ID, function(err, result){
           console.log(result[0]);
               res.render('gym/gymUpdate', {result: result[0]});
       });
   }

});

router.get('/update', function(req, res){

    gym_dal.update(req.query, function(err, result){
       res.redirect(302, '/gym/all');
    });
});

// Delete a gym for the given GYM_ID
router.get('/delete', function(req, res){
    if(req.query.GYM_ID == null) {
        res.send('GYM_ID is null');
    }
    else {
        gym_dal.delete(req.query.GYM_ID, function(err, result){
            if(err) {
                res.send(err);
            }
            else {
                //poor practice, but we will handle it differently once we start using Ajax
                res.redirect(302, '/gym/all');
            }
        });
    }
});

module.exports = router;
