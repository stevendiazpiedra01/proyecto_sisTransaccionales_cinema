const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

router.get('/agregar_metodosPago', isLoggedIn, (req, res) => {
    res.render('metodoPagos/agregar_metodosPago');
})

router.post('/agregar_metodosPago',isLoggedIn, async (req, res) => {
    const { metodo_Pago} = req.body;
    const newMetodosPago ={
        metodo_Pago
    };
    await pool.query('INSERT INTO metodospago set ?', [newMetodosPago]);
    req.flash('success', 'El registro se ha REALIZADO satisfactoriamente');
    res.redirect('/metodoPagos/agregar_metodosPago');
})
module.exports = router;