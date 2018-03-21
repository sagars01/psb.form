app.controller("dashboardController" , function($scope , $http, $state, mainService) {
    
    $scope.goToRegister = function() {
        $state.go("admin.registerproduct" , {reload : true});
    }

    $scope.goToModify = function() {
        $state.go("admin.modifyoption" , {reload : true});
    }

    $scope._init = function() {
        mainService.productList('GET').then(function(response){
            $scope.productList = response;       
        })
    }
    $scope._init();
    
    

    //Object to store posting Data.
    $scope.postData = {
        product_id : null,
        version : null
    }
    //Selected Product Change
    $scope.selectedProduct = "Select a product";
    $scope.selectedProductChange = function() {
        console.log($scope.selectedProduct);
        $scope.versions = getTrimmedArray($scope.selectedProduct.Product_id);
        $scope.postData.product_id = $scope.selectedProduct.Product_id;
    }

    function getTrimmedArray(productId) {
        var t = [];
        angular.forEach($scope.productList , function(el){
            if(el.Product_id == productId) {
                t.push(el.Version)
            }
        });
        return t;
    }
    /**
     *
     "action" : "delete",
	"Question_id" : 10,
	"Milestone_id" : ""
     */

    // Version Change
    $scope.selectedVersion = "Select a version";
    $scope.versions = [];
    $scope.versionChange = function() {
        $scope.postData.version = $scope.selectedVersion;
        console.log(angular.toJson($scope.postData));
        var tempJData = angular.toJson($scope.postData);
        $scope.setKeyid('POST' , tempJData );
    }

    $scope.setKeyid = function(method , data) {
        mainService.productList(method , data).then(function(response){
            console.log(response);
        }).catch(function(error) {
            console.log(error);
        })
    };

    $scope.goToForms = function(stateName , process) {
        $state.go(stateName , { process : process });
    }

})

 /**
  * Register Product Controller Start
  */
 app.controller("regProdCtrl" , function($scope , $http, $state, toaster, mainService) {
    
    $scope.product_name = "";
    $scope.version = '';

    $scope.addProduct = function( ) { 
        $scope.data = {
            product_name : $scope.product_name,
            version : $scope.version
        };   
        $scope.jsonData = angular.toJson($scope.data);
        mainService.registerProduct($scope.jsonData).then(function(response){
            console.log(response);
            if(response.Status == 'OK') {
                //alert('Product successfully added')
                toaster.pop('success' , "Product added successfully",  "OK!");
                $state.reload();
            }else if(response.Status == 'Exists') {
                // alert('Product already exists!');
                toaster.pop('error' , "Product already exists",  "");
            }
            
        }).catch(function(error){
            console.log(error);
            toaster.pop('error' , "There are some errors");
        });
            
    }


});
/**
 * Modify Options Controller
 */

app.controller("modifyCtrl" , function($scope , $rootScope, $state , mainService) {
    $scope.changeRoute = function(routeName) {
        $state.go(routeName);
        $rootScope.isAdminModify = true;
    }
});

/**
 * 
 * POC Controller
 */

app.controller("pocCtrl" , function($scope , mainService){
    $scope.main = { 
        manager : [''] , 
        engineer : [''] , 
        sdl : ['']
    };
    $scope.temp = { 
        manager : "",
        product_engineer : "",
        sdl_engineer: ""
    };

    $scope.addField = function(arrayParam) {
        $scope.main[arrayParam].push('');
    }
    $scope.removeField = function(arrayParam) {
        if($scope.main[arrayParam].length > 1) {
            $scope.main[arrayParam].pop();
        }
    }
    $scope.savePoc = function() {
        mainService.poc(angular.toJson($scope.temp)).then(function(response){
            console.log(response);
            alert("User Added");
        }).catch(function(err){
            console.log(err);
        })
    }

});

/**
 * Edit PSB Template Controller
 */
