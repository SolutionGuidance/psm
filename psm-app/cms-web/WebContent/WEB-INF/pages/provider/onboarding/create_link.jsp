<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <%@include file="/WEB-INF/pages/includes/html_head.jsp" %>
        <title>Link Account</title>
    </head>
    <body>
        <div id="wrapper">
            <%@include file="/WEB-INF/pages/includes/header.jsp" %>
            <!-- /#header -->

            <div id="mainContent" class="detailPage">
                <div class="contentWidth">
                    <div class="mainNav">
                        <%@include file="/WEB-INF/pages/includes/logo.jsp" %>
                        <%@include file="/WEB-INF/pages/includes/nav.jsp" %>
                    </div>
                    <!-- /.mainNav -->
                    <div class="breadCrumb">
                        <a href="<c:url value="/provider/dashboard/setup" />">Account Setup</a>
                        <span class="text">Account Details</span>
                    </div>
                    <div class="head">
                        <h1>Enter Account Details</h1>
                    </div>
                    
                    <div class="tabSection">
                        <form:form commandName="accountLink" id="accountLinkForm">
                            <spring:hasBindErrors name="accountLink">
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
                            <div id="updateProfile" class="section">
                                <div class="wholeCol">
                                    <div class="row">
                                        <label>System</label>
                                        <span class="floatL"><b>:</b></span>
                                        
                                        <c:set var="errorCls" value="" />
                                        <spring:bind path="systemId"><c:if test="${status.error}"><c:set var="errorCls" value="errorInput" /></c:if></spring:bind>
                                        <form:select path="systemId" cssClass="longSelect ${errorCls}">
                                            <form:option value="MN_ITS">MN-ITS</form:option>
                                        </form:select>
                                    </div>
                                    <div class="row">
                                        <label>Account Id</label>
                                        <span class="floatL"><b>:</b></span>
                                        
                                        <c:set var="errorCls" value="" />
                                        <spring:bind path="accountId"><c:if test="${status.error}"><c:set var="errorCls" value="errorInput" /></c:if></spring:bind>
                                        <form:input path="accountId" cssClass="normalInput ${errorCls}" />
                                    </div>
                                    <div class="row">
                                        <label>Password</label>
                                        <span class="floatL"><b>:</b></span>
                                        
                                        <c:set var="errorCls" value="" />
                                        <spring:bind path="password"><c:if test="${status.error}"><c:set var="errorCls" value="errorInput" /></c:if></spring:bind>
                                        <form:password path="password" cssClass="passwordNormalInput ${errorCls}" />
                                    </div>
                                </div>
		                        <div class="buttonBox">
		                            <a href="<c:url value="/provider/dashboard/setup" />" class="greyBtn"><span class="btR"><span class="btM">Cancel</span></span></a>
                                    <a href="javascript:submitFormById('accountLinkForm');" class="purpleBtn"><span class="btR"><span class="btM">Get Profiles</span></span></a>
		                        </div>
                            </div>
                            <!-- /.section -->
                            <div class="tl"></div>
                            <div class="tr"></div>
                            <div class="bl"></div>
                            <div class="br"></div>
                        </div>
                        </form:form>
                    </div>
                </div>
            </div>
            <!-- /#mainContent -->

            <%@include file="/WEB-INF/pages/includes/footer.jsp" %>
            <!-- #footer -->
        </div>
        <!-- /#wrapper -->
    </body>
</html>