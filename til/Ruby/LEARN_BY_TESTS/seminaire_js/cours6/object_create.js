// recoder object.create

// Shape - superclass
function Shape() {
  this.x = 0;
  this.y = 0;
}

// superclass method
Shape.prototype.move = function(x, y) {
  this.x += x;
  this.y += y;
  console.info('Shape moved.');
};

// Rectangle - subclass
function Rectangle() {
  Shape.call(this); // call super constructor.
}

// subclass extends superclass
Rectangle.prototype = myCreate(Shape.prototype);
Rectangle.prototype.constructor = Rectangle;

var rect = new Rectangle();

console.log('Is rect an instance of Rectangle? ' + (rect instanceof Rectangle)); // true
console.log('Is rect an instance of Shape? ' + (rect instanceof Shape)); // true
rect.move(1, 1); // Outputs, 'Shape moved.'

function myNew(Constructor) {
  var obj = {};
  var args = Array.prototype.slice.call(arguments);
  args.shift();

  obj.__proto__ =  Constructor.prototype;
  constructor_result = Constructor.apply(obj, args);

  if(constructor_result instanceof Object)
    return constructor_result;
  else
    return obj;
}

function myCreate(o) {
  function Ctor() {}
  Ctor.prototype = o;
  return new Ctor();
}

