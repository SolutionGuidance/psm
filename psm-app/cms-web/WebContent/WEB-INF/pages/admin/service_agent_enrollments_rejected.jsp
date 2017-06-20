 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the enrollments rejected page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <c:set var="title" value="Enrollment"/>
    <%@ include file="/WEB-INF/pages/admin/includes/html_head.jsp" %>
    <body>
        <div id="wrapper">
            <%@ include file="/WEB-INF/pages/includes/header.jsp" %>
            <div id="mainContent">
                <div class="contentWidth">
                    <div class="mainNav">
                        <%@include file="/WEB-INF/pages/includes/logo.jsp" %>
                        <c:set var="activeTab" value="2"></c:set>
                        <%@include file="/WEB-INF/pages/includes/nav.jsp" %>
                    </div>
                    <!-- /.mainNav -->
                    <div class="breadCrumb">
                        Enrollments
                    </div>
                    <h1>Enrollments</h1>
                    <div class="tabSection" id="enrollmentSection">
                        <c:set var="active_enrollment_tab" value="rejected"/>
                        <c:set var="enrollmentSearchFormAction" value="${ctx}/provider/search/rejected?statuses=Rejected"/>
                        <c:set var="searchResult" value="${results}"/>
                        <c:set var="itemsName" value="Denied Enrollment${searchResult.total>1?'s':''}"/>
                        <%@ include file="/WEB-INF/pages/admin/includes/enrollment_tab_section.jsp" %>
                        <%@ include file="/WEB-INF/pages/admin/includes/enrollment_search_form.jsp" %>
                        <!-- /.tabHead -->
                        <div class="tabContent">
                            <div class="pagination">
                                <%@ include file="/WEB-INF/pages/admin/includes/page_left_navigation.jsp" %>
                                <%@ include file="/WEB-INF/pages/admin/includes/enrollment_buttons.jsp" %>
                            </div>
                            <%@ include file="/WEB-INF/pages/admin/includes/enrollment_search_filter_panel.jsp" %>
                            <c:choose>
                                <c:when test="${searchResult.total == 0}">
                                    <div class="tableWrapper">
                                        <div class="tableContainer"></div>                                    
                                        <div class="tabFoot">
                                            <div class="tabR">
                                                <div class="tabM red">
                                                    No matched data found.
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="tableWrapper">
                                        <div class="tableContainer">
                                            <%@ include file="/WEB-INF/pages/admin/includes/enrollment_search_result_table.jsp" %>
                                        </div>
                                        <!-- /.tableContainer -->
                                        <div class="tabFoot">
                                            <div class="tabR">
                                                <div class="tabM">
                                                    <%@ include file="/WEB-INF/pages/admin/includes/page_navigation.jsp" %>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /.tabFoot -->
                                    </div>
                                </c:otherwise>
                            </c:choose>
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