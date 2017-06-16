 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the approval page.
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
                        Review Enrollment
                    </div>
                    <h1>Review ${model.enrollment.providerInformation.providerType} Enrollment Application</h1>
                    <div class="tabSection" id="enrollmentSection">
                        <%@include file="/WEB-INF/pages/provider/enrollment/steps/screening_errors.jsp" %>
                        <form action="${ctx}/agent/enrollment/approve" method="post" id="approvalForm">
                        
						<div class="newEnrollmentPanel practicePanel">
                            <div class="tableHeader topHeader"><span>Provider Information</span></div>
						    <div class="clearFixed"></div>
						    <div class="section">
	                        <input type="hidden" name="id" value="${id}" />
                            <table  class="generalTable">
                            <thead>
	                            <tr>
	                               <th>Field<span class="sep"></span></th>
	                               <th>Value<span class="sep"></span></th>
                                   <th>Auto Screening<span class="sep"></span></th>
	                               <th>Verified</th>
	                            </tr>
                            </thead>
                            <tbody>
                            	<tr>
                                   <td>NPI LOOKUP</td>
                                   <td>${model.enrollment.providerInformation.NPI}</td>
                                   <td><a href="${ctx}/agent/enrollment/autoScreeningResult?type=NPI LOOKUP&id=${id}" target="_blank">View</a></td>
                                   <td><input type="checkbox" name="npiLookupVerified" value="Y" ${verification.NPILookup eq 'Y' ? 'checked' : ''} /></td>
                                </tr>
                                <tr>
                                   <td>SSN DMF VERIFICATION</td>
                                   <td>${model.enrollment.providerInformation.applicantInformation.personalInformation.socialSecurityNumber}</td>
                                   <td><a href="${ctx}/agent/enrollment/autoScreeningResult?type=SSN DMF VERIFICATION&id=${id}" target="_blank">View</a></td>
                                   <td><input type="checkbox" name="ssnVerified" value="Y" ${verification.socialSecurityNumber eq 'Y' ? 'checked' : ''} /></td>
                                </tr>
                                <tr>
                                   <td>NPI PECOS VERIFICATION</td>
                                   <td>${model.enrollment.providerInformation.NPI}</td>
                                   <td><a href="${ctx}/agent/enrollment/autoScreeningResult?type=NPI PECOS VERIFICATION&id=${id}" target="_blank">View</a></td>
                                   <td><input type="checkbox" name="npiVerified" value="Y" ${verification.NPI eq 'Y' ? 'checked' : ''} /></td>
                                </tr>
                                <c:if test="${not empty model.enrollment.providerInformation.agencyInformation.backgroundStudyId}">
	                                <tr>
	                                   <td>NET STUDY ID VERIFICATION</td>
	                                   <td>${model.enrollment.providerInformation.agencyInformation.backgroundStudyId}</td>
                                       <td><a href="${ctx}/agent/enrollment/autoScreeningResult?type=NET STUDY ID VERIFICATION&id=${id}" target="_blank">View Log</a></td>
                                       <td><input type="checkbox" name="bgsVerified" value="Y" ${verification.netStudy eq 'Y' ? 'checked' : ''} /></td>
	                                </tr>
                                </c:if>
                                <tr>
                                   <td>EXCLUDED PROVIDER VERIFICATION IN OIG (checked means not in exclusion list)</td>
                                   <td></td>
                                   <td><a href="${ctx}/agent/enrollment/autoScreeningResult?type=EXCLUDED PROVIDERS&id=${id}" target="_blank">View</a></td>
                                   <td><input type="checkbox" name="nonExclusionVerified" value="Y" ${verification.nonExclusion eq 'Y' ? 'checked' : ''} /></td>
                                </tr>
                                <tr>
                                   <td>EXCLUDED PROVIDER VERIFICATION IN SAM (checked means not in exclusion list)</td>
                                   <td></td>
                                   <td><a href="${ctx}/agent/enrollment/autoScreeningResult?type=SAM EXCLUDED PROVIDERS&id=${id}" target="_blank">View</a></td>
                                   <td><input type="checkbox" name="nonSAMExclusionVerified" value="Y" ${verification.SAMNonExclusion eq 'Y' ? 'checked' : ''} /></td>
                                </tr>
                            </tbody>
                            </table>
                            
                            <div class="tableHeader"><span>License Information</span></div>
                            <div class="clearFixed"></div>
                            <table class="generalTable">
                            <thead>
                                <tr>
                                   <th>Type<span class="sep"></span></th>
                                   <th>Number<span class="sep"></span></th>
                                   <th>Auto Screening<span class="sep"></span></th>
                                   <th>Verified</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="license" items="${model.enrollment.providerInformation.licenseInformation.license}">
                                <tr>
                                   <td>${license.licenseType}${license.specialtyType}</td>
                                   <td>${license.licenseNumber}
                                    
                                    <c:url var="downloadLink" value="/provider/enrollment/attachment">
                                        <c:param name="id" value="${license.attachmentObjectId}"></c:param>
                                    </c:url>
                                    <a href="${downloadLink}">View</a>
                                   
                                   </td>
                                   <td><a href="${ctx}/agent/enrollment/autoScreeningResult?type=LICENSE VERIFICATION&id=${id}&licenseId=${license.objectId}" target="_blank">View Log</a></td>
                                   <td><input type="checkbox" name="verifiedLicenses" value="${license.attachmentObjectId}" ${license.verified eq 'Y' ? 'checked' : ''} /></td>
                                </tr>
                                </c:forEach>
                            </tbody>
                            </table>
	                        <div class="row"></div>
                        </div>
                        
                        <div class="clear"></div>
                        
					    <div class="tl"></div>
					    <div class="tr"></div>
					    <div class="bl"></div>
					    <div class="br"></div>
                        
                        </div>
                        <div class="buttonBox">
                            <a href="${ctx}/provider/search/pending?statuses=Pending&showFilterPanel=true" class="greyBtn"><span class="btR"><span class="btM"><span class="text">Cancel</span></span></span></a>
                            <a href="javascript:;" onclick="submitFormById('approvalForm');" class="greyBtn"><span class="btR"><span class="btM"><span class="text">Approve</span></span></span></a>
                            <a href="${ctx}/agent/enrollment/rejectTicket?id=${id}" class="greyBtn"><span class="btR"><span class="btM"><span class="text">Reject</span></span></span></a>
                            <a href="${ctx}/provider/enrollment/reopen?id=${id}" class="greyBtn"><span class="btR"><span class="btM"><span class="text">Modify</span></span></span></a>
                        </div>
                        </form>
                    </div>
                </div>
            </div>
            <!-- /#mainContent -->
            <%@ include file="/WEB-INF/pages/includes/footer.jsp" %>
            <!-- #footer -->
        </div>
        <!-- /#wrapper -->
    </body>
</html>