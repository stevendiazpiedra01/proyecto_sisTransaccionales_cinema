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
    res.redirect('/peliculas');
});
//Listar Peliculas
router.get('/', isLoggedIn, async(req, res) => {
    const peliculas = await pool.query('SELECT * FROM peliculas');
    res.render('peliculas/listar_Peliculas', { peliculas });
});

router.get('/eliminar_Pelicula/:idPelicula', isLoggedIn, async(req, res) => {
    const { idPelicula } = req.params;
    await pool.query('DELETE FROM funciones WHERE id_Pelicula = ? ', [idPelicula]);
    await pool.query('DELETE FROM peliculas WHERE idPelicula = ? ', [idPelicula]);
    req.flash('success', 'El registro se ha ELIMINADO satisfactoriamente');
    res.redirect('/peliculas');
});

router.get('/editar_Peliculas/:idPelicula', isLoggedIn, async(req, res) => {
    const { idPelicula } = req.params;
    const peliculas = await pool.query('SELECT * FROM peliculas WHERE idPelicula = ?', [idPelicula]);
    res.render('peliculas/editar_Peliculas', { pelicula: peliculas[0] });

});

router.post('/editar_Peliculas/:idPelicula', isLoggedIn, async(req, res) => {
    const { idPelicula } = req.params;
    const { titulo, informacionPelicula, duracionPelicula, fechaEstreno, foto } = req.body;
    const editarPelicula = {
        titulo,
        informacionPelicula,
        duracionPelicula,
        fechaEstreno,
        foto
    };
    await pool.query('UPDATE peliculas set ? WHERE idPelicula = ? ', [editarPelicula, idPelicula]);
    req.flash('success', 'El registro se ha ACTUALIZADO satisfactoriamente');
    res.redirect('/peliculas');

});

module.exports = router;