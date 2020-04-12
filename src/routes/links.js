const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

router.get('/agregar', isLoggedIn, (req, res) => {
    res.render('links/agregar');
})

router.post('/agregar', isLoggedIn, async(req, res) => {
    const { titulo, url, descripcion } = req.body;
    const newLink = {
        titulo,
        url,
        descripcion,
        usuario_doc: req.user.id
    };
    await pool.query('INSERT INTO links set ?', [newLink]);
    req.flash('success', 'El registro se ha REALIZADO satisfactoriamente');
    res.redirect('/links');
});

router.get('/', isLoggedIn, async(req, res) => {
    const links = await pool.query('SELECT * FROM links WHERE usuario_doc = ?', [req.user.id]);
    res.render('links/listar', { links });
});

router.get('/eliminar/:idLinks', isLoggedIn, async(req, res) => {
    const { idLinks } = req.params;
    await pool.query('DELETE FROM links WHERE idLinks = ?', [idLinks]);
    req.flash('success', 'El registro se ha ELIMINADO satisfactoriamente');
    res.redirect('/links');
});

router.get('/editar/:idLinks', isLoggedIn, async(req, res) => {
    const { idLinks } = req.params;
    const links = await pool.query('SELECT * FROM links WHERE idLinks = ?', [idLinks]);
    res.render('links/editar', { link: links[0] });

})

router.post('/editar/:idLinks', isLoggedIn, async(req, res) => {
    const { idLinks } = req.params;
    const { titulo, descripcion, url } = req.body;
    const nuevoLink = {
        titulo,
        descripcion,
        url
    };
    await pool.query('UPDATE links set ? WHERE idLinks = ? ', [nuevoLink, idLinks]);
    req.flash('success', 'El registro se ha ACTUALIZADO satisfactoriamente');
    res.redirect('/links');

})
module.exports = router;