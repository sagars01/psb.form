app.controller("baseCtrl" , function($rootScope , $scope , $state, $timeout , toaster, mainService){
    

    //Checking authentication

    $rootScope.userKey = "role";
    $rootScope.previous = "";
    
    //Configs
    $rootScope.adminKey = 'role';
    $rootScope.userSessionKey = 'user';

     $rootScope.$on('$stateChangeStart' , function(e ,to) {
        var isSessionTrue = localStorage.getItem('user');
        $rootScope.username = localStorage.getItem('name');
        if(to.name == 'login') {
            if(isSessionTrue == "true") {
                var currentUserRole = localStorage.getItem("role");
                switch(currentUserRole) {
                    case 'admin' :
                        $timeout(function(){
                            $state.go('admin.dashboard');
                            toaster.pop('error' , "You're already logged in.")
                        })
                    break;
                    case 'manager' :
                        $state.go('manager.home');
                        toaster.pop('error' , "You're already logged in.")
                    break;
                    case 'user' :
                        $state.go('user.home');
                        toaster.pop('error' , "You're already logged in.")
                    break;
                    default :
                        $state.go('login');
                        toaster.pop('error' , "You're already logged in.")
                    break;
                }
            }
        }else {
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
        }
        
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


})