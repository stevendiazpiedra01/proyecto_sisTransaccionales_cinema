const express = require('express');
const morgan = require('morgan');
const exphbs = require('express-handlebars');
const path = require('path');
const flash = require('connect-flash');
const session = require('express-session');
const MySQLStore = require('express-mysql-session');
const passport = require('passport');

const { database } = require('./keys');
// Inicializacion
const app = express();
require('./lib/passport');

// Configuraciones
app.set('port', process.env.PORT || 4000);
app.set('views', path.join(__dirname, 'views'));
app.engine('.hbs', exphbs({
    defaultLayout: 'main',
    layoutsDir: path.join(app.get('views'), 'layouts'),
    partialsDir: path.join(app.get('views'), 'partials'),
    extname: '.hbs',
    helpers: require('./lib/handlebars')
}));
app.set('view engine', '.hbs');

// Middlewares
app.use(session({
    secret: 'sesionmysqlnodejscinema',
    resave: false,
    saveUninitialized: false,
    store: new MySQLStore(database)
}));
app.use(flash());
app.use(morgan('dev'));
app.use(express.urlencoded({ extended: false }));
app.use(express.json());
app.use(passport.initialize());
app.use(passport.session());


// Variables Globales
app.use((req, res, next) => {
    app.locals.success = req.flash('success');
    app.locals.message = req.flash('message');
    app.locals.user = req.user;
    next();
});

// Rutas
app.use(require('./routes'));
app.use(require('./routes/autenticacion'));
app.use('/links', require('./routes/links'));
app.use('/peliculas', require('./routes/peliculas'));
app.use('/comprarBoleta', require('./routes/comprarBoleta'));
app.use('/multiplex', require('./routes/multiplex'));
app.use('/metodoPagos', require('./routes/metodoPagos'));
app.use('/reservas', require('./routes/reservas'));
app.use('/confiteria',require('./routes/confiteria'));


// Public
app.use(express.static(path.join(__dirname, 'public')));


// Iniciar Servidor
app.listen(app.get('port'), () => {
    console.log('Servidor en el puerto', app.get('port'))

});
