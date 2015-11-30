var config = require('./config'),
  express = require('express'),
  morgan = require('morgan'),
  compress = require('compression'),
  bodyParser = require('body-parser'),
  methodOverride = require('method-override'),
  session = require('express-session'),
  flash = require('connect-flash'),
  passport = require('passport');

module.exports = function() {
  var app = express();

  if(process.env.NODE_ENV === 'development'){
    app.use(morgan('dev'));
  } else if (process.env.NODE_ENV === 'production'){
    app.use(compress());
  }

  // configue body-parser
  app.use(bodyParser.urlencoded({extended:true}));
  app.use(bodyParser.json());
  app.use(methodOverride());

  // configue express-session
  app.use(session({
    saveUninitialized: true,
    resave: true,
    secret: config.sessionSecret
  }));

  // configure express views and templating language
  app.set('views', './app/views');
  app.set('view engine', 'ejs');

  app.use(flash());
  // configure passport
  app.use(passport.initialize());
  app.use(passport.session()); // user express session

  // include routes
  require('../app/routes/index.server.route.js')(app);
  require('../app/routes/users.server.routes.js')(app);

  // setup public folder
  app.use(express.static('./public'));

  return app;
}
