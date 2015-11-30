var curry = function(func, arity) {
  var args = Array.prototype.slice.call(arguments)
  arity = arity || func.length;

  function partial(func, args){
    args = Array.prototype.slice.call(args);

    return function(){
      var inner_args = Array.prototype.slice.call(arguments);
      return func.apply(this, args.concat(inner_args));
    };
  }

  return function() {
    if(arguments.length >= arity) {
      return func.apply(func, arguments);
    }
    return curry(partial(func, arguments), arity - arguments.length);
  }
}

var abc = function(a, b, c) {
  return [a, b, c];
};

var curried = curry(abc);

console.log(curried(1));
console.log(curried(1,2)(2));
console.log(curried(1)(2));
console.log(curried(1)(2)(3));
console.log(curried(1)(2)(3));
// → [1, 2, 3]
//
// curry(1) renvoit une fonction
