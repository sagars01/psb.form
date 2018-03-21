app.directive("headerNav", function() {
    return {
        restrict : 'E',
        // templateUrl : './src/shared/header/header.template.html',
        template : `
        <header>
        <div class="container-fluid header-wrapper">
          <div class="col-md-6">
            <h3 style="cursor : pointer" ng-click = "conditionalHome()">NetApp</h3>
          </div>
          <div class="col-md-6">
            <span class = "headerUsername" ng-if = "username != null || username != undefined">{{"Hi, " + username}}</span>
            <button class="btn btn-primary pull-right" id="logout" ng-show = "isLogin" ng-click="logout()">Logout</button>
          </div>
        </div>
        </header>
        `,
        controller : 'headerController'
    }
});

app.controller('headerController' , function($rootScope, $scope, mainService, $state){
    // $rootScope.$on('login' , function() {
    //     $scope.isLogin = false;
    // })
    $scope.conditionalHome = function() {
        if($rootScope.isAdmin == true) {
            $state.go('admin.dashboard')
        }else if($rootScope.isManager == true) {
            $state.go('manager');
        }else {
            $state.go('user.home');
        }
    }
    $scope.logout = function() {
        mainService.logoutService().then(function() {
            localStorage.clear();
            $state.go('login' , {reload : true});
            
        })
    }
})