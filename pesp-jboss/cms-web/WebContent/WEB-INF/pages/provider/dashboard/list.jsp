<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <%@include file="/WEB-INF/pages/includes/html_head.jsp" %>
        <title>Dashboard</title>
    </head>
    <body>
        <div id="wrapper">
            <%@include file="/WEB-INF/pages/includes/header.jsp" %>
            <!-- /#header -->

            <div id="mainContent">
                <div class="contentWidth">
                    <div class="mainNav">
                        <a class="logo" href="javascript:;"><img src="<c:url value="/i/logo.gif" />" alt="Medicaid Provider"/></a>
                        <c:set var="activeTab" value="1" />
                        <%@include file="/WEB-INF/pages/includes/nav.jsp" %>
                    </div>
                    <!-- /.mainNav -->
                    <div class="breadCrumb">
                        Dashboard
                    </div>
                    <h1>Dashboard</h1>
                    <div class="tabContent contentT">
                            <c:set var="paginatedResults" value="${results}" />
                            <div class="tableHeader tableHeader2">
                                <a class="purpleBtn purpleBtnR" href="<c:url value="/provider/enrollment/start" />"><span class="btR"><span class="btM">Create New Enrollment</span></span></a>
                                <span>Latest Activities</span>
                            </div>
                            <div class="tl"></div>
                            <div class="tr"></div>

                            <div class="pagination">
                                <div class="left">
                                    <%@include file="/WEB-INF/pages/includes/pagination_details.jsp" %>
                                </div>
                                <div class="right">
                                    <a href="javascript:;" class="blueBtn filterBtn ${param.filterViewState eq 'visible' ? 'hideFilter' : 'showFilter'}">
                                    <span class="btR"><span class="btM"><span class="text">${param.filterViewState eq 'visible' ? 'Hide Filter' : 'Filter'}</span><span class="arrow"></span></span></span></a>
                                </div>
                            </div>
                            <!-- /.pagination -->
                            
                            <%@include file="dashboard_filter.jsp" %>                            
                            <!-- /.filterPanel -->
                            
                            <div class="tableContainer">
                                <%@include file="dashboard_table.jsp" %>
                            </div>
                            <!-- /.tableContainer -->
                            
                            <div class="tabFoot">
                                <div class="tabR">
                                    <div class="tabM">
                                        <div class="pagination">
                                            <div class="left">
                                                <%@include file="/WEB-INF/pages/includes/pagination_details.jsp" %>
                                            </div>
                                            <div class="right">
                                                <%@include file="/WEB-INF/pages/includes/pagination_links.jsp" %>
                                            </div>
                                        </div>
                                        <!-- /.pagination -->
                                    </div>
                                </div>
                            </div>
                            <!-- /.tabFoot -->
                        </div>
                        <!-- /#tabApproved -->
                        <div class="row infoRow">
                            <div class="row red">
                                <b>* High risk level means:</b>
                            </div>
                            <p>
                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
                            </p>
                        </div>
                </div>
            </div>
            <!-- /#mainContent -->

            <%@include file="/WEB-INF/pages/includes/footer.jsp" %>
            <!-- #footer -->
            <div class="clear"></div>
        </div>
        <!-- /#wrapper -->
        <!-- /#modalBackground-->
        <div id="modalBackground"></div>
        <div id="new-modal">

        <%@include file="/WEB-INF/pages/provider/enrollment/steps/modal/print_modal.jsp" %>
        
        </div>
    </body>
</html>