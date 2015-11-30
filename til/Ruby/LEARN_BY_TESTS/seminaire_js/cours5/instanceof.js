// recode instanceof
// object.getPrototypeOf()
// fonction recurive ou boucle
// typeof ne sert a rien
// histoire des array Array
// Object.create
// node -> regarder inherits
// polyfill getPrototype function(obj){ return obj.__proto__ ;}
// Object.create est utilisé pour faire des chaînes des prototype
// Object.create prend en parametre un objet et le met dans le prototype


function C(){}
function D(){}

var o = new C();
D.prototype = new C(); // use inheritance
var o3 = new D();

function myInstanceOf(instance, Constructor){
  var proto_instance = Object.getPrototypeOf(instance);

  while(proto_instance) {
    console.log(proto_instance);
    if(proto_instance === Constructor.prototype)
      return true;
    proto_instance = Object.getPrototypeOf(proto_instance);
  }
  return false;
}

// console.log(myInstanceOf(o, C)); // true
console.log(myInstanceOf(o, D)); //false
// console.log(myInstanceOf(o, Object)); //true
// console.log(myInstanceOf(C.prototype, Object)); //true
// o3 instanceof D; // true
// o3 instanceof C; // true
// console.log(D.prototype);
// console.log(D.prototype.prototype);
