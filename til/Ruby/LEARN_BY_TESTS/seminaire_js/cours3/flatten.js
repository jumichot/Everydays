// faire une fonction qui prend une fonction en arg et en retourne une
// la fonction retourné si appellée avec un tabeleau fait un flatten
// si la fonction passée avec le tableau cleané renvoit un tableau tu dois le map par 2

function add(a,b){
  return a + b;
}

function returnTab(a,b){
  return [a];
}

// [1, 2, [2,3]]
function flatten(ary) {
  return ary.reduce(function(res, elem){
    if(Array.isArray(elem)){
      return res.concat(flatten(elem));
    } else {
      res.push(elem);
      return res;
    }
  }, []);
}

function argsCleaning(func) {
  return function(ary){
    var cleaned_args = flatten(ary);
    var result = func.apply(this, cleaned_args)
    if(Array.isArray(result)) {
      return result.map(function(elem) {
        return elem * 2;
      });
    }
     else {
      return result;
    }
  };
}

// console.log(flatten([1, 2 , [2,3]]));
// console.log(argsCleaning(add)([1,2]));
// console.log(argsCleaning(add)([[1],2]));
console.log(argsCleaning(returnTab)([[9]]));
