 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the my profile page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <c:set var="title" value="My Profile (Service Admin)"/>
    <%@ include file="/WEB-INF/pages/admin/includes/html_head.jsp" %>
	<body>
		<div id="wrapper">
			<%@ include file="/WEB-INF/pages/includes/header.jsp" %>

			<div id="mainContent">
				<div class="contentWidth">
                    <div class="mainNav">
                        <%@include file="/WEB-INF/pages/includes/logo.jsp" %>
                        <c:set var="activeTab" value="3"></c:set>
                        <%@include file="/WEB-INF/pages/includes/nav.jsp" %>
                    </div>
					<div class="breadCrumb">
						<span>My Profile</span>
					</div>
					<div class="head">
						<h1 class="text">My Profile</h1>
                        <a href="${ctx}/ops/beginEditUser" class="purpleBtn"><span class="btR"><span class="btM">Update Profile</span></span></a>
					</div>
					<div class="tabSection" id="myProfile">
						<div class="detailPanel">
							<div class="section">
								<div class="wholeCol">
                                    <div class="row">
                                        <label>User Name</label>
                                        <span class="floatL"><b>:</b></span>
                                        <span><c:out value="${user.username}"/></span>
                                    </div>
                                	<div class="row">
                                        <label>Last Name</label>
                                        <span class="floatL"><b>:</b></span>
                                        <span><c:out value="${user.lastName}"/></span>
                                    </div>
                                    <div class="row">
                                        <label>First Name</label>
                                        <span class="floatL"><b>:</b></span>
                                        <span><c:out value="${user.firstName}"/></span>
                                    </div>
                                    <div class="row">
                                        <label>Middle Name</label>
                                        <span class="floatL"><b>:</b></span>
                                        <span><c:out value="${user.middleName}"/></span>
                                    </div>
                                    <div class="row">
                                        <label>Business Phone</label>
                                        <span class="floatL"><b>:</b></span>
                                        <span><c:out value="${user.businessPhonePart1}"/> - <c:out value="${user.businessPhonePart2}"/> - <c:out value="${user.businessPhonePart3}"/> <b>ext.</b> <c:out value="${user.businessPhoneExt}"/></span>
                                    </div>
                                    <div class="row">
                                        <label>Email</label>
                                        <span class="floatL"><b>:</b></span>
                                        <span><c:out value="${user.email}"/></span>
                                    </div>
								</div>
							</div>
							<!-- /.section -->
							<div class="tl"></div>
							<div class="tr"></div>
							<div class="bl"></div>
							<div class="br"></div>
						</div>
					</div>
					<!-- /.tabSection -->
				</div>
			</div>
			<!-- /#mainContent -->

			<%@ include file="/WEB-INF/pages/includes/footer.jsp" %>
		</div>
		<!-- /#wrapper -->
	</body>
</html>