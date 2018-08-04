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
<%@taglib prefix="cms" uri="CMSTags"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<div class="notesContainer">
	<c:forEach var="note" items="${profileNotes}">
	    <div class="notePanel">
	        <div class="noteText">
	            <c:out value="${note.text}" />
	        </div>
	        <div class="noteMeta">
	            <label>Added By</label>
	            <span class="author"><b><cms:fullname userId="${note.createdBy}" /></b></span> on <span class="timestamp"><c:out value="${note.createdOn}" /></span>
	        </div>
	        <div class="clear"></div>
		    <div class="tl"></div>
		    <div class="tr"></div>
		    <div class="bl"></div>
		    <div class="br"></div>
	    </div>
	</c:forEach>
</div>

<div class="noteInputPanel">
    <div class="noteForm">
        <label for="newNoteFied">Write a note</label> <span class="required">*</span> <span>:</span>
        <div class="clear"></div>
        <textarea id="newNoteField" name="noteText" rows="5" cols="50"><c:out value="${param['noteText']}" /></textarea>
    </div>
</div>
