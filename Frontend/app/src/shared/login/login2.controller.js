app.controller("loginController" , function($rootScope, $scope , $http, $state, mainService) {
    $scope.loginData = {
      // Stores the Login Data  
    };
    $scope.mismatch = false;
    $scope.getAdmin = true;
    $scope.roles = "";
    // mainService.setUserRoles($scope.adminKey , $scope.roles);
    // localStorage.clear();
    $scope.loginPrimary = function() {
        mainService.loginService($scope.loginData).then(function(response) {

                    var loginState = response[0];
                    // mainService.setUserSession($rootScope.userSessionKey , true);
                    localStorage.setItem('user' , 'true');
                    if(loginState.Logged_in && loginState.Is_admin == 1) {
                        $scope.roles = 'admin';
                        localStorage.setItem('role' , 'admin');
                        $rootScope.isAdmin = true;
                        $rootScope.$broadcast("login");
                        $state.go('admin.dashboard');
                    }
                    else if(loginState.Logged_in && loginState.Is_user == 1) {
                        $scope.roles = 'user';
                        $rootScope.isAdmin = false;
                        localStorage.setItem('role' ,  $scope.roles );
                        $state.go('user.home');
                    }else if(loginState.Logged_in && loginState.Is_manager == 1) {
                        $scope.roles = 'manager',
                        $rootScope.isAdmin = false;
                        $rootScope.isManager = true;
                        localStorage.setItem('role' , $scope.roles);
                        $state.go('manager.home');
                    }
                }).catch(function(err) {
                    $scope.mismatch = true;
                })
    }
})