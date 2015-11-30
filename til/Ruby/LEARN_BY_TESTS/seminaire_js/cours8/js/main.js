angular.module('testApp', []);

angular.module('testApp').filter('searchFilter', function() {
  return function(users, query) {
    if (!query)
      return users

    return users.filter(function(elem){
      return elem.name.toLowerCase().indexOf(query.toLowerCase()) !== -1
    });
  };
});

// directive form
// donner un nom au form : donne le nom en variable danas le scope. toto.tutu.$valid
// pour les entiers
// class red en css
// quand invalide mettre en rouge
// pour les messages regarde ng message
//
angular.module('testApp').controller('firstController', ['$scope', function($scope) {
  $scope.users = [{
    name: 'julien',
    age: 23
  }, {
    name: 'toto',
    age: 12
  }, {
    name: 'tata',
    age: 10
  }];

  $scope.addUser = function(person) {
    $scope.users.push({name: person.name, age: person.age});
    if ($scope.newPerson) {
      $scope.newPerson.name = '';
      $scope.newPerson.age = '';
    }
    $scope.form.$setPristine();
  };

  $scope.deleteUser = function(user) {
    console.log($scope.users.indexOf(user));
    $scope.users.splice($scope.users.indexOf(user), 1);
  };
}]);

