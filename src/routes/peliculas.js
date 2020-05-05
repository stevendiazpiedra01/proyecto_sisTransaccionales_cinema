//Archivo que contiene la programacion back end del mockup Peliculas

//Librerias
const express = require('express');
const router = express.Router();

const pool = require('../database');
//Funcion de Bloqueo de vistas 
const { isLoggedIn } = require('../lib/auth');

//Creacion de Ruta = Peliculas
router.get('/agregar_Peliculas', isLoggedIn, (req, res) => {
    res.render('peliculas/agregar_Peliculas');
});

//Creacion del metodo Post Para agregar registros/Peliculas
router.post('/agregar_Peliculas', isLoggedIn, async(req, res) => {
    console.log(req.body);
    const { titulo, informacionPelicula, duracionPelicula, fechaEstreno, foto } = req.body;

    const newMovie = {
        titulo,
        informacionPelicula,
        duracionPelicula,
        fechaEstreno,
        foto
    };
    await pool.query('INSERT INTO peliculas set ?', [newMovie]);
    req.flash('success', 'El registro se ha REALIZADO satisfactoriamente');
    res.redirect('/links');
});
//Listar Peliculas
router.get('/', isLoggedIn, async(req, res) => {
    const peliculas = await pool.query('SELECT * FROM peliculas');
    res.render('peliculas/listar_Peliculas', { peliculas });
});


module.exports = router;