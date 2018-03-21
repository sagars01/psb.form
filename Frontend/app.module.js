var app = angular.module("save-app" , ['ui.router' , 'angular.filter', 'ngAnimate', 'toaster']);

app.run( function($rootScope,$location, $state, $timeout, mainService , toaster) {

    $rootScope.$on('$stateChangeSuccess', function (ev, to, toParams, from, fromParams) {
        $rootScope.fromParams = fromParams;
        $rootScope.fromState = from.name;
        $rootScope.currentState = to.name;
        console.log($rootScope.currentState);
        if($rootScope.currentState == 'login') {
            $rootScope.isLogin = false;
        }else {
            $rootScope.isLogin = true;
        }
    })
});

app.config(function($stateProvider, $urlRouterProvider , $locationProvider) {

    $urlRouterProvider.otherwise('/login');

    $stateProvider
        .state('login', {
            url : '/login',
            templateUrl : './app/src/shared/login/login.template.html',
            controller : 'loginController',
            data : {
                roles : 'all'
            }
        })
        .state('user' , {
            abstract : true,
            url : '/user',
            templateUrl : './app/src/user/usercontainer.template.html',
            data : {
                roles : 'user'
            }
        })
        .state('user.home' , {
            url : '',
            templateUrl : './app/src/user/userhome/_components/userhome.template.html',
            controller : 'userHomeCtrl',
            data : {
                roles : 'user'
            }
        })
        .state('user.psb' , {
            url : '/psb',
            templateUrl : './app/src/user/userhome/_components/psbform.template.html',
            controller : 'psbFormCtrl',
            data : {
                roles : 'user'
            }
        })
        .state('help' , {
            url : '/help',
            templateUrl : './app/src/shared/help/help.template.html',
            controller : 'baseCtrl',
            data : {
                roles : 'all'
            }
        })
        .state('manager' , {
            abstract : true,
            url : '/manage',
            templateUrl : './app/src/manager/managermain.template.html',
            data : {
                roles : 'manager'
            }
        })
        .state('manager.home' , {
            url : '',
            templateUrl : './app/src/manager/managerhome.template.html',
            controller: 'managerCtrl',
            data : {
                roles : 'manager'
            }
        })
        .state('manager.psb' , {
            url : '/psb',
            templateUrl : './app/src/manager/psbform.template.html',
            controller: 'psbCtrlM',
            data : {
                roles : 'manager'
            }
        })
        .state('admin', {
            abstract: true,
            url : '/admin',
            templateUrl : './app/src/admin/admincontainer.template.html',
            data : {
                roles : 'admin'
            }
        })
        .state('admin.dashboard' , {
            url : '',
            templateUrl : './app/src/admin/_components/views/dashboard.template.html',
            controller : 'dashboardController',
            data : {
                roles : 'admin'
            }
        })
        .state('admin.registerproduct' , {
            url : '/addproduct',
            templateUrl : './app/src/admin/_components/views/regproduct.template.html',
            controller : 'regProdCtrl',
            data : {
                roles : 'admin'
            }
        })
        .state('admin.modifyoption' , {
            url : '/templateoptions',
            templateUrl : './app/src/admin/_components/views/modifyoptions.template.html',
            controller : 'modifyCtrl',
            data : {
                roles : 'admin'
            }
        })
        .state('admin.poc' , {
            url : '/addpoc',
            templateUrl : './app/src/admin/_components/views/addpoc.template.html',
            controller : 'pocCtrl',
            data : {
                roles : 'admin'
            }
        })
        .state('admin.help' , {
            url : '/edithelp',
            templateUrl : './app/src/admin/_components/views/edithelp.template.html',
            controller : 'helpCtrl',
            data : {
                roles : 'admin'
            }
        })
        .state('admin.psbview' , {
            url : '/psbview',
            templateUrl : './app/src/admin/_components/views/dashboardcomponents/psb.template.html',
            controller : 'psbViewCtrl',
            data : {
                roles : 'admin'
            }
        })
        .state('admin.psb' , {
            url : '/editpsb',
            templateUrl : './app/src/admin/_components/views/editpsb.template.html',
            controller : 'editPsbCtrl',
            data : {
                roles : 'admin'
            }
        }).state('admin.preengage' , {
            url : '/editpreengage',
            templateUrl : './app/src/admin/_components/views/editpreengage.template.html',
            controller : 'editPreengageCtrl',
        })
        .state('admin.dashpreengage' , {
            url : '/preengage/:process',
            templateUrl : './app/src/admin/_components/views/dashboardcomponents/preengage.template.html',
            controller : 'editPreengageCtrl',
            params : {
                process : null
            },
            data : {
                roles : 'admin'
            }
        })
        $locationProvider.html5Mode(true);
});


