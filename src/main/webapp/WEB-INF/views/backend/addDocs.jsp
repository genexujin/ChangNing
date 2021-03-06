<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>

<%@ include file="../header.jspf"%>

      <script src="uploadify/jquery.uploadify.js"></script>
      <script src="Jcrop-0.9.12/js/jquery.Jcrop.min.js"></script>

<!--       <strong>您的位置：</strong>
      <ul class="breadcrumb">
        <li><a href="#">首页</a> <span class="divider">/</span></li>
        <li><a href="#">网上办证</a> <span class="divider">/</span></li>
        <li class="active">补充材料</li>
      </ul> -->
      
 <div class="row">
        <div class="span12 content_title">
          <h2>补充材料</h2>
        </div>
      </div>
      
<div id="myModal1" class="modal hide fade" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true" style="width:400px;">
	<div class="modal-header" style="height:10px;">		
		<p id="myModalLabel">请按照样张示例裁剪，注意头部周围留出足够空间。</p>
	</div>
	<div class="modal-body">
		<img id="sampleImage" style="width:240px;height:364px;" src="resources/crop_sample.png"/>		
	</div>
	<div class="modal-footer" style="height:20px;">
		<button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
	</div>
</div>
		<div class="border">
	  	<br>
		  <div class="row">		   
			    <div class="span10 offset1">
			      <h5><font color="red">请上传所需材料。提示：本系统支持 .jpg, .jpeg, .doc, .docx类型文件，且单个文件大小不能超过4M。</font></h5>
			      <h5><font color="red">若无法通过网络上传，可以选择现场补充材料。</font></h5>
			    </div>

		  </div>
		   <br>
	  </div>

	  <div class="row">
	    <div class="span10 offset1">
	      <h5>申办号：${um.orderReadableId}</h5>
	    </div>
	  </div>
	  
	  <br>
	  
	      <c:if test="${not um.allInOneUploadEmpty}">
	      	  <div class="bar-bg">
		        <div class="row">
		          <div class="span12 navbg2">
		            <h5>&nbsp;&nbsp;&nbsp;&nbsp;基本材料</h5>
		          </div>
		        </div>
	          </div>
	      
		      <div class="border">
		        <br>
		        <div class="row">
		          <div class="span11 offset1">
			        <p><h5>需要上传的材料：</h5>
			        <ul>
			          <c:forEach items="${um.allInOneValues}" var="docs" >
			            <c:forEach items="${docs}" var="doc" >
			              <li>${doc.docName}</li>
			            </c:forEach>
			          </c:forEach>
			        </ul>
			        <c:if test="${not empty order.extraDocs}">
			          <p><h5>额外要求补充的材料：</h5>
		              <ul>
			            <c:forEach items="${order.extraDocs}" var="docs" >
			              <li>${docs.extraDocNames}</li>
			            </c:forEach>
				      </ul>
			        </c:if>
			        <div class="row">
			          <div class="span4">
			            <div id="all_upload" ></div>
			          </div>
	<!-- 		          <div class="span4">
			            <button id="upload_button" class="btn btn-success">上传</button>
			          </div> -->
			        </div>
			        <br>
			        	          
		          </div>
		        </div>
		      </div>
		      <script>
				$(function() {
				    $('#all_upload').uploadify({
				    	'fileSizeLimit' : '4MB',
				        'swf'             : 'uploadify/uploadify.swf',
				        'uploader'        : '<c:url value="/upload.do"/>',
				        // Put your options here
				        'buttonClass'     : 'btn btn-success btn-mini',
				        'buttonText'      : '选择文件',
				        'height'          : 25,
				        'width'           : 80,
				        'fileTypeDesc'    : 'Image Files',
				        'fileTypeExts'    : '*.jpg; *.jpeg; *.doc; *.docx',
				        "removeCompleted" : false,
				        'formData'        : {
				        	'uid' : '${um.uid}',
				        	'docKey': 'allInOne'
				        },
				        'onUploadSuccess' : function(file, data, response) {
				            //alert('The file was saved to: ' + data);
				        }
				        
				    });
				});
		
			  </script>
	      </c:if>
	      
	      <!-- 需要单独上传 -->
	      <c:if test="${not um.aloneUploadEmpty}">
		      <div class="bar-bg">
			      <div class="row">
			        <div class="span12 navbg2">
			          <h5>&nbsp;&nbsp;&nbsp;&nbsp;特殊材料</h5>
			        </div>
			      </div>
		      </div>
		      
		      <div class="border">
		        <c:if test="${not empty Special_note}">
		        <br/>
		        <div class="row">
		          <div class="span offset1">
		            ${Special_note}
		          </div>
		        </div>
		        </c:if>
	        	<br/>
	        	<c:forEach items="${um.aloneUpload}" var="doc" >
	        	  <div class="row">
		        	<div class="span offset1">
		              <h5>${doc.docName} </h5>
		            </div>
		            <div class="span7">
		              <div id="${doc.docKey}" class="file_upload" ></div>
		            </div>
	        	  </div>
	        	  <script>
	        	  $(function() {
	                	$('#${doc.docKey}').uploadify({
	                		'fileSizeLimit' : '4MB',
	        		        'swf'             : 'uploadify/uploadify.swf',
	        		        'uploader'        : '<c:url value="/upload.do"/>',
	        		        // Put your options here
	        		        'buttonClass'     : 'btn btn-success btn-mini',
	        		        'buttonText'      : '选择文件',
	        		        'height'          : 25,
	        		        'width'           : 80,
	        		        'fileTypeDesc'    : 'Image Files',
	        		        'fileTypeExts'    : '*.jpg; *.jpeg; *.doc; *.docx',
	        		        'removeCompleted' : false,
	        		        'formData'        : {
	        		        	'uid' : '${um.uid}',
	        		        	'docKey' : '${doc.docKey}',
	        		        	'needCrop' : '${doc.needCrop}'
	        		        }
	        		    });
	                });
	        	  </script>
	        	</c:forEach>
		      </div>
	      </c:if>
	      
	      <!-- 需要裁剪区 -->
	      <c:if test="${not um.needCropEmpty}">
	        <c:forEach items="${um.needCrop}" var="doc" >
	          <div class="bar-bg">
			      <div class="row">
			        <div class="span12 navbg2">
			          <h5>&nbsp;&nbsp;&nbsp;&nbsp;上传${doc.docName}</h5>
			        </div>
			      </div>
		      </div>
			  <div class="border">
		          <br>
			      <div class="row">
		            <div class="span offset1">
		              <h5>${doc.docName} <a class="yz" style="padding-left:5px;">样张</a></h5>
		            </div>
		            <div class="span7">
		              <c:if test="${doc.needCrop}">
		                <img id="${doc.docKey}_img"/>
		                <input id="${doc.docKey}_x" style="display:none"/>
		                <input id="${doc.docKey}_y" style="display:none"/>
		                <input id="${doc.docKey}_x2" style="display:none"/>
		                <input id="${doc.docKey}_y2" style="display:none"/>
		                <input id="${doc.docKey}_w" style="display:none"/>
		                <input id="${doc.docKey}_h" style="display:none"/>
		                <input id="${doc.docKey}_fileName" style="display:none"/>
		                <div id="${doc.docKey}_crop" class="btn btn-success btn-mini" style="padding: 0 6px;display:none">裁剪</div>
		              </c:if>
		              <div id="${doc.docKey}" class="file_upload" ></div>
		            </div>
		            <div class="span2" id="${doc.docKey}_result">
		            </div>
		          </div>
		          <script>
		            var ${doc.docKey}_jcrop_api;
		           
		            
		            function ${doc.docKey}_storeCoords(c) {
		            	$('#${doc.docKey}_x').val(Math.round(c.x));
		            	$('#${doc.docKey}_y').val(Math.round(c.y));
		            	$('#${doc.docKey}_x2').val(Math.round(c.x2));
		            	$('#${doc.docKey}_y2').val(Math.round(c.y2));
		            	$('#${doc.docKey}_w').val(Math.round(c.w));
		            	$('#${doc.docKey}_h').val(Math.round(c.h));
		            }
		            
		            function ${doc.docKey}_crop() {
		            	$.ajax({
		                    url: "cropImage.do",
		                    type: "POST",
		                    success: function (data) {
		                    	var imgObj = $('<img src="' + data + '" />');
		                        var target = $('#${doc.docKey}_result');
		                        target.children().remove();
		                        target.append(imgObj);
		                    },
		                    data :{
		                        x : $('#${doc.docKey}_x').val(),
		                        y : $('#${doc.docKey}_y').val(),
		                        x2 : $('#${doc.docKey}_x2').val(),
		                        y2 : $('#${doc.docKey}_y2').val(), 
		                        w : $('#${doc.docKey}_w').val(),
		                        h : $('#${doc.docKey}_h').val(),
		                        imageName : $('#${doc.docKey}_fileName').val(),
		                        uid : '${um.uid}',
		                        dockey : '${doc.docKey}'
		                    }
		            	});
		            }
		          
	                $(function() {
	                	$('#${doc.docKey}').uploadify({
	                		'fileSizeLimit' : '4MB',
	        		        'swf'             : 'uploadify/uploadify.swf',
	        		        'uploader'        : '<c:url value="/upload.do"/>',
	        		        // Put your options here
	        		        'buttonClass'     : 'btn btn-success btn-mini',
	        		        'buttonText'      : '选择文件',
	        		        'height'          : 25,
	        		        'width'           : 80,
	        		        'fileTypeDesc'    : 'Image Files',
	        		        'fileTypeExts'    : '*.jpg; *.jpeg',
	        		        'removeCompleted' : false,
	        		        'multi'           : false,
	        		        'formData'        : {
	        		        	'uid' : '${um.uid}',
	        		        	'docKey' : '${doc.docKey}',
	        		        	'needCrop' : '${doc.needCrop}'
	        		        },
	        		        'onUploadSuccess' : function(file, data, response) {
	        		        	if (data.lastIndexOf("/") != -1) {
	        		        		var fileName = data.substring(data.lastIndexOf("/") + 1).replace(".do", "");
	        		        		$('#${doc.docKey}_fileName').val(fileName);
	        		        	}
	        		        	
	        		        	if (${doc.docKey}_jcrop_api != undefined) {
	        		        		${doc.docKey}_jcrop_api.destroy();
	        		        		${doc.docKey}_jcrop_api = undefined;
	        		        	}
	        		        	var oldImg = $('#${doc.docKey}_img');
	        		        	var parent = oldImg.parent();
	        		        	oldImg.remove();
	        		        	var newImg = $('<img id="${doc.docKey}_img"/>')
	        		        	parent.prepend(newImg);
	        		        	newImg.prop('src', data);
	        		        	
	        		        	//$('#${doc.docKey}_img').prop('src', data);
	        	            	$('#${doc.docKey}_crop').css("display", "inline-block");
	        	            	$('#${doc.docKey}_crop').click(${doc.docKey}_crop);
	        	            	
	        	            	//if (${doc.docKey}_jcrop_api == undefined) {
	        	            	//	$('#${doc.docKey}_img').Jcrop({
		        		        //		aspectRatio : 0.66,
		        		        //		setSelect : [0, 0, 120, 180],
		        		        //		allowSelect : false,
		        		        //		allowResize : true,
		        		        //		onSelect : ${doc.docKey}_storeCoords
		        		        //	}, function() {
		        		        //		${doc.docKey}_jcrop_api = this;
		        		        //	});
	        	            	//} else {
	        	            	//	${doc.docKey}_jcrop_api.setImage(data);
	        	            	//}
	        	            	
	        	            	if (${doc.docKey}_jcrop_api == undefined) {
	        	            		$('#${doc.docKey}_img').Jcrop({
		        		        		aspectRatio : 0.66,
		        		        		setSelect : [0, 0, 120, 180],
		        		        		allowSelect : false,
		        		        		allowResize : true,
		        		        		onSelect : ${doc.docKey}_storeCoords
		        		        	}, function() {
				        		        		${doc.docKey}_jcrop_api = this;
		        		        	});
	        	            	} 
	        		        }
	        		    });
	                });
		          </script>
			    <br>
		      </div>
		    </c:forEach>
	      </c:if>

	      <br>
	      <br/>
		  <div class="row">
	   		  <div class="span2 offset4">
	   		    <a href="confirmAddDoc.do?oId=${um.uid}" class="btn btn-primary">上传完成</a>	   		    
	   		  </div>
	   		  <!-- 
	   		  <div class="span2">
	   		    <a href="addDocOnSite.do?oId=${um.uid}" class="btn btn-primary">现场补充材料</a>
	   		  </div>
	   		   -->
	      </div>
	       <script>
	       	$(".yz").click(
	           	function(){        		
	           		$("#myModal1").modal("show");
	           	}
	           );
	       </script>
      
      
<%@ include file="../footer.jspf"%>