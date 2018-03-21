app.controller("baseCtrl" , function($rootScope , $scope , $state, $timeout , toaster, mainService){
    $timeout(function(){
        $scope.current = $state.current.name;
    }) 
    $scope.$watch('current' , function(value){
        if(value == 'login') {
            $rootScope.$broadcast($scope.current);
        }
    }) 

    //Checking authentication

    $rootScope.userKey = "role";
    $rootScope.previous = "";
    
     $rootScope.$on('$stateChangeStart' , function(e ,to) {
        var routeRoles = to.data.roles;
        var counter = 0;
        var isValidSession = localStorage.getItem('user');
        var userRoles = localStorage.getItem("role");
        if(isValidSession == "true") {
            if(userRoles != routeRoles && routeRoles != "all" && userRoles != null) {
                if(userRoles == 'admin') {
                    $timeout(function(){
                        $state.go('admin.dashboard'); 
                        toaster.pop('error' , 'Access Denied');
                    });
                }else if(userRoles == 'user') {
                    $timeout(function(){
                        $state.go('user.home');
                        toaster.pop('error' , 'Access Denied');
                    });
                    }else {
                        $timeout(function(){
                            $state.go('manager.home');
                            toaster.pop('error' , 'Access Denied');
                        });
                    }
            }    
        }else   
            $timeout(function(){
                $state.go('login');
            })
    });

    $scope._getHelpText = function(method , data) {
            mainService.help(method).then(function(response) {
                $scope.helpIterator = response[0];
            }).catch(function(error) {
                toaster.pop('error' , "There are some errors at the server!")
            });
    }
    $scope._getHelpText('GET');
    $scope.preview = true;

    //Configs
    $rootScope.adminKey = 'role';
    $rootScope.userSessionKey = 'user';

})