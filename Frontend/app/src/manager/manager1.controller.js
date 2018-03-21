app.controller("managerCtrl" , function($scope, $rootScope, mainService, toaster){
    $scope.selectedProduct = "Select a product";
    $scope.selectedVersion = "Select a version";
    $scope.getProductList = function() {
        mainService.productList('GET').then(function(response) {
            $scope.products = response;
            console.log($scope.products);
        }).catch(function(err) {
            toaster.pop('error' , 'Error fetching data!');
        })  
    }
    $scope.getProductList();

    
    $scope.prodVersions = [];

    $scope.dataModel = {
        product_id : null,
        version : null
    }

    function getTrimmedArray(productId) {
        var t = [];
        angular.forEach($scope.products , function(el){
            if(el.Product_id == productId.Product_id) {
                t.push(el.Version);
            }
        });
        return t;
    }
    var self = this;
    $scope.selectedProductChange = function() {
        $scope.prodVersions = getTrimmedArray($scope.selectedProduct);
        $scope.dataModel.product_id = $scope.selectedProduct.Product_id;
    }
    $scope.versionChange = function(){
        $scope.dataModel.version = $scope.selectedVersion;
        $scope.setKeyid('POST' , $scope.dataModel);
    }
    $scope.setKeyid = function(method , data) {
        mainService.productList(method , data).then(function(response){
            console.log(response);
        }).catch(function(error) {
            console.log(error);
        })
    }
    
})

app.controller('psbCtrlM' , function($scope, $rootScope, mainService, toaster){
    $scope.tableDataIterator = [];
    $scope.isAdminViewing = true;
    $scope.statusOptions = ["Not_Answered" ,"PASS", "FAIL", "APPLICABLE" , "BACKLOG"];
    
    $scope.getPsbFormData = function() {
        mainService.psbFormService('GET').then(function(response) {
            $scope.tableDataIterator = response;
            // console.log(response);
        }).catch(function(error){
            // alert(error);
        })
    }
    $scope.getPsbFormData();

    $scope.submitPsbForm = function() {
        console.log($scope.tableDataIterator);
        mainService.psbFormService('POST' , $scope.tableDataIterator).then(function(response) {
            alert("Thanks for your feedback!");
            $state.go("home" , {reload : true});
            // console.log(response);
        }).catch(function(error){
            console.error(error);
        })
    }

    $scope.formAction = function(param) {
        var temp = [];
        angular.forEach( $scope.tableDataIterator , function(el) {
            if(el.psb_id != undefined) {
                temp.push(el.psb_id);
            }
        })
        var actionModel = {
            psb_id : temp,
            isApproved : null
        }
        if(param == 'a') {
            actionModel.isApproved = 'true';
        }else {
            actionModel.isApproved = 'false';
        }

        var data = angular.toJson(actionModel);
        mainService.manage(data).then(function(response) {
            if(param == 'a') {
                toaster.pop('success' , 'Successfully Approved');
                $state.go('manager.home');
            }else {
                toaster.pop('success' , 'Successfully Rejected');
                $state.go('manager.home');
            }
        }).catch(function(err){
            toaster.pop('error' , 'Some issue with server');
        })

    }
})