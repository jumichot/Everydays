// Début de discussion sur les briques de bases
//
// var add = function(a,b) {
//   console.log(this);
//   console.log(arguments);
//   return a + b;
// }

// Fonctionnement apply
// console.log(add.apply(this,[2,3]));


// var add2 = function(a) {
//   console.log(this);
//   console.log(arguments);
//   return this + a;
// }
// this est un argument caché passé dans toute les fonctions
// on peut donc lui passé n'importe quoi, y compris un nombre
// this est toujours setté à quelque chose
// console.log(add2.apply(4,[2]));

//Fonctionnement call
// console.log(add.call(this,2,3,5));

//variable arguments
var infinite_add = function(){
  var sum = 0;
  for (var i = 0; i < arguments.length; i++) {
    sum += arguments[i];
  }
  return sum;
}
// console.log(infinite_add.call(this,2,3,5,6,4));

// mycall sans shift trick
// Function.prototype.mycall = function(){
//   var context =  arguments[0];
//   var args = []
//   for(var i = 1; i < arguments.length ; i++) {
//     args.push(arguments[i])
//   }
//   return this.apply(context, args);
// }

// j'avais écris mycall sans arugement et en assignant une variable
// cette version est plus lisible
Function.prototype.mycall = function(context){
  Array.prototype.shift.call(arguments)
  return this.apply(context, arguments);
}

// console.log(infinite_add.mycall(this,2,3,5,6,4));
console.log(Array.prototype.shift.call({"toto":"mastring"}));
