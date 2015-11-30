// new  prend une fonction en arg
// si le constucteur a un prototype on l'accroche a l'object vide
// appel cette fonction avec un context (objet vide)

function myNew(Constructor) {
  var obj = {};
  obj.__proto__ =  Constructor.prototype;

  var args = Array.prototype.slice.call(arguments);
  args.shift();
  constructor_result = Constructor.apply(obj, args);

  //override
  if(constructor_result instanceof Object)
    return constructor_result;
  else
    return obj;
}

function Person(name) {
  this.color = 1;
  this.name = name;
  // override : ici le this est perdu
  return {toto: 42};
};

Person.prototype.clMyName = function() {
  console.log(this.name);
}
var personne = myNew(Person, "toto");
var personne2 = myNew(Person, "tata");

console.log(personne);
personne.name = "nop";
personne.color = 2;
console.log(personne);
console.log(personne2);