app.controller("editPsbCtrl" , function($scope , $state, mainService, toaster){
    
    $scope.tableDataIterator = [];
    $scope.statusOptions = ["Not_Answered" ,"PASS", "FAIL", "APPLICABLE" , "BACKLOG"];
    
    $scope.getPsbFormData = function() {
        mainService.modpsb('GET').then(function(response) {
            $scope.tableDataIterator = response;
            // console.log(response);
        }).catch(function(error){
            // alert(error);
        })
    }
    $scope.getPsbFormData();

    $scope.rmPsb = function(fullObj , obj, index) {
        var rmPsbModel = {
            action : 'delete',
            Id : obj.psb_id
         } 

        console.log(obj , index)
        mainService.modpsb('POST', angular.toJson(rmPsbModel)).then(function(response) {
            if(obj.psb_id == undefined) {
                fullObj.pop();
             }else{
                fullObj.splice(index , 1);
             }    
        }).catch(function(err){
            alert("There's some error!");
        });
    }

    $scope.svPsb = function(fullObj , obj, index) {
        console.log(fullObj);
        if(obj.requirement != "" && obj.requirement != undefined && obj.psb_id != undefined) {
            var svModel = {
                action : 'add',
                Id : obj.psb_id == undefined ? '' : obj.psb_id,
                Requirement : obj.requirement == undefined ? '' : obj.requirement,
                Reason : obj.reason == undefined ? '': obj.reason
             }
             mainService.modpsb('POST', angular.toJson(svModel)).then(function(response) {
                toaster.pop('success', "Requirement Added Successfully!");    
            }).catch(function(err){
                alert("There's some error!");
            });
        }else {
            toaster.pop('warning', "Requirement/Number cannot be blank!");
        }
    }
    $scope.addPsbRow = function() {    
        var tempObj = {
            psb_id : ''
        };
        $scope.tableDataIterator.push(tempObj);
    };
    $scope.preview = false;
    $scope.previewPsb = function() {
        if($scope.preview == true) {
            $scope.preview = false;
        }else {
            $scope.preview = true;
        }
    }
})

/**
 * Edit Pre-Engage Template Controller
 */
app.controller("editPreengageCtrl" , function($scope , $state, mainService , toaster) {
    $scope.preview = false;
    $scope.preEditSwitch = "Preview";

    $scope.editQuestion = function(index, question) {
        console.log(index);
    }
    
    $scope.switchMode = function() {
        if($scope.preview == true) {
            $scope.preview = false;
            $scope.preEditSwitch = "Preview";
        }else {
            $scope.preview = true;
            $scope.preEditSwitch = "Edit";
        }
        
    };

    $scope.addQuestion = function() {
        var emptyObject = {}
        $scope.Questionaires.push(emptyObject);
    }
    $scope.addMilestone = function() {
        var emptyObject = {

        }
        $scope.Milestones.push(emptyObject);

    }

    $scope.saveQuestion = function(index , question) {
        var saveQuestionModel = {
            action : 'add',
            Id : question.Question_id == undefined ? '' : question.Question_id,
            Question : question.Question == undefined ? '' : question.Question,
            Milestone : ''
        }
        question.isDisabled = true;
        mainService.modpreengage('POST' , angular.toJson(saveQuestionModel)).then(function(response) {
            question.isDisabled = false;
            toaster.pop('success' , 'Question added successfully!')
        }).catch(function(err){
            alert("There's some error!");
            question.isDisabled = false;
        });
    }
    $scope.removeQues  = function(fullObj , obj , index) {
        var removeQuestionModel = {
            action : 'delete',
            Question_id : obj.Question_id,
            Milestone_id : ''
         } 
        console.log(obj , index)
        mainService.modpreengage('POST' , angular.toJson(removeQuestionModel)).then(function(response) {
            if(obj.Question_id == undefined) {
                fullObj.pop();
             }else{
                fullObj.splice(index , 1);
             }    
        }).catch(function(err){
            alert("There's some error!");
        });
    }

    $scope.removeQuesM = function(fullObj , obj, index) {
        var removeMilestoneModel = {
            action : 'delete',
            Question_id : '',
            Milestone_id: obj.Milestone_id
        }
        
        mainService.modpreengage('POST', angular.toJson(removeMilestoneModel)).then(function(response){
            if(obj.Milestone_id == undefined) {
                fullObj.pop();
             }else{
                fullObj.splice(index , 1);
            }
        }).catch(function(err){
            alert('There are some error at the server!');
        });
    }

    $scope.svNewQuesM = function(fullObj , obj , index) {
        var qModel = {
            action : "add",
            Question : '',
            Milestone : obj.Milestone
        };
        if(obj.Milestone_id == undefined) {
            qModel.Id = '';
        }else {
            qModel.Id = obj.Milestone_id;
        }
        mainService.modpreengage('POST', angular.toJson(qModel)).then(function(response){
            toaster.pop('success' , 'Milestone added Successfully');
        }).catch(function(err){
            toaster.pop('error' , 'There are some error at the server!');
        });
	

//	$scope.backbutton = function() {
//        $state.go('user.home');
    }
    }

    // $scope.submitPreEngagementForm = function() {
    //     $scope._init('POST' , angular.toJson($scope.response));
    // }
    
    $scope.trimResponse = function(arrayParam , type) {
        var tempArray = [];
        if(type == 'new') {
            angular.forEach(arrayParam , function(el) {
                el.Question_response = "";
                
                tempArray.push(el);
            })
            return tempArray;
        }else {
            return arrayParam;
        }
            
    };
    $scope.process = $state.params.process;
    $scope.viewOnly = false;
    $scope._init = function (method , data ) {
        mainService.preengage(method, data).then(function(response) {
            console.log(response[0].Questionaires);
            if(method != 'POST') {
                $scope.response = response;
                $scope.Questionaires = $scope.trimResponse(response[0].Questionaires , $scope.process);
                $scope.Milestones = response[0].Milestones;
                if($scope.process == 'view') {
                    $scope.viewOnly = true;
                }
            }
            if(data != null) {
                //$state.go("home" , {reload : true});
            }        
        })
    }
    
    $scope._init('GET' , $scope.process);
    console.log($state.params);
})

