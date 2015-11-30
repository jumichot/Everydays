// parseur
// devra gérer le +, -, *, /, variables, nombre flottant
// trouver la fonction qui execute l'expression donc faudra l'invoquer
// la fonction aura en contexte les variables dans le context

// * 3 + 4 5        => 3 * (4 + 5)
// + 3 2              => 3 + 2
// * + 3 2 8          => (3 + 2) * 8
// * ( +(3)(2)) (8)

function isOp(character){
  var str = "+-*/";
return str.indexOf(character) > -1;
}

function isVariable(word){
  return isNaN(+word);
}

function variable(key){
  return function() {
    return this[key];
  }
}

function parser(str){
  var words = str.split(' ');

  function parse(words){
    var current_char = words.shift();

    if(isOp(current_char)){
      var left_operand = parse(words);
      var rigth_operand = parse(words);
      switch (current_char) {
        case '+':
          return function(){ return left_operand.call(this) + rigth_operand.call(this); }
        case '-':
          return function(){ return left_operand.call(this) - rigth_operand.call(this); }
        case '*':
          return function(){ return left_operand.call(this) * rigth_operand.call(this); }
        case '/':
          return function(){ return left_operand.call(this) / rigth_operand.call(this); }
        break;
        default:
      }
    } else {
      if(isVariable(current_char)){
        return variable(current_char);
      } else {
        return function(){
          return +current_char;
        }
      }
    }

  };
  return parse(words);
}


console.log(parser("+ 3 2")());
console.log(parser("* + 3 2 8")());
console.log(parser("+ 3 a").call({a: 2}));

