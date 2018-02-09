<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<div class="summaryPrint">
    <div class="tabContent" id="tabAgreement">
	    <div id="viewAgreementPanel">
		<div class="sideBorder">
		    <h3><c:out value="${agreementDocument.title}"/></h3>
		</div>
		<div class="newEnrollmentPanel">
		    <div class="section">
			<div class="wholeCol">
			    ${agreementDocument.text}
			</div>
		    </div>
		    <div class="bl"></div>
		    <div class="br"></div>
		</div>
	    </div>
	    <!-- /#viewAgreementPanel -->
	</div>
</div>