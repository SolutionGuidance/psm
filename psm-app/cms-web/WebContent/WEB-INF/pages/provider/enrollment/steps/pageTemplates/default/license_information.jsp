<%--
    JSP Fragment for provider type selection form.

    @author j3_guile
    @version 1.0
 --%>

<%@page import="gov.medicaid.binders.ProviderTypeFormBinder"%>
<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@taglib prefix="cms" uri="CMSTags"  %>
<c:set var="formIdPrefix" value="license_information"></c:set>

<c:set var="hideRenewalDate" value="${viewModel.tabModels['Personal Information'].formSettings['Personal Information Form'].settings['hideRenewalDate']}"></c:set>
<c:set var="hideLicenseNumber" value="${viewModel.tabModels['Personal Information'].formSettings['Personal Information Form'].settings['hideLicenseNumber']}"></c:set>

<div class="tableData" id="tableLicense">
    <input type="hidden" name="formNames" value="<%= ViewStatics.LICENSE_INFO_FORM %>">

    <table cellpadding="0" cellspacing="0" class="generalTable licenseInformationTable">
        <thead>
            <tr>
                <th class="alignCenter">#<span class="sep"></span></th>
                <th>Type of License/Certification<span class="required">*</span><span class="sep"></span></th>
                <th>Upload License/Certification <span class="required">*</span><span class="sep"></span></th>
                <c:choose>
                    <c:when test="${hideLicenseNumber}">
                        <th width="0"> </th>
                    </c:when>
                    <c:otherwise>
                        <th>License/Certification #<span class="required">*</span><span class="sep"></span></th>
                    </c:otherwise>
                </c:choose>

                <th>Original Issue Date<span class="required">*</span><span class="sep"></span></th>
                <c:choose>
                     <c:when test="${hideRenewalDate}">
                        <th width="0"> </th>
                        </c:when>
                        <c:otherwise>
                            <th>Renewal End Date<span class="required">*</span><span class="sep"></span></th>
                        </c:otherwise>
                </c:choose>
                <th>Issuing State<span class="required">*</span><span class="sep"></span></th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <c:set var="formName" value="_03_attachmentSize"></c:set>
            <c:forEach begin="1" end="${requestScope[formName]}" varStatus="status">
                <c:set var="disableRenewalDate" value="${false}"></c:set>
                <tr>
                    <td class="alignCenter">${status.count}</td>
                    <td>
                        <c:set var="formName" value="_03_licenseType_${status.index - 1}"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <select onchange="doIndividualLicenseSelect(this);" class="bigSelect" name="${formName}">
                            <option value="">Please select</option>
                            <c:forEach var="opt" items="${requestScope['_03_licenseTypes']}">
                                <option ${formValue eq opt.description ? 'selected' : ''} value="${opt.description}"><c:out value="${opt.description}" /></option>
                            </c:forEach>
                        </select>
                        <c:if test="${formValue eq 'PCA Training Certificate'}">
                            <c:set var="disableRenewalDate" value="${true}"></c:set>
                        </c:if>
                    </td>
                    <td>
                        <c:set var="formName" value="_03_attachment_${status.index - 1}"></c:set>
                        <input type="file" class="fileUpload" size="10" name="${formName}" />

                        <c:set var="formName" value="_03_filename_${status.index - 1}"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <c:if test="${not empty formValue}">
                            <c:set var="formName" value="_03_attachmentId_${status.index - 1}"></c:set>
                            <c:url var="downloadLink" value="/provider/enrollment/attachment">
                                 <c:param name="id" value="${requestScope[formName]}"></c:param>
                            </c:url>
                            <div><a href="${downloadLink}"><cms:truncate text="${formValue}" /></a></div>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input type="hidden" name="${formName}" value="${formValue}"/>
                        </c:if>
                    </td>
                    <c:choose>
                        <c:when test="${hideLicenseNumber}">
                            <td width="0"></td>
                        </c:when>
                        <c:otherwise>
                            <c:set var="formName" value="_03_licenseNumber_${status.index - 1}"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <td><input type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="45"/></td>
                        </c:otherwise>
                    </c:choose>

                    <td class="dateCell">
                        <span class="dateWrapper">
                            <c:set var="formName" value="_03_originalIssueDate_${status.index - 1}"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <input class="date" type="text" name="${formName}" value="${formValue}"/>
                        </span>
                    </td>
                    <c:choose>
                         <c:when test="${hideRenewalDate}">
                             <td width="0"></td>
                        </c:when>
                        <c:otherwise>
                            <td class="dateCell">
                                <span class="dateWrapper">
                                    <c:set var="formName" value="_03_renewalDate_${status.index - 1}"></c:set>
                                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                                    <input class="date ${disableRenewalDate ? 'disabled' : ''}" type="text" ${disableRenewalDate ? 'disabled="disabled"' : ''} name="${formName}" value="${formValue}"/>
                                </span>
                            </td>
                         </c:otherwise>
                      </c:choose>
                    <td>
                        <c:set var="formName" value="_03_issuingState_${status.index - 1}"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <select name="${formName}">
                            <option value="">Please select</option>
                            <c:forEach var="opt" items="${requestScope['_03_licenseStates']}">
                                <option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
                            </c:forEach>
                        </select>
                    </td>
                    <td class="alignCenter"><a href="javascript:;" class="remove">REMOVE</a></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <div class="clearFixed"></div>
    <div class="tableBottom">
        <a href="javascript:;" id="addLicense">+ Add Another License/Certification</a>
    </div>
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>
<!-- /.tableData -->
<div class="hide">
    <table class="hide" id="tableLicenseTemplate">
        <tbody>
            <tr>
                <td class="alignCenter">1</td>
                <td>
                    <c:set var="formName" value="_03_licenseType"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <select onchange="doIndividualLicenseSelect(this);" class="bigSelect" name="${formName}">
                        <option value="">Please select</option>
                        <c:forEach var="opt" items="${requestScope['_03_licenseTypes']}">
                            <option value="${opt.description}"><c:out value="${opt.description}" /></option>
                        </c:forEach>
                    </select>
                </td>
                <c:set var="formName" value="_03_attachment"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <td><input type="file" class="fileUpload" size="10" name="${formName}" /></td>
                <c:choose>
                        <c:when test="${hideLicenseNumber}">
                            <td width="0"></td>
                        </c:when>
                        <c:otherwise>
                            <c:set var="formName" value="_03_licenseNumber"></c:set>
                            <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                            <td><input type="text" class="normalInput" name="${formName}" value="${formValue}" maxlength="45"/></td>
                        </c:otherwise>
                </c:choose>
                <td class="dateCell">
                    <span class="dateWrapper">
                        <c:set var="formName" value="_03_originalIssueDate"></c:set>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input class="date" type="text" name="${formName}" value="${formValue}"/>
                    </span>
                </td>
                <c:choose>
                         <c:when test="${hideRenewalDate}">
                             <td width="0"></td>
                        </c:when>
                        <c:otherwise>
                            <td class="dateCell">
                                <span class="dateWrapper">
                                    <c:set var="formName" value="_03_renewalDate"></c:set>
                                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                                    <input class="date" type="text"  name="${formName}" value="${formValue}"/>
                                </span>
                            </td>
                        </c:otherwise>
                </c:choose>
                <td>
                    <c:set var="formName" value="_03_issuingState"></c:set>
                    <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                    <select name="${formName}">
                        <option value="">Please select</option>
                        <c:forEach var="opt" items="${requestScope['_03_licenseStates']}">
                            <option value="${opt.code}"><c:out value="${opt.description}" /></option>
                        </c:forEach>
                    </select>
                </td>
                <td class="alignCenter"><a href="javascript:;" class="remove">REMOVE</a></td>
            </tr>
        </tbody>
    </table>
</div>
