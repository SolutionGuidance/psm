<%--
    JSP Fragment for provider type selection form.

    @author j3_guile
    @version 1.0
 --%>

<%@page import="gov.medicaid.binders.ProviderTypeFormBinder"%>
<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="cms" uri="CMSTags"  %> 

<c:set var="showCategories" value="${viewModel.tabModels[viewModel.currentTab].formSettings['Facility License Form'].settings['showCategories']}"></c:set>
<input type="hidden" name="formNames" value="<%= ViewStatics.FACILITY_LICENSE_FORM %>">

<c:if test="${showCategories}">
    <div class="newEnrollmentPanel practicePanel memberInfoPanel">
        <div class="tableHeader topHeader"><span>Please select type of service(s) you provide</span></div>
        <div class="clearFixed"></div>
        <div class="section">
            <div class="">
                <div class="row">
                   <ul>
                        <c:set var="formName" value="_21_categorySize"></c:set>
                        <c:forEach begin="1" end="${requestScope[formName]}" varStatus="status">
                        <li>
                            <c:set var="formName" value="_21_category_${status.index - 1}"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <c:set var="checkedName" value="_21_category_selected_${status.index - 1}"></c:set>
                            <c:set var="checkedValue" value="${requestScope[checkedName]}"></c:set>
                            <input type="checkbox" name="_21_serviceCategory" ${checkedValue eq 'Y' ? 'checked' : ''} value="${formValue}"/> ${formValue}
                        </li>
                        </c:forEach>
                   </ul>
                </div>
                <div class="clearFixed"></div>
            </div>
        </div>
        <!-- /.section -->
        <div class="tl"></div>
        <div class="tr"></div>
        <div class="bl"></div>
        <div class="br"></div>
    </div>
</c:if>

<div class="newEnrollmentPanel practicePanel">
    <div class="section">
        <c:if test="${showCategories}">
            <div class="tableHeader topHeader"><span>Required Licenses/Certifications based on your service selection</span></div>
            <div class="clearFixed"></div>
        </c:if>
        <c:if test="${not showCategories}">
            <div class="tableHeader topHeader"><span>Facility Licenses/Certifications</span></div>
            <div class="clearFixed"></div>
        </c:if>
    
        <div class="addPracticeLocations">
            <table cellpadding="0" cellspacing="0" class="generalTable facility" id="tableFacilityLicense">
                <colgroup>
                    <col width="20"/>
                    <col width="130"/>
                    <col width="100"/>
                    <col width="100"/>
                    <col width="100"/>
                    <col width="100"/>
                    <col width="100"/>
                    <col width="30"/>
                </colgroup>
                <thead>
                <tr>
                    <th class="firstTheader">#<span class="sep"></span></th>
                    <th class="alignCenter"><span class="multi">Type of License<br/>/Certification</span><span class="required">*</span><span class="sep"></span></th>
                    <th class="alignCenter"><span class="multi">License/Certification</span><span class="required">*</span><span class="sep"></span></th>
                    <th class="alignCenter"><span class="multi">Original Issue Date<br/> (MM/DD/YYYY)</span><span class="required">*</span><span class="sep"></span></th>
                    <th class="alignCenter"><span class="multi">Renewal End Date<br/> (MM/DD/YYYY)</span><span class="required">*</span><span class="sep"></span></th>
                    <th class="alignCenter">Issuing State<span class="required">*</span><span class="sep"></span></th>
                    <th class="alignCenter"><span class="multi">Copy of License<br/>/Certification</span><span class="sep"></span></th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
            <c:set var="formName" value="_21_attachmentSize"></c:set>
            <c:forEach begin="1" end="${requestScope[formName]}" varStatus="status">
                <tr>
                    <td class="alignCenter">${status.count}</td>
                    <td>
                        <c:set var="formName" value="_21_licenseType_${status.index - 1}"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <select class="bigSelect medicareCheck" name="${formName}">
                            <option value="">Please select</option>
                            <c:forEach var="opt" items="${requestScope['_21_licenseTypes']}">
                                <option ${formValue eq opt.description ? 'selected' : ''} value="${opt.description}"><c:out value="${opt.description}" /></option>
                            </c:forEach>
                        </select>
                    </td>
                    <c:set var="formName" value="_21_licenseNumber_${status.index - 1}"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <td><input type="text" class="longInput" name="${formName}" value="${formValue}" maxlength="45"/></td>
                    <td class="dateCell">
                        <span class="dateWrapper">
                            <c:set var="formName" value="_21_originalIssueDate_${status.index - 1}"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input class="date" type="text" name="${formName}" value="${formValue}"/>
                        </span>
                    </td>
                    <td class="dateCell">
                        <span class="dateWrapper">
                            <c:set var="formName" value="_21_renewalDate_${status.index - 1}"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input class="date" type="text"  name="${formName}" value="${formValue}"/>
                        </span>
                    </td>
                    <td>
                        <c:set var="formName" value="_21_issuingState_${status.index - 1}"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <select name="${formName}" class="licenseStates">
                            <option value="">Please select</option>
                            <c:choose>
                                <c:when test="${formValue == 'MEDICARE'}">
                                    <option value="MEDICARE" selected="selected">Medicare</option>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="opt" items="${requestScope['_99_states']}">
                                        <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </select>
                    </td>
                    <td>
                        <c:set var="formName" value="_21_attachment_${status.index - 1}"></c:set>
                        <input type="file" class="fileUpload" size="10" name="${formName}" />
                        
                        <c:set var="formName" value="_21_filename_${status.index - 1}"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <c:if test="${not empty formValue}">
                            <c:set var="formName" value="_21_attachmentId_${status.index - 1}"></c:set>
                            <c:url var="downloadLink" value="/provider/enrollment/attachment">
                                 <c:param name="id" value="${requestScope[formName]}"></c:param>
                            </c:url>
                            <div><a href="${downloadLink}"><cms:truncate text="${formValue}" /></a></div>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input type="hidden" name="${formName}" value="${formValue}"/>
                        </c:if>
                    </td>
                    <td class="alignCenter"><a href="javascript:;" class="remove">REMOVE</a></td>
                </tr>
            </c:forEach>
                </tbody>
            </table>
            <div class="clearFixed"></div>
            <div class="tableBottom">
                <a href="javascript:;" id="addFacilityLicense">+ Add Another License</a>
            </div>
        </div>
    </div>
    <!-- /.section -->
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>
<!-- /.newEnrollmentPanel -->

<!-- /.tableData -->
<div class="hide">
    <table class="hide" id="tableLicenseTemplate">
        <tbody>
            <tr>
                <td class="alignCenter">1</td>
                <td>
                    <c:set var="formName" value="_21_licenseType"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <select class="bigSelect medicareCheck" name="${formName}">
                        <option value="">Please select</option>
                        <c:forEach var="opt" items="${requestScope['_21_licenseTypes']}">
                            <option value="${opt.description}"><c:out value="${opt.description}" /></option>
                        </c:forEach>
                    </select>
                </td>
                <c:set var="formName" value="_21_licenseNumber"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <td><input type="text" class="longInput" name="${formName}" value="${formValue}" maxlength="45"/></td>
                <td class="dateCell">
                    <span class="dateWrapper">
                        <c:set var="formName" value="_21_originalIssueDate"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input class="date" type="text" name="${formName}" value="${formValue}"/>
                    </span>
                </td>
                <td class="dateCell">
                    <span class="dateWrapper">
                        <c:set var="formName" value="_21_renewalDate"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input class="date" type="text"  name="${formName}" value="${formValue}"/>
                    </span>
                </td>
                <td>
                    <c:set var="formName" value="_21_issuingState"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <select name="${formName}" class="licenseStates">
                        <option value="">Please select</option>
                        <c:forEach var="opt" items="${requestScope['_99_states']}">
                            <option value="${opt.code}"><c:out value="${opt.description}" /></option>
                        </c:forEach>
                    </select>
                </td>
                <c:set var="formName" value="_21_attachment"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <td><input type="file" class="fileUpload" size="10" name="${formName}" /></td>
                <td class="alignCenter"><a href="javascript:;" class="remove">REMOVE</a></td>
            </tr>
        </tbody>
    </table>
</div>
