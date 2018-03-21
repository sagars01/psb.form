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
    $scope.rejected = false;
    $scope.processing = false;
    $scope.getPsbFormData = function() {
        mainService.psbFormService('GET').then(function(response) {
            $scope.tableDataIterator = response;
            var formStatus = getStatus($scope.tableDataIterator);
		$scope.formStatus = formStatus;
            if(formStatus == 'rejected') {
                $scope.rejected = true;
            }else {
                $scope.rejected = false;
            }

            if(formStatus == 'processing'){
		$scope.processing = true;
	    }
        }).catch(function(error){
            // alert(error);
        })
    }
    $scope.getPsbFormData();

    function getStatus (arrayParam) {
        var status = null;
        angular.forEach(arrayParam , function(el){
            if(el.manager_status != undefined) {
                if(el.manager_status == "rejected") {
                    status = "rejected";
                }else if(el.manager_status == "approved") {
                    status = "approved";
                }else if(el.manager_status == "processing"){
			    status = 'processing';
			}
            }else {
			//status = "approved";
		}
        })
        return status;
    }

    $scope.submitPsbForm = function() {
        console.log($scope.tableDataIterator);
        mainService.psbFormService('POST' , $scope.tableDataIterator).then(function(response) {
            // alert("Thanks for your feedback!");
            toaster.pop('success' , 'Response Submitted Successfully!');
            // console.log(response);
            $timeout(function(){	
                $state.go("user.home" , {reload : true});	
            }, 2000);
        }).catch(function(error){
            console.error(error);
            toaster.pop('error' , 'OOPS' , 'There is some error at the server!');
        })
    }

    $scope.draftPSBForm = function() {
        console.log($scope.tableDataIterator);
        mainService.psbDraft('POST' , $scope.tableDataIterator).then(function(response) {
            // alert("Thanks for your feedback!");
            toaster.pop('success' , 'Draft Saved Successfully!')
            // console.log(response);
        }).catch(function(error){
            console.error(error);
        })
    }

    $scope.uploadFile = function () {
        var file = $scope.myFile;
        console.log(file);
        mainService.fileUploadService(file).then(function (response) {
            toaster.pop('success' , "Success" , "File Uploaded Successfully!");
//            $state.reload();
        })
        .catch(function(err){
            toaster.pop("error" , "Some Error while Upload")
        })
    };

    $scope.invalidText = " ";
    $scope.uploadBtn = true;
    $("#myFileField").bind("change" , function(){
        var selectedFile = this.files[0];
        var fileSize = selectedFile.size /1024 / 1024;
        console.log(selectedFile);
        
        if(this.files.length > 0) {
            if(selectedFile.type != "application/zip" && selectedFile.type != "application/x-zip-compressed") {
                $scope.invalidText = "File Type not Supported!";
            }else if(fileSize > 10) {
                    $scope.invalidText = "File size, greater than 10MB";
                    }else {
                        $scope.uploadBtn = false;
                    }
        }
    })
	 $scope.backbutton = function() {
        $state.go('user.home');
    }

})

app.directive('demoFileModel', function ($parse) {
    return {
        restrict: 'A', //the directive can be used as an attribute only

        /*
         link is a function that defines functionality of directive
         scope: scope associated with the element
         element: element on which this directive used
         attrs: key value pair of element attributes
         */
        link: function (scope, element, attrs) {
            var model = $parse(attrs.demoFileModel),
                modelSetter = model.assign; //define a setter for demoFileModel

            //Bind change event on the element
            element.bind('change', function () {
                //Call apply on scope, it checks for value changes and reflect them on UI
                scope.$apply(function () {
                    //set the model value
                    modelSetter(scope, element[0].files[0]);
                });
            });
        }
    };
});
