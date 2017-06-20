<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <%@include file="/WEB-INF/pages/includes/html_head.jsp" %>
        <title>Forgot Password</title>
    </head>
    <body>
        <div id="wrapper">
            <div id="header">
                <div class="contentWidth">
                </div>
                <!-- /.contentWidth -->
            </div>
            <!-- /#header -->

            <div id="mainContent" class="detailPage">
                <div class="contentWidth">
                    <div class="mainNav">
                        <%@include file="/WEB-INF/pages/includes/logo.jsp" %>
                    </div>
                    <!-- /.mainNav -->
                    <div class="head">
                        <h1 class="text">Forgot Password</h1>
                    </div>
                    <%@include file="/WEB-INF/pages/includes/flash.jsp" %>

                    <div class="tabSection">
                        <form:form commandName="passwordForm" id="passwordForm">
                            <spring:hasBindErrors name="passwordForm">
                                <div class="errorInfo" style="display: block;">
                                    <h3>Please correct the following errors:</h3>
			                        <form:errors path="*"></form:errors>
                                    <div class="tl"></div>
                                    <div class="tr"></div>
                                    <div class="bl"></div>
                                    <div class="br"></div>
                                </div>
                            </spring:hasBindErrors>
                        <div class="detailPanel">
                            <div class="section" id="updateProfile">
                                <div class="wholeCol">
                                    <div class="row">
                                        <label>User Name<span class="required">*</span></label>
                                        <span class="floatL"><b>:</b></span>
                                        
                                        <c:set var="errorCls" value="" />
                                        <spring:bind path="username"><c:if test="${status.error}"><c:set var="errorCls" value="errorInput" /></c:if></spring:bind>
                                        <form:input path="username" cssClass="normalInput ${errorCls}" />
                                    </div>
                                    <div class="row">
                                        <label>Email<span class="required">*</span></label>
                                        <span class="floatL"><b>:</b></span>
                                        
                                        <c:set var="errorCls" value="" />
                                        <spring:bind path="email"><c:if test="${status.error}"><c:set var="errorCls" value="errorInput" /></c:if></spring:bind>
                                        <form:input path="email" cssClass="normalInput ${errorCls}" />
                                    </div>
                                </div>
                            </div>
                            <!-- /.section -->
                            <div class="tl"></div>
                            <div class="tr"></div>
                            <div class="bl"></div>
                            <div class="br"></div>
                        </div>
                        <div class="buttonBox">
                            <a href="<c:url value="/login" />" class="greyBtn"><span class="btR"><span class="btM">Cancel</span></span></a>
                            <a href="javascript:submitFormById('passwordForm');" class="purpleBtn"><span class="btR"><span class="btM">Reset Password</span></span></a>
                        </div>
                        <!-- /.buttonBox -->
                        </form:form>
                    </div>
                    <!-- /.tabSection -->
                </div>
            </div>
            <!-- /#mainContent -->

            <%@include file="/WEB-INF/pages/includes/footer.jsp" %>
        </div>
        <!-- /#wrapper -->
    </body>
</html>