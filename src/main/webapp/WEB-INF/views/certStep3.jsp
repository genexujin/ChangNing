<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>

<%@ include file="header.jspf"%>

      <script src="uploadify/jquery.uploadify.js"></script>
      <script src="Jcrop-0.9.12/js/jquery.Jcrop.min.js"></script>
      
      <ul class="breadcrumb">
        <b>您的位置：</b>
        <li><a href="#">首页</a> <span class="divider">/</span></li>
        <li><a href="#">网上办证</a> <span class="divider">/</span></li>
        <li class="active">上传资料</li>
      </ul>
      
      <hr/>
      
      <div class="row">
        <div class="span12">
          <h2>网上办证</h2>
        </div>
      </div>
      
      <div class="row">
	    <div class="span12">
		  <div class="flowstep">
			<ol>
				<li class="pass">选择申办业务</li>
				<li class="ago">输入信息</li>
		        <li class="step">上传资料</li>
				<li class="">上门取证</li>
		        <li class="end">支付</li>
			</ol>
		  </div>
	    </div>
	  </div>
	  
	  <br>
	  
	  <!-- <form class="form-horizontal" action="certStep3.do" method="POST"> -->
	  
		  <div class="bar-bg">
		      <div class="row">
		        <div class="span12 navbg2">
		          <h5>&nbsp;&nbsp;&nbsp;&nbsp;合并上传材料区</h5>
		        </div>
		      </div>
	      </div>
	      
	      <div class="border">
	        <br>
	        <div class="row">
	          <div class="span11 offset1">
		        <p><h5>需要上传的材料：</h5></p>	        
		        <ul>
		          <c:forEach items="${allInOneUpload}" var="doc" >
		            <li>${doc.docName}</li>
		          </c:forEach>
		        </ul>
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
	      
	      <!-- 需要单独上传 -->
	      <div class="bar-bg">
		      <div class="row">
		        <div class="span12 navbg2">
		          <h5>&nbsp;&nbsp;&nbsp;&nbsp;单独上传材料区</h5>
		        </div>
		      </div>
	      </div>
	      
	      <div class="border">
	        <br>
	        <c:forEach items="${aloneUpload}" var="doc" >
		      <div class="row">
	            <div class="span offset1">
	              <h5>${doc.docName} </h5>
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
	                <div id="${doc.docKey}_crop" class="btn btn-success" style="display:none">剪裁</div>
	              </c:if>
	              <div id="${doc.docKey}" class="file_upload" ></div>
	            </div>
	          </div>
	          <script>
	            function ${doc.docKey}_storeCoords(c) {
	            	$('#${doc.docKey}_x').val(c.x);
	            	$('#${doc.docKey}_y').val(c.y);
	            	$('#${doc.docKey}_x2').val(c.x2);
	            	$('#${doc.docKey}_y2').val(c.y2);
	            	$('#${doc.docKey}_w').val(c.w);
	            	$('#${doc.docKey}_h').val(c.h);
	            }
	            
	            function ${doc.docKey}_crop() {
	            	$.ajax({
	                    url: "cropImage.do",
	                    type: "POST", 
	                    data :{
	                        x : $('#${doc.docKey}_x').val(),
	                        y : $('#${doc.docKey}_y').val(),
	                        x2 : $('#${doc.docKey}_x2').val(),
	                        y2 : $('#${doc.docKey}_y2').val(), 
	                        w : $('#${doc.docKey}_w').val(),
	                        h : $('#${doc.docKey}_h').val(),
	                        imageName : $('#${doc.docKey}_fileName').val(),
	                        uid : '${uid}',
	                        dockey : '${doc.docKey}'
	                    },
	                    success: function (data) { 
	                        alert('crop success!');
	                    }
	            	});
	            }
	          
                $(function() {
                	$('#${doc.docKey}').uploadify({
        		        'swf'             : 'uploadify/uploadify.swf',
        		        'uploader'        : '<c:url value="/upload.do"/>',
        		        // Put your options here
        		        'buttonClass'     : 'btn btn-success',
        		        'buttonText'      : '上传文件',
        		        'height'          : 25,
        		        'width'           : 80,
        		        'fileTypeDesc'    : 'Image Files',
        		        'fileTypeExts'    : '*.jpg; *.jpeg; *.png; *.gif',
        		        'removeCompleted' : false,
        		        'formData'        : {
        		        	'uid' : '${uid}',
        		        	'docKey' : '${doc.docKey}',
        		        	'docName' : '${doc.docName}',
        		        	'needCrop' : '${doc.needCrop}'
        		        },
        		        'onSelect'        : function(file) {
        		        	$('#${doc.docKey}_fileName').val(file.name);
        		        },
        		        'onUploadSuccess' : function(file, data, response) {
        		        	$('#${doc.docKey}_img').prop('src', data);
        	            	$('#${doc.docKey}_crop').css("display", "inline-block");
        	            	$('#${doc.docKey}_crop').click(${doc.docKey}_crop);
        		        	$('#${doc.docKey}_img').Jcrop({
        		        		setSelect : [0, 0, 120, 180],
        		        		allowSelect : false,
        		        		allowResize : false,
        		        		onSelect : ${doc.docKey}_storeCoords
        		        	});
        		        }
        		    });
                });
	          </script>
		    </c:forEach>
		    <br>
	      </div>

	      <br>
	      <br/>
		  <div class="row">
	   		  <div class="span2 offset5">
	   		    <button class="btn btn-large btn-block btn-info" type="submit">下一步</button>
	   		  </div>
	      </div>
      
      <!-- </form> -->
      <script>
		$(function() {
		    $('#all_upload').uploadify({
		        'swf'             : 'uploadify/uploadify.swf',
		        'uploader'        : '<c:url value="/upload.do"/>',
		        // Put your options here
		        'buttonClass'     : 'btn btn-success',
		        'buttonText'      : '上传文件',
		        'height'          : 25,
		        'width'           : 80,
		        'fileTypeDesc'    : 'Image Files',
		        'fileTypeExts'    : '*.jpg; *.jpeg; *.png; *.gif',
		        "removeCompleted" : false,
		        'formData'        : {
		        	'uid' : '${uid}',
		        	'docKey': 'allInOne'
		        },
		        'onUploadSuccess' : function(file, data, response) {
		            //alert('The file was saved to: ' + data);
		        }
		        
		    });
		    
		    //$("#upload_button").click(function() {
		    //	$('#file_upload').uploadify( 'upload', '*' );
		    //});
		    
		    //$('.file_upload').uploadify({
		    //    'swf'             : 'uploadify/uploadify.swf',
		    //    'uploader'        : '<c:url value="/upload.do"/>',
		        // Put your options here
		    //    'buttonClass'     : 'btn btn-success btn-small',
		    //    'buttonText'      : '上传文件',
		    //    'height'          : 25,
		    //    'width'           : 80,
		    //    'fileTypeDesc'    : 'Image Files',
		    //    'fileTypeExts'    : '*.jpg; *.jpeg; *.png; *.gif',
		    //    "removeCompleted" : false,
		    //    'formData'        : {
		    //    	'uid' : '${uid}'
		    //    }
		    //});
		});

	  </script>
      
<%@ include file="footer.jspf"%>