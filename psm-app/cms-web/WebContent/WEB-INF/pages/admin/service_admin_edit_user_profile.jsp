 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the edit user profile page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <c:set var="title" value="Update Profile (Service Admin)"/>
    <%@ include file="/WEB-INF/pages/admin/includes/html_head.jsp" %>
    <body>
        <div id="wrapper">
            <%@ include file="/WEB-INF/pages/includes/header.jsp" %>
            <div id="mainContent" class="detailPage">
                <div class="contentWidth">
                    <div class="mainNav">
                        <%@include file="/WEB-INF/pages/includes/logo.jsp" %>
                        <c:set var="activeTab" value="3"></c:set>
                        <%@include file="/WEB-INF/pages/includes/nav.jsp" %>
                    </div>
                    <!-- /.mainNav -->
                    <div class="breadCrumb">
                        <a href="${ctx}/ops/getUser">My Profile</a>
                        <span>Update Profile</span>
                    </div>
                    <div class="head">
                        <h1 class="text">Update Profile</h1>
                    </div>
                    <div class="tabSection">
                        <form:form id="userForm" action="${ctx}/ops/updateUser" modelAttribute="user" method="post">
                            <div class="detailPanel">
                                <form:hidden path="userId" />
                                <div class="section" id="updateProfile">
                                    <div class="wholeCol">
                                        <div class="row">
                                            <label>User Name</label>
                                            <span class="floatL"><b>:</b></span>
                                            <form:hidden path="username" />
                                            <span><c:out value="${user.username}"/></span>
                                        </div>
                                        <div class="row">
                                            <label>Last Name</label>
                                            <span class="floatL"><b>:</b></span>
                                            <form:input path="lastName" cssClass="normalInput"/>
                                        </div>
                                        <div class="row">
                                            <label>First Name</label>
                                            <span class="floatL"><b>:</b></span>
                                            <form:input path="firstName" cssClass="normalInput"/>
                                        </div>
                                        <div class="row">
                                            <label>Middle Name</label>
                                            <span class="floatL"><b>:</b></span>
                                            <form:input path="middleName" cssClass="normalInput"/>
                                            <em class="grey">(optional)</em>
                                        </div>
                                        <div class="row">
                                            <label>Business Phone</label>
                                            <span class="floatL"><b>:</b></span>
                                            <form:input path="businessPhonePart1" cssClass="smallInput"/>
                                            <span class="sep">-</span>
                                            <form:input path="businessPhonePart2" cssClass="smallInput"/>
                                            <span class="sep">-</span>
                                            <form:input path="businessPhonePart3" cssClass="smallInputP"/>
                                            <span class="sep"><strong>ext.</strong></span>
                                            <form:input id="businessPhoneExt" path="businessPhoneExt" cssClass="smallInput"/>
                                        </div>
                                        <div class="row">
                                            <label>Email</label>
                                            <span class="floatL"><b>:</b></span>
                                            <form:input path="email" cssClass="normalInput"/>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.section -->
                                <div class="tl"></div>
                                <div class="tr"></div>
                                <div class="bl"></div>
                                <div class="br"></div>
                            </div>
                        </form:form>
                        <div class="buttonBox">
                            <a href="${ctx}/ops/getUser" class="greyBtn"><span class="btR"><span class="btM">Cancel</span></span></a>
                            <a id="saveUserBtn" href="javascript:;" class="purpleBtn"><span class="btR"><span class="btM">Save</span></span></a>
                        </div>
                        <!-- /.buttonBox -->
                    </div>
                    <!-- /.tabSection -->
                </div>
            </div>
            <!-- /#mainContent -->

            <%@include file="/WEB-INF/pages/includes/footer.jsp" %>

            <!-- #footer -->
        </div>
        <!-- /#wrapper -->
    </body>
</html>