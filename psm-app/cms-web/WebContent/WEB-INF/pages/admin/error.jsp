
<%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the error page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<c:set var="title" value="Error" />
<%@ include file="/WEB-INF/pages/admin/includes/html_head.jsp"%>
<body>
    <div id="wrapper">
        <%@ include file="/WEB-INF/pages/includes/header.jsp"%>
        <div id="mainContent" class="detailPage">
            <div class="contentWidth">
                <c:set var="active_menu" value="dashboard" />
                <%@ include file="/WEB-INF/pages/includes/nav.jsp"%>
                <div class="head">
                    <h1>Error</h1>
                </div>
                <div class="clearFixed"></div>
                <div class="dashboardPanel">
                    <p style="color: red">This is a generic error page. If you are seeing this, the PSM controller
                        experienced an error while processing this request. The detailed error message will be present
                        in the log files for debugging purposes.</p>
                </div>
            </div>
        </div>
        <!-- /#mainContent -->

        <%@ include file="/WEB-INF/pages/includes/footer.jsp"%>
    </div>
    <!-- /#wrapper -->
</body>
</html>
