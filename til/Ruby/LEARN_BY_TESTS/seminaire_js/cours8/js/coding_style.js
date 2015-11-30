'use strict';

function () {
  'use strict';
  function toto() {
  }
}
if (a + b)
  return;

if (a + b) {
  return;
}
else {
}

var toto = 42;

// utiliser les simples quotes
// sauf quand t'as une apostrophe dedans.
var  a = 'toto';
var b = "'"';

// NON, pas aligné c'est chiants
// il faut répéter var
var  u = 42,
  c = 42;

// 1 variable par ligne
// trailing coma si pas ie8, ça minimise les diffs
var c = {
  toto: 42,
  tata: 42,
};

var d = {toto: 42, tata: 43}:
var f = [42, 48];
var g = [
  42,
  'toto',
];

var so = [{
  tutu: 34,
}], {
  toto: 24,
}];

// commentaire espace en début
/*
 * comment
 * on multiple lines
 */

function toto() {
  // blah
}
console.log(toto.name); // 'toto'

var toto = function() {
  // blah
}
console.log(toto.name); // ''

function() {
}

callNetwork(function $network() {
});

// IIFE
Object.create = (function() {
  var toto = 'uhuh';

  return function() {
  };
})(window);

//chainage
var prom = myCall()
  .then(function(val) {
    //
  })
  // ici on montre qu'on est wrappé par lodash
  .then(_)
    .call('reduce')
    .call('value')
  .catch(function(val) {
    //i
  })
  // ; a la fin évite diff inutiles
;


// max 120 char
// coupé après un opérateur unaire
var toto = a + b +
  ... + c;

// ternaire multi line
var toto = cond ?
  cond2 ? truc : truc 2 :
  25
;

// pas initialiser des var en haut des fonctions
// intialiser au moment où on en a besoin

// traiter cas particulier avant cas générale
//
//
// déclarer fonction avant de l'utiliser
