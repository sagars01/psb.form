app.factory("mainService" , mainService);

mainService.$inject = ['$http' , '$q' , ];

function mainService($http, $q ) { 
    return {
        loginService : _loginService,
        authService : _authService,
        logoutService : _logoutService,
        getUserRoles : _getUserRoles,
        setUserRoles : _setUserRoles,
        checkAccess : _checkAccess,
        setUserSession : _setUserSession,
        getUserSession : _getUserSession,
        productList : _productList,
        manage : _manage,
        preengage : _preengage,
        modpreengage : _modpreengage,
        modpsb : _modpsb,
        psbFormService : _psbFormService,
        registerProduct : _registerProduct,
        adminBearer : _adminBearer,
        poc : _poc,
        help: _help
    }
    
    function _manage(data) {
        var deferred = $q.defer();
        $http({
            url:  "http://10.235.240.73:4000/manage",
            method: 'POST',
            data : data,
            cache : false
            })
            .then(function(response){
                deferred.resolve(response.data);
            })
            .catch(function(response){
                deferred.reject(response);
            });
            return deferred.promise;
    }

    function _help(method , data) {
        var deferred = $q.defer();
        if(method == 'GET') {
            $http.get("http://10.235.240.73:4000/help")
            .then(function(response) {
                deferred.resolve(response.data)
            }).catch(function(reject){
                deferred.reject(reject)
            })
        return deferred.promise
        }else if(method == 'POST') {
            $http({
                url:  "http://10.235.240.73:4000/modifyhelp",
                method: 'POST',
                data : data,
                cache : false
            })
                .then(function(response){
                    deferred.resolve(response.data);
                })
                .catch(function(response){
                    deferred.reject(response);
                });
                return deferred.promise;
        } 
    }
    

    function _setUserRoles(key , value) {
        localStorage.setItem(key , value);
    }
    function _getUserRoles(key) {
        return localStorage.getItem(key);
    }

    function _checkAccess(userRoles, routeRoles) {
        var result = [];
        for(var i = 0; i < userRoles.length; i++) {
            for(var k = 0; k < routeRoles.length; k++) {
                if(userRoles[i] == routeRoles[k]){
                    result.push(1);
                }
            }
        }
        return result.length;
    }

    function _setUserSession(key , value) {
        localStorage.setItem(key , value);
    }

    function _getUserSession(key) {
        if(localStorage.getItem(key) == true) {
            return true;
        }else {
            return false;
        }
    }

    function _poc(data) {
        var deferred = $q.defer();
        $http({
            url:  "http://10.235.240.73:4000/poc",
            method: 'POST',
            data : data,
            cache : false
        })
            .then(function(response){
                deferred.resolve(response.data);
            })
            .catch(function(response){
                deferred.reject(response);
            });
            return deferred.promise;
    }

    function _registerProduct(data) {
        var deferred = $q.defer();
        $http({
            url:  "http://10.235.240.73:4000/registerproduct",
            method: 'POST',
            data : data,
            cache : false
        })
            .then(function(response){
                deferred.resolve(response.data);
            })
            .catch(function(response){
                deferred.reject(response);
            });
            return deferred.promise;
        }
    
    function _modpsb( method , data) {
        var deferred = $q.defer();
        if(method == 'GET') {
            $http.get("http://10.235.240.73:4000/modifypsb")
            .then(function(response) {
                deferred.resolve(response.data)
            }).catch(function(reject){
                deferred.reject(reject)
            })
        return deferred.promise
        }else {
            $http({
                url:  "http://10.235.240.73:4000/modifypsb",
                method: 'POST',
                data : data,
                cache : false
            })
                .then(function(response){
                    deferred.resolve(response.data);
                })
                .catch(function(response){
                    deferred.reject(response);
                });
                return deferred.promise;
        }
    }
    
    function _psbFormService(method , data) {
        var deferred = $q.defer();
        if(method == 'GET') {
            $http.get("http://10.235.240.73:4000/psb")
            .then(function(response) {
                deferred.resolve(response.data)
            }).catch(function(reject){
                deferred.reject(reject)
            })
        return deferred.promise
        }else if(method == 'POST') {
            $http({
                url:  "http://10.235.240.73:4000/psb",
                method: 'POST',
                data : data,
                cache : false
            })
                .then(function(response){
                    deferred.resolve(response.data);
                })
                .catch(function(response){
                    deferred.reject(response);
                });
                return deferred.promise;
        } 
        }

    function _logoutService() {
        var deferred = $q.defer();
        $http.get("http://10.235.240.73:4000/logout")
            .then(function(response) {
                deferred.resolve(response.data)
            }).catch(function(reject){
                deferred.reject(reject)
            })
        return deferred.promise
    }
    
    function _modpreengage(method , data) {
        var deferred = $q.defer();
        if(method == 'POST') {
            $http({
                url:  "http://10.235.240.73:4000/modifypreengage",
                method: 'POST',
                data : data,
                cache : false
            })
                .then(function(response){
                    deferred.resolve(response.data);
                })
                .catch(function(response){
                    deferred.reject(response);
                });
                return deferred.promise;
        }
    }

    function _preengage(method , data) {
        var deferred = $q.defer();
        if(method == 'GET'){
            $http({
                url:  "http://10.235.240.73:4000/preengage",
                method: 'GET',
                cache : false
            })
                .then(function(response){
                    deferred.resolve(response.data);
                })
                .catch(function(response){
                    deferred.reject(response);
                });
                return deferred.promise;
        }else if(method == 'POST') {
            $http({
                url:  "http://10.235.240.73:4000/preengage",
                method: 'POST',
                data : data,
                cache : false
            })
                .then(function(response){
                    deferred.resolve(response.data);
                })
                .catch(function(response){
                    deferred.reject(response);
                });
                return deferred.promise;
        }
    }

    function _productList(method , data) {
        var deferred = $q.defer();
        var dataObject = {};
        var url = "http://10.235.240.73:4000/welcome";
        if(method == 'POST') {
            $http({
                url : url,
                method : 'POST',
                data : data,
                cache : false  
               })
                   .then(function(response){
                       deferred.resolve(response.data);
                   })
                   .catch(function(response){
                       deferred.reject(response);
                   });
                   return deferred.promise;
        }else if(method == 'GET'){
        $http({
         url : url,
         method : 'GET',
         cache : false   
        })
            .then(function(response){
                deferred.resolve(response.data);
            })
            .catch(function(response){
                deferred.reject(response);
            });
            return deferred.promise;
        }
    }

    function _loginService(loginData) {
        var deferred = $q.defer();
        $http({
            url:  "http://10.235.240.73:4000/login",
            method: 'POST',
            data : loginData,
            cache : false
        })
            .then(function(response){
                deferred.resolve(response.data);
            })
            .catch(function(response){
                deferred.reject(response);
            });
            return deferred.promise;
    }

    function _authService() {
        var deferred = $q.defer();
        $http.get("http://10.235.240.73:4000/")
            .then(function(response) {
                deferred.resolve(response.data)
            }).catch(function(reject){
                deferred.reject(reject)
            })
        return deferred.promise
    }

    function _adminBearer() {
        var deferred = $q.defer();
        $http.get("http://10.235.240.73:4000/")
            .then(function(response) {
                deferred.resolve(response.data)
            }).catch(function(reject){
                deferred.reject(reject)
            })
        return deferred.promise;
    }
}
