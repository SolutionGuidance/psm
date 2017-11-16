<%--
 Copyright (C) 2012 TopCoder Inc., All Rights Reserved.

 @author TCSASSEMBLER
 @version 1.0

 The edit user account page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<c:set value="true" var="isUpdateUser"></c:set>
<c:set value="true" var="hasArrow"></c:set>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <c:choose>
    <c:when test="${not empty user.userId}">
      <c:set value="Edit User Account (System Admin)" var="title"></c:set>
    </c:when>
    <c:otherwise>
      <c:set value="Create New User Account (System Admin)" var="title"></c:set>
    </c:otherwise>
  </c:choose>
  <c:set value="true" var="systemPage"></c:set>
  <h:handlebars template="includes/html_head" context="${pageContext}" />

<%@ include file="/WEB-INF/pages/admin/includes/header.jsp" %>

<c:choose>
<c:when test="${not empty user.userId}">
<div class="breadCrumb">
    <a href="<c:url value='/system/user/list' />">User Accounts</a>
    <a href="<c:url value='/system/user/details?role=${role }&userId=${user.userId}' />">User Account Details</a>
    <span>Edit User Account</span>
</div>
</c:when>
<c:otherwise>
<div class="breadCrumb">
    <a href="<c:url value='/system/user/list' />">User Accounts</a>
    <span>Create New User Account</span>
</div>
</c:otherwise>
</c:choose>

<div class="head">
<c:choose>
<c:when test="${not empty user.userId}">
    <h1 class="text">Edit User Account</h1>
</c:when>
<c:otherwise>
    <h1 class="text">Create New User Account</h1>
</c:otherwise>
</c:choose>
</div>

<c:choose>
    <c:when test='${not empty user.userId}'><c:url value='/system/user/edit?roleName=${role }' var='updateURL' /></c:when>
    <c:otherwise><c:url value='/system/user/new?roleName=${role }' var='updateURL' /></c:otherwise>
</c:choose>
<div class="tabSection">
    <div class="detailPanel">
        <form:form commandName="user">
            <form:errors path="*" cssClass="error" ></form:errors>
        </form:form>
        <form:form cssClass="section" id="updateProfile" action="${updateURL }" modelAttribute="user">
            <input type="hidden" name="status" value="ACTIVE" />
            <form:hidden path="userId"/>
            <div class="wholeCol">
                <div class="row">
                    <label>Username</label>
                    <span class="floatL"><b>:</b></span>
                    <form:input cssClass="normalInput" path="username" />
                </div>
                <div class="row">
                    <label>Password</label>
                    <span class="floatL"><b>:</b></span>
                    <input type="password" class="passwordNormalInput" value="" name="password" />
                </div>
              <div class="row">
                <label>Confirm Password</label>
                  <span class="floatL"><b>:</b></span>
                  <input type="password" class="passwordNormalInput" value="" name="password2"/>
                </div>
                <div class="row">
                    <label>Last Name</label>
                    <span class="floatL"><b>:</b></span>
                    <form:input cssClass="normalInput" path="lastName" />
                </div>
                <div class="row">
                    <label>First Name</label>
                    <span class="floatL"><b>:</b></span>
                    <form:input cssClass="normalInput" path="firstName" />
                </div>
                <div class="row">
                    <label>Middle Name</label>
                    <span class="floatL"><b>:</b></span>
                    <form:input cssClass="normalInput" path="middleName" />
                </div>
                <div class="row">
                    <label>Email</label>
                    <span class="floatL"><b>:</b></span>
                    <form:input cssClass="normalInput" path="email" />
                </div>
                <div class="row">
                    <label>User Role</label>
                    <span class="floatL"><b>:</b></span>
                    <form:select cssClass="userRoleSelect" path="role.description">
                        <form:option value="" >Please Select</form:option>
                        <c:forEach items="${availableRoles }" var="r">
                            <form:option value="${r.description}" >${r.description}</form:option>
                        </c:forEach>
                    </form:select>
                </div>
            </div>
        </form:form>
        <!-- /.section -->
        <div class="tl"></div>
        <div class="tr"></div>
        <div class="bl"></div>
        <div class="br"></div>
    </div>
    <div class="buttonBox">
        <a href="<c:url value='/system/user/list' />" class="greyBtn"><span class="btR"><span class="btM">Cancel</span></span></a>
        <a href="javascript:;" class="purpleBtn editAccountSaveBtn"><span class="btR"><span class="btM">Save</span></span></a>
    </div>
    <!-- /.buttonBox -->
</div>

<%@ include file="/WEB-INF/pages/admin/includes/footer.jsp" %>
