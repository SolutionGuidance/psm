 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the help item details page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <c:set var="title" value="Help"/>
    <%@ include file="/WEB-INF/pages/admin/includes/html_head.jsp" %>
    <body>
        <div id="wrapper">
            <%@ include file="/WEB-INF/pages/includes/header.jsp" %>
            <div id="mainContent">
                <div class="contentWidth">
                    <div class="mainNav">
                        <%@include file="/WEB-INF/pages/includes/logo.jsp" %>
                        <%@include file="/WEB-INF/pages/includes/nav.jsp" %>
                    </div>
                    <div class="breadCrumb">
                        <a href="${ctx}/agent/enrollment/viewHelp">Help Topics</a>
                        <span>Help Content</span>
                    </div>
                    <div class="head">
                        <h1 class="text"><c:out value="${helpItem.title}"/></h1>
                    </div>
                    <div class="clearFixed"></div>
                    <div class="helpContent">
                        <c:out value="${helpItem.description}"/>
                    </div>
                    <!-- /.section -->
                </div>
            </div>
            <!-- /#mainContent -->

            <%@ include file="/WEB-INF/pages/includes/footer.jsp" %>
        </div>
        <!-- /#wrapper -->
    </body>
</html>