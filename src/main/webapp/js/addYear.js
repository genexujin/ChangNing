function add(){
	var addyear=$("#year").val();
	$.ajax({
		   type: "POST",
		   url: "/ChangNing/setYear/"+addyear+".do",
		   data: "",
		   success: function(msg){
		     alert( "Data Saved: " + msg );
		   }
		});
	//document.location.href="http://localhost:8080/ChangNing/setYear/"+addyear+".do";
}