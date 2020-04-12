const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;
const pool = require('../database');
const helpers = require('../lib/helpers');

passport.use('local.signin', new LocalStrategy({
    usernameField: 'numerodocumento',
    passwordField: 'password',
    passReqToCallback: true
}, async(req, numerodocumento, password, done) => {
    console.log(req.body);
    const rows = await pool.query('SELECT * FROM registroclientes WHERE numerodocumento = ?', [numerodocumento]);
    if (rows.length > 0) {
        const user = rows[0];
        const validPassword = await helpers.matchpassword(password, user.password);
        if (validPassword) {
            done(null, user, req.flash('success', 'Bienvenido ' + user.nombres));
        } else {
            done(null, false, req.flash('message', 'Contraseña Incorrecta'))
        }
    } else {
        return done(null, false, req.flash('message', 'El Usuario No Existe'));
    }

}));

passport.use('local.signup', new LocalStrategy({
    usernameField: 'numerodocumento',
    passwordField: 'password',
    passReqToCallback: true
}, async(req, numerodocumento, password, done) => {
    const { nombres, apellidos, tipodocumento, email, celular } = req.body;
    const nuevoUsuario = {
        numerodocumento,
        password,
        tipodocumento,
        nombres,
        apellidos,
        correo: email,
        celular
    };
    nuevoUsuario.password = await helpers.encryppassword(password);
    const result = await pool.query('INSERT INTO registroclientes SET ? ', [nuevoUsuario]);
    nuevoUsuario.id = result.insertId;
    return done(null, nuevoUsuario);

}));

passport.serializeUser((user, done) => {
    done(null, user.id);
});

passport.deserializeUser(async(id, done) => {
    const rows = await pool.query('select * from registroclientes where id = ?', [id]);
    done(null, rows[0]);
});