app.controller("helpCtrl" , function($scope , $rootScope , mainService, toaster) {

    $scope._init = function(method , data) {
        if(method == 'GET') {
            mainService.help(method).then(function(response) {
                $scope.helpIterator = response[0];
            }).catch(function(error) {
                toaster.pop('error' , "There are some errors at the server!")
            })
        }else {
            mainService.help(method , data).then(function(response) {
                //$scope.helpIterator = response;
                console.log(response);
            }).catch(function(error) {
                toaster.pop('error' , "There are some errors at the server!")
            })
        }
    }
    $scope._init('GET');

    $scope.saveHelp = function(fullObj , obj , index , table) {
        switch(table) {
            case 'first_table' : 
            var data = {
                action : 'add',
                Table : table,
                Outcome : obj.outcome == undefined ? '' : obj.outcome,
                Description : obj.description == undefined ? '' : obj.description,
                Justification : obj.justification == undefined ? '' : obj.justification
            }
            postHelpData(data);
            break;
            case 'second_table':
            var data2 = {
                action : 'add',
                Table : table,
                Language : obj.language == undefined ? '' : obj.language,
                Definition : obj.definition == undefined ? '' : obj.definition
            }
            postHelpData(data2);
            break;
            case 'third_table':
            var data3 = {
                action : 'add',
                Table : table,
                Outcome : obj.Outcome == undefined ? '' : obj.Outcome,
                Description : obj.description == undefined ? '' : obj.description
            }
            postHelpData(data3);
        }
    }


    $scope.rmHelp = function(fullObj , obj , index, table) {
        var rmData = {
            action : 'delete',
            Table : table,
            Id : obj.id
        };
        console.log(obj);
        if(obj.id != undefined) {
            postHelpData(rmData);
        }else {
            switch(table) {
                case 'first_table' :
                    $scope.helpIterator.first_table.pop();
                break;
                case 'second_table' :
                    $scope.helpIterator.second_table.pop();
                break;
                case 'third_table' :
                    $scope.helpIterator.third_table.pop();
                break;
                default :
                    toaster.pop('error' , 'Unknown Error')
                    break;
            }
        }
        
    }

    function postHelpData(data) {
        mainService.help('POST' , data).then(function(response) {
            console.log(response);
            if(data.action == 'delete') {
                toaster.pop('success' , "Row deleted");
            }else{
                toaster.pop('success' , "Help Added!");
            }
            $scope._init('GET');
        }).catch(function(err){
            toaster.pop('error' , "Some error encountered while adding");
        })
    }

    $scope.addHelp = function(tableName) {
        var blankModel = {
        }
        switch (tableName){
            case 'first' : 
            $scope.helpIterator.first_table.push(blankModel);
            break;
            case 'second' :
            $scope.helpIterator.second_table.push(blankModel);
            break;
            case 'third' :
            $scope.helpIterator.third_table.push(blankModel);
            break;
        }
            
    };


    $scope.preview = false;



})

app.controller('psbViewCtrl' , function($scope , $rootScope , mainService, toaster){
    $scope.tableDataIterator = [];
    $scope.statusOptions = ["Not_Answered" ,"PASS", "FAIL", "APPLICABLE" , "BACKLOG"];
    $scope.isAdminViewing = true;
    $scope.getPsbFormData = function() {
        mainService.psbFormService('GET').then(function(response) {
            $scope.tableDataIterator = response;
            // console.log(response);
        }).catch(function(error){
            // alert(error);
        })
    }
    $scope.getPsbFormData();

})

app.directive('jqdatepicker', function ($filter) {
    return {
        restrict: 'A',
        require: 'ngModel',
         link: function (scope, element, attrs, ngModelCtrl) {
            element.datepicker({
                dateFormat: 'dd/mm/yy',
                onSelect: function (date) {   
                    ngModelCtrl.$setViewValue(date);            
                    scope.$apply();
                }
            });
            ngModelCtrl.$formatters.unshift(function(v) {
            //return $filter('date')(v,'dd/MM/yyyy'); 
            return v; 
            });

        }
    };
});
