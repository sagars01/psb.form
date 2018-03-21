// Code goes here
$(document).ready(function() {
  selectChangeDetection();
});

function selectChangeDetection() {
  $('select').on('change', function (e) {
      var valueSelected = this.value;
      if(valueSelected != "Select a product") {
        $(".path-wrapper").css({"display" : "block"});
      }else {
        $(".path-wrapper").css({"display" : "none"});
      }
  }); 
};