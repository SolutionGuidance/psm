<%--
  - Author: cyberjag
  - Version: 1.0
  - Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the cos service agent page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <c:set var="title" value="Category of Service"/>
    <%@ include file="/WEB-INF/pages/admin/includes/html_head.jsp" %>
    <body>
        <div id="wrapper">
            <%@ include file="/WEB-INF/pages/includes/header.jsp" %>

            <div id="mainContent" class="detailPage">
                <div class="contentWidth">
                    <div class="mainNav">
                        <%@include file="/WEB-INF/pages/includes/logo.jsp" %>
                        <c:set var="activeTab" value="1"></c:set>
                        <%@include file="/WEB-INF/pages/includes/nav.jsp" %>
                    </div>
                    <div class="breadCrumb">
                        <a href="${ctx}/ops/viewDashboard">Dashboard</a>
                        <span>Enrollment Category of Service</span>
                    </div>
                    <div class="head">
                        <h1>Category Of Service - ${enrollment.details.entity.providerType.description} - ${enrollment.details.entity.name}</h1>
                    </div>
                    <div class="tabSection">
						<c:set var="actionPath" value="${ctx}/agent/enrollment/addPendingCOS"/>
						<form action="${actionPath}" method="post" id="cosForm">
							<input type="hidden" name="id" value="${enrollment.ticketId}" />
							<div class="detailPanel">
								<c:forEach var="cos" items="${existingServices}" varStatus="loop">
								<div class="section">
									<div class="wholeCol">
										<div class="row">
											<label>Start Date</label>
											<span class="floatL"><b>:</b></span>
											<span><fmt:formatDate value="${cos.startDate}" pattern="MM/dd/yyyy"/></span>
										</div>
										<div class="row">
											<label>End Date</label>
											<span class="floatL"><b>:</b></span>
											<span id="edt-${cos.id}"><fmt:formatDate value="${cos.endDate}" pattern="MM/dd/yyyy"/></span>
										</div>
										<div class="row">
											<label>COS</label>
											<span class="floatL"><b>:</b></span>
											<span id="cats-${cos.id}">
												<c:forEach var="cat" items="${cos.categories}" varStatus="loop2">
													${cat.code}
													<c:if test="${!loop2.last}">, </c:if>
												</c:forEach>
											</span>
										</div>
										<div class="buttonBox">
											<c:if test="${loop.last}">
												<a href="javascript:;" onclick="copyCOS(${cos.id});" class="greyBtn"><span class="btR"><span class="btM"><span class="text">Clone</span></span></span></a>
											</c:if>
											<a href="javascript:;" onclick="deleteCOSByTicketId(${cos.id}, ${enrollment.ticketId});" class="greyBtn"><span class="btR"><span class="btM"><span class="text">Delete</span></span></span></a>
										</div>
									</div>
								</div>
								<!-- /.section -->
								<div class="clearFixed"></div>
								<div class="bottom-border">&nbsp;</div>
								</c:forEach>
								<div class="section">
									<input type="hidden" id="prevCosId" name="prevCosId" value="0" />
									<input type="hidden" id="prevCosEndDate" name="prevCosEndDate" value="" />
									<div class="wholeCol">
										<div class="row">
											<label>Start Date</label>
											<span class="floatL"><b>:</b></span>
											<span><input id="startDate" name="startDate" class="shortInput text mdate" value="" /></span>
										</div>
										<div class="row">
											<label>End Date</label>
											<span class="floatL"><b>:</b></span>
											<span><input id="endDate" name="endDate" class="shortInput text mdate" value="" /></span>
										</div>
										<div class="row">
											<label>COS</label>
											<span class="floatL"><b>:</b></span>
											<select id="cosSelect" name="cos" multiple="multiple" style="width:350px;" class="chzn-select">
												<c:forEach var="code" items="${codes}">
													<option value="${code.code}">${code.code}</option>
												</c:forEach>
											</select>
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
								<a href="${ctx}/provider/search/approved?statuses=Approved&showFilterPanel=true" class="greyBtn"><span class="btR"><span class="btM"><span class="text">Cancel</span></span></span></a>
								<a href="javascript:;" onclick="submitCosForm();" class="greyBtn"><span class="btR"><span class="btM"><span class="text">Save</span></span></span></a>
							</div>
						</form>
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