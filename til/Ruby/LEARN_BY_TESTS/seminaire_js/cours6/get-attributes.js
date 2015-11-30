// arg obj arg attribut et simule obj.attribut
// if attribut in ob


function getAttribute(obj, attr){
  while(obj) {
    // if(attr in obj) return obj[attr];
    // le pb avec in c'est qu'il remonte dans la chaine
    if(Object.getOwnPropertyDescriptor(obj, attr)) return obj[attr];
    obj = Object.getPrototypeOf(obj);
  }
}

function C(){ this.tata = "tata"}
C.prototype.data = "data";
var o = new C();
console.log(o);

console.log(getAttribute(o, "tata"));
console.log(getAttribute(o, "data"));
console.log(getAttribute(o, "dato"));
