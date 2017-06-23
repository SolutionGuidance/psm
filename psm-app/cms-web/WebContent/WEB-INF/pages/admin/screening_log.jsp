 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the approval page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <c:set var="title" value="Enrollment"/>
    <%@ include file="/WEB-INF/pages/admin/includes/html_head.jsp" %>
    <body>
        <div id="wrapper">
            <%@ include file="/WEB-INF/pages/includes/header.jsp" %>
            <div id="mainContent" class="detailPage">
                <div class="contentWidth">
                    <div class="mainNav">
                        <%@include file="/WEB-INF/pages/includes/logo.jsp" %>
                        <c:set var="activeTab" value="2"></c:set>
                        <%@include file="/WEB-INF/pages/includes/nav.jsp" %>
                    </div>
                    <!-- /.mainNav -->
                    <div class="breadCrumb">
                        Screening Log
                    </div>
                    <h1>External Source Screening Log</h1>
                    <div class="tabSection" id="enrollmentSection">
                    	<div class="detailPanel">
                    		<div class="section">
								<div class="wholeCol">
			                        <c:if test="${empty output}">
			                            No external screening was performed.
			                        </c:if>
			                        <c:if test="${not empty output}">
			                            <div class="row">
			                                <label>Status</label>
			                                <span class="floatL"><b>:</b></span>
			                                <span>SUCCESS</span>
			                            </div>
			                        
			                            <c:set var="recordsMatched" value="${false}"></c:set>
			                            <c:forEach var="record" items="${output.searchResultItem}">
			                                <hr />
			                                <c:forEach var="coldata" items="${record.columnData.nameValuePair}">
			                                    <c:set var="recordsMatched" value="${true}"></c:set>
										        <div class="row">
										            <label>${coldata.name}</label>
										            <span class="floatL"><b>:</b></span>
										            <span><c:out value="${coldata.value}"></c:out> </span>
										        </div>
			                                </c:forEach>
			                            </c:forEach>
			                            
			                            <c:if test="${not recordsMatched}">
			                            <div class="row">
			                                No records were matched. Please check the source manually.
			                            </div>
			                            </c:if>
			                        </c:if>
			                    </div>
			                </div>
			            </div>
                    </div>
                    <!-- /.tabSection -->
                </div>
            </div>
            <!-- /#mainContent -->
            <%@ include file="/WEB-INF/pages/includes/footer.jsp" %>
            <!-- #footer -->
        </div>
        <!-- /#wrapper -->
    </body>
</html>