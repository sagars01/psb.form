app.directive('backButton' , function() {
    return {
        restrict : 'E',
        template : `<button class = "btn btn-primary" ng-click = "goBack()">Go Back</button>`,
        controller : function($scope, $rootScope , $state) {
            $scope.goBack = function() {
                $state.go($rootScope.fromState , {reload : true})
            }
        }
    }
})