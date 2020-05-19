//Archivo que contiene la programacion back end del mockup Peliculas

//Librerias
const express = require('express');
const router = express.Router();

const pool = require('../database');
//Funcion de Bloqueo de vistas 
const { isLoggedIn } = require('../lib/auth');

//Creacion de Ruta = Peliculas
router.get('/listar_Peliculas_Reserva', isLoggedIn, async(req, res) => {
    const peliculas = await pool.query('SELECT * FROM peliculas');
    res.render('reservas/listar_Peliculas_Reserva', { peliculas });
});

router.get('/agregar_Reservas', isLoggedIn, async(req, res) => {
    res.render('peliculas/agregar_Reservas');
});

//Creacion del metodo Post Para agregar reservas/agregar
router.post('/agregar_Reservas', isLoggedIn, async(req, res) => {
    const { idPelicula } = req.params;
    const { seleccionarPelicula, seleccionarMultiplex, seleccionarSala } = req.body;

    const newReserva = {
        seleccionarPelicula,
        seleccionarMultiplex,
        seleccionarSala,
        idUsuario: req.user.id
    };
    await pool.query('INSERT INTO peliculas set ?', [newReserva]);
    req.flash('success', 'El registro se ha REALIZADO satisfactoriamente');
    res.redirect('/peliculas');
});
module.exports = router;