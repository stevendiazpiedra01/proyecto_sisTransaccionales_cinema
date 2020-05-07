const express = require('express');
const router = express.Router();

const pool = require('../database');
const { isLoggedIn } = require('../lib/auth');

router.get('/comprarBoleta', isLoggedIn, (req, res) => {
    res.render('comprarBoleta/comprarBoleta');
})

router.post('/comprarBoleta',isLoggedIn, async (req, res) => {
    const { numeroBoletasGe, numeroBoletasPe,totalPrecioBoletas} = req.body;
    const newComprarBoleta ={
        numeroBoletasGe,
        numeroBoletasPe,
        totalPrecioBoletas,
        idUsuario: req.user.id
    };
    await pool.query('INSERT INTO boletas set ?', [newComprarBoleta]);
    req.flash('success', 'El registro se ha REALIZADO satisfactoriamente');
    res.redirect('/comprarBoleta');
})


//Listar Compra de boletas
router.get('/', isLoggedIn, async(req, res) => {
    const boletas = await pool.query('SELECT * FROM boletas WHERE idUsuario = ?', [req.user.id]);
    res.render('comprarBoleta/listar_boletas', { boletas });
});






router.get('/editar_boletas /:idCompBoleta', isLoggedIn, async(req, res) => {
    const { idCompBoleta } = req.params;
    const comprarBoleta = await pool.query('SELECT * FROM boleta WHERE idCompBoleta = ?', [idCompBoleta]);
    res.render('comprarBoleta/editar_boletas', { link: comprarBoleta  });

})

router.post('/editar_boletas/:idCompBoleta', isLoggedIn, async(req, res) => {
    const { idCompBoleta } = req.params;
    const { numeroBoletasGe, numeroBoletasPe, totalPrecioBoletas } = req.body;
    const nuevoLink = {
        numeroBoletasGe,
        numeroBoletasPe,
        totalPrecioBoletas
    };
    await pool.query('UPDATE boletas set ? WHERE idCompBoleta = ? ', [nuevoLink, idCompBoleta]);
    req.flash('success', 'El registro se ha ACTUALIZADO satisfactoriamente');
    res.redirect('/comprarBoleta');

})
module.exports = router;
