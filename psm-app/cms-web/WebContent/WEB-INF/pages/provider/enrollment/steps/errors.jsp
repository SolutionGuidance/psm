<%--
  Copyright 2018 The MITRE Corporation
  
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at
  
      http://www.apache.org/licenses/LICENSE-2.0
  
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<c:if test="${not empty requestScope['flash_error']}">
    <div class="errorInfo formErrorMarker" style="display: block;">
        <h3>Unable to process request because one or more values could not be recognized:</h3>
        <p class="bindingError"><c:out value="${requestScope['flash_error']}"></c:out></p>
        <div class="tl"></div>
        <div class="tr"></div>
        <div class="bl"></div>
        <div class="br"></div>
    </div>
</c:if>

<c:if test="${empty requestScope['flash_error']}">
	<c:if test="${not empty errors}">
	    <div class="errorInfo formErrorMarker" style="display: block;">
	        <h3>Please correct the following errors:</h3>
	        <c:forEach var="error" items="${errors}">
	            <p class="${error.fieldId}"><c:out value="${error.message}"></c:out></p>
	        </c:forEach>
	        <div class="tl"></div>
	        <div class="tr"></div>
	        <div class="bl"></div>
	        <div class="br"></div>
	    </div>
	</c:if>
</c:if>
