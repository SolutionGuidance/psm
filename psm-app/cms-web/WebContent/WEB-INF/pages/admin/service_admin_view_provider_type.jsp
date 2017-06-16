 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the admin provider types page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <c:set var="title" value="Functions (Service Admin)"/>
    <%@ include file="/WEB-INF/pages/admin/includes/html_head.jsp" %>
    <body>
        <div id="wrapper">
            <%@ include file="/WEB-INF/pages/includes/header.jsp" %>
            <div id="mainContent">
                <div class="contentWidth">
                    <div class="mainNav">
                        <%@include file="/WEB-INF/pages/includes/logo.jsp" %>
                        <c:set var="activeTab" value="4"></c:set>
                        <%@include file="/WEB-INF/pages/includes/nav.jsp" %>
                    </div>
                    <div class="breadCrumb">
                        Functions
                    </div>
                    <h1>Functions</h1>
                    <div class="tabSection functionTab" id="enrollmentSection">
                        <c:set var="functions_service_active_menu" value="providerTypes"/>
                        <%@ include file="/WEB-INF/pages/admin/includes/functions_service_nav.jsp" %>
                        <div class="tabContent" id="tabProviderTypes">
                            <div id="viewProviderPanel">
                                <div class="sideBorder">
                                    <h3>Provider Type Details</h3>
                                    <a href="${ctx}/admin/viewProviderTypes" class="greyBtn"><span class="btR"><span class="btM">Back</span></span></a>
                                    <c:choose>
                                        <c:when test="${providerType.canDelete}"><a href="javascript:;" rel="${providerType.code}" class="greyBtn deleteProviderTypesOnViewBtn"><span class="btR"><span class="btM">Delete</span></span></a></c:when>
                                        <c:otherwise>
                                            <a href="javascript:;"  style="text-decoration: none;color: gray;cursor: default;" class="greyBtn disabledBtn"><span class="btR"><span class="btM">Delete</span></span></a>
                                        </c:otherwise>
                                    </c:choose>  
                                    <a href="${ctx}/admin/beginEditProviderType?providerTypeId=${providerType.code}" class="purpleBtn editProviderLink"><span class="btR"><span class="btM">Edit</span></span></a>
                                </div>
                                <div class="newEnrollmentPanel">
                                    <div class="section">
                                        <div class="wholeCol">
                                            <label>Provider Type</label>
                                            <span class="floatL"><b>:</b></span>
                                            <span class="marginLeft10">${providerType.description}</span>
                                        </div>
                                        <div class="tableHeader"><span>Agreements and Addendums</span></div>
                                        <div class="wholeCol">
                                            	<div class="row">
                                                        <div class="col2">
                                                        	<c:forEach var="agreement" items="${agreements}">
                                                        		<div class="row">	
                                                                	<span>${agreement.title}</span>
                                                            	</div>
                                                        	</c:forEach>
                                                        </div>
                                                    </div>
                                                </div>
                                        </div>
                                    </div>
                                    <div class="bl"></div>
                                    <div class="br"></div>
                                </div>
                            </div>
                            <!--/ #viewProviderPanel -->
                        </div>
                    </div>
                </div>
            </div>
            <!-- /#mainContent -->

            <%@ include file="/WEB-INF/pages/includes/footer.jsp" %>
        </div>
        <!-- /#wrapper -->
        <!-- modal -->
        <div id="modalBackground"></div>
        <div id="modal">
            <div class="modal" id="deleteProviderTypesModal">
                <div class="modalHeader">
                    <div class="corner">
                        <div class="cornerR">
                            <div class="cornerM">
                                <a href="javascript:;" class="closeModal">CLOSE</a>
                                <h2>Delete Provider Type</h2>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.modalHeader -->
                <div class="modalBody">
                    <div class="corner">
                        <div class="cornerR">
                            <div class="cornerM">
                                <div class="container">
                                    <p class="modal_title">Are you sure you want to delete the selected provider type?</p>
                                    <div class="buttons">
                                        <a href="javascript:;" rel="${ctx}/admin/deleteProviderTypes?providerTypeIds=${providerType.code}" class="purpleBtn deleteOKBtn"><span class="btR"><span class="btM">Delete</span></span></a>
                                        <a href="javascript:;" class="greyBtn closeModal"><span class="btR"><span class="btM">Cancel</span></span></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.modalBody -->
                <div class="modalFooter">
                    <div class="corner">
                        <div class="cornerR">
                            <div class="cornerM">
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.modalFooter -->
            </div>
        </div>
    </body>
</html>