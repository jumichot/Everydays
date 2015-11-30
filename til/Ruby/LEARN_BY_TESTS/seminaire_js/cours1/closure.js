// fonction (a) retourne  un fonction qui prend en entier b qui fait le resultat de a + b
// var create_add = function(a){
//   return function(b){
//     return a + b;
//   }
// }


// console.log(create_add(3)(2));
// console.log(i);

// boucle 0 à 9 qui affiche i
// afficher 10 partout car i a déjà bouclé
// for (var i = 0; i < 10; i++) {
//   setTimeout(function(){
//   console.log(i);
//   }, 300)
// }

// set la propriété name de la fonction
// function printI(i){
//   return function() {
//     // le i ici est scopé a la fonction anonyme
//     console.log(i);
//   };
// }

// for (var i = 0; i < 10; i++) {
//   setTimeout(printI(i), 500)
// }

//bind
// function printThis(){
//   console.log(this);
// }

// var print = printThis.bind("toto");
// print();

function add(a) {
  return this.a + a;
}

 // polyfill sur la page MDN
Function.prototype.myBind = function(context) {
  var that = this;
  var args = Array.prototype.slice.call(arguments)
  Array.prototype.shift.apply(args);
  return function() {
    var args2 = Array.prototype.slice.call(arguments)
    var concatTab = Array.prototype.concat(args, args2);
    return that.apply(context, concatTab);
  }
}

var myadd = add.myBind({a: 5}, 8, 9 );
console.log(myadd(3));

var greet = function(greeting, name) {
  return greeting + ' ' + name;
};


Function.prototype.myPartial = function() {
  var that = this;
  var args = Array.prototype.slice.call(arguments)
  return function() {
    var args2 = Array.prototype.slice.call(arguments)
    var concatTab = Array.prototype.concat(args, args2);
    return that.apply(that, concatTab);
  }
}
var sayHelloTo = greet.myPartial('hello');
console.log(sayHelloTo('fred'));
console.log(sayHelloTo('hi'));
//regarder le _partial de lodash
