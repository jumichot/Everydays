// T'as deux syntax : .definePropert attribut get qui prend une fonction, mais plus le droit d'utiliser je sais pas quoi
// marche sur une instance ou sur un prototype
// mettre getter sur prototype pour que ça agisse sur tous les objects

'use strict';
function Square(){
  this.width = 2;
  this.type = 'square';
}

var square = new Square();
// writeable ne sert à rien dur getter setter
Object.defineProperty(Square.prototype, 'perimeter', {
  get: function() { return this.width * 4; },
  set: function(newValue) {
    this.width = newValue/4;
  },
  enumerable: true,
  configurable: true
});

// console.log(square);
// console.log(square.perimeter);

// square.perimeter = 4;
// console.log(square);
// console.log(square.perimeter);

// deuxième syntax, on doit être dans les accolade de l'objet
function SquareGet(){
  this.width = 2;
  this.type = 'square';
}

SquareGet.prototype = {
  get perimeter () {
    return this.width * 4;
  }
}


var square2 = new SquareGet();
console.log (square2.perimeter); // Will return "test".
