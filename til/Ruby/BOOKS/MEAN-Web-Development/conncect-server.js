var connect = require('connect');
var app = connect();

var logger = function(req, res, next){
  console.log(req.method, req.url);
  next();
}

var helloWorld = function(req, res, next){
  res.setHeader('Content-Type','text/plain');
  res.end('Hello World');
}

var bye = function(req, res, next){
  res.setHeader('Content-Type','text/plain');
  res.end('goodbye world');
}

app.use(logger);
app.use('/hello/',helloWorld);
app.use('/bye/',bye);
app.listen(3000);

console.log('serveur is running on port 3000');
