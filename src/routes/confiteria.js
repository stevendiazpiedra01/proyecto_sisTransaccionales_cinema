const express = require('express');
const router = express.Router();
const pool = require('../database');
//Funcion de Bloqueo de vistas 
const { isLoggedIn } = require('../lib/auth');

router.get('/agregar_Confiteria', isLoggedIn, (req, res) => {
    res.render('confiteria/agregar_Confiteria');
});

//Creacion del metodo Post Para agregar registros/Peliculas
router.post('/agregar_Confiteria', isLoggedIn, async(req, res) => {
    console.log(req.body);
    const {cantidadProducto, nombreProducto, fk_Multiplex, pagoConfiteria,Foto} = req.body;
    const newConfiteria = {
        cantidadProducto,
        nombreProducto,
        fk_Multiplex,
        pagoConfiteria,
        Foto,
    };
    await pool.query('INSERT INTO confiteria set ?', [newConfiteria]);
    req.flash('success', 'El registro se ha REALIZADO satisfactoriamente');
    res.redirect('/confiteria/agregar_Confiteria');
});

router.get('/', isLoggedIn, async(req, res) => {
    const confiteria = await pool.query('SELECT * FROM confiteria');
    res.render('confiteria/listar_Confiteria ', { confiteria});
});



module.exports = router;
