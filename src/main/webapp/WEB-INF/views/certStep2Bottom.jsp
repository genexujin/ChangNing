<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
      
      </div>
      <br>
      <br/>
	  <div class="row">
   		  <div class="span2 offset5">
   		    <button id="goToStep3" class="btn btn-large btn-block btn-info" type="submit">下一步</button>
   		  </div>    		  
      </div>
      
      </form>
      
      <script>
        function bindGoToStep3() {
        	$("#goToStep3").click(disableButtonAfterClick);
        }
        
        $(bindGoToStep3);
      </script>
      
<%@ include file="footer.jspf"%>