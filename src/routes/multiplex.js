const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

router.get('/agregar_multiplex', isLoggedIn, (req, res) => {
    res.render('multiplex/agregar_multiplex');
})

router.post('/agregar_multiplex', isLoggedIn, async(req, res) => {
    const { nombreMultiplex, numeroSalas, cantidadSillas, cantidadSillasPREF, cantidadSillasGENE } = req.body;
    const newMultiplex = {
        nombreMultiplex,
        numeroSalas,
        cantidadSillas,
        cantidadSillasPREF,
        cantidadSillasGENE

    };
    await pool.query('INSERT INTO multiplex set ?', [newMultiplex]);
    req.flash('success', 'El registro se ha REALIZADO satisfactoriamente');
    res.redirect('/multiplex');
})

//Listar Compra de boletas
router.get('/', isLoggedIn, async(req, res) => {
    const multiplex = await pool.query('SELECT * FROM multiplex');
    res.render('multiplex/listar_multiplex', { multiplex });
});


router.get('/eliminar/:idMultiplex', isLoggedIn, async(req, res) => {
    const { idMultiplex } = req.params;
    await pool.query('DELETE FROM multiplex WHERE idMultiplex = ?', [idMultiplex]);
    req.flash('success', 'El registro se ha ELIMINADO satisfactoriamente');
    res.redirect('/multiplex');
});
module.exports = router;