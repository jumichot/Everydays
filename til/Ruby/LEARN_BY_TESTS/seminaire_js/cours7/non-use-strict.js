'use strict';

var obj = {
  haha: "haha",
  name: "toto"
};

Object.defineProperty(obj, 'name', {
  enumerable: false,
  configurable: false,
  writable: false
});

// cannot redefine propert
// Object.defineProperty(obj, 'name', {
//   enumerable: true,
//   configurable: true,
//   writable: true
// });

// pas possible car writable false
// obj.name = "tata";

// in est trouvé avec enumerable
console.log("test de in :", "name" in obj);

// ici on voit pas l'attribut name
for(var props in obj){
  console.log("test des props :", props);
}

//cannot delete 
console.log("delete prop", delete obj.name);
console.log("object :", obj);

// 2 types pour boucler sur les props d'un objet pas celle de son proto :
// faire une boucle for(var props in ob) puis un if hasOwnProperty...
// ou utiliser : Object.getOwnPropertyNames(), puis boucler.
// Connaitre les api d'object, de array, de string de des regex.
