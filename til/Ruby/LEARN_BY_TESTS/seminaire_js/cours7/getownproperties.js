'use strict';

function myDefineProperties(ob, props) {
  for(var prop in props){
    // if(ob.hasOwnProperty(prop)){
    //   continue;
    // }
    Object.defineProperty(ob, prop, props[prop]);
  }
}

var ob = {};

myDefineProperties(ob, {
  "property1": {
    value: true,
    writable: true,
    enumerable: true
  },
  "property2": {
    value: "Hello",
    writable: false
  }
});

console.log(ob);
