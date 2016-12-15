var express = require('express');
var router = express.Router();
var stats_dal = require('../model/stats_dal');

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'CWDb' });
});

router.get('/about',function (req, res) {
    stats_dal.aboutStats(function (err, stats) {
        res.render('about', {title: 'CWDb:About', stats: stats[0]});
    });
 });

module.exports = router;
