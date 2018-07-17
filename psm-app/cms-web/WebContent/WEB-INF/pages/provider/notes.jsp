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
	            <span class="sep"><b>:</b></span>
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

