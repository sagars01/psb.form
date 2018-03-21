app.controller("userHomeCtrl" , function($scope , $state, mainService ) {
    $scope.productList = [];
    $scope.selectedProduct = "Select a product";
    $scope.selectedVersion1 = "Select a version";

    $scope.redirectToQuestions = function(routePath) {
        switch (routePath) {
            case 'pre' :
                console.log($scope.selectedProductJSON);
                $scope.getPostOnProductList('POST' , $scope.selectedProductJSON);
                $state.go('preengage' , {reload : true});
            break;
            case 'psbform':
            $state.go('user.psb' , {reload : true});
            break;
        }
    }

    $scope.sendProductId = function() {

    }

    $scope.getPostOnProductList = function(method , dataArgs) {
        mainService.productList(method, dataArgs).then(function(response){
            $scope.productList = response;
            return response;
        }).catch(function(error){
            console.error(error);
            return error;
        });
    }
    //Init Call
    $scope.getPostOnProductList('GET');
    $scope.selectedVersion1 = "Select a version";
    

    $scope.tempSelectedProductJSON = {
        product_id : null,
        version : null
    };
    
    function getTrimmedArray(productId) {
        var t = [];
        angular.forEach($scope.productList , function(el){
            if(el.Product_id == productId) {
                t.push(el.Version);
            }
        });
        return t;
    }

    $scope.selectedProductChange = function() {
        $scope.tempSelectedProductJSON.product_id = $scope.selectedProduct.Product_id;
        $scope.prodVersions = getTrimmedArray($scope.selectedProduct.Product_id);
        var valueSelected = $scope.selectedProduct;
    }
    $scope.versionChange = function() {
        $scope.tempSelectedProductJSON.version = $scope.selectedVersion1;
        $scope.selectedProductJSON = angular.toJson($scope.tempSelectedProductJSON);
        $scope.setKeyid('POST' , $scope.selectedProductJSON);
    }

    $scope.setKeyid = function(method , data) {
        mainService.productList(method , data).then(function(response){
            console.log(response);
        }).catch(function(error) {
            console.log(error);
        })
    }
})

/**
 * PSB FORM CONTROLLER
 */
app.controller("psbFormCtrl" , function($scope , $state, $timeout, mainService , toaster){
    
    $scope.tableDataIterator = [];
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
            // alert("Thanks for your feedback!");
            toaster.pop('success' , 'Response Submitted Successfully!')
            $timeout(function(){
                $state.go("user.home" , {reload : true});
            }, 2000);
            
            // console.log(response);
        }).catch(function(error){
            console.error(error);
        })
    }
    $scope.backbutton = function() {
        $state.go('user.home');
    }

})
