<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<c:set var="specialtyTrigger" value="${viewModel.tabModels[viewModel.currentTab].formSettings['Highest Degree Form'].settings['specialtyTrigger']}"></c:set>
<c:set var="isActivated" value="${true}"></c:set>
<c:if test="${not empty specialtyTrigger}">
    <c:set var="isActivated" value="${false}"></c:set>
    <c:set var="formName" value="_09_attachmentSize"></c:set>
    <c:forEach begin="1" end="${requestScope[formName]}" varStatus="status">
        <c:set var="formName" value="_09_specialtyType_${status.index - 1}"></c:set>
        <c:if test="${requestScope[formName] eq specialtyTrigger}">
            <c:set var="isActivated" value="${true}"></c:set>
        </c:if>
    </c:forEach>
</c:if>
<input type="hidden" name="formNames" value="<%= ViewStatics.HIGHEST_DEGREE_FORM %>">
<div class="newEnrollmentPanel" style="display: ${isActivated ? 'block' : 'none'}">
    <c:if test="${not empty specialtyTrigger}">
        <input type="hidden" name="specialtyTrigger" value="${specialtyTrigger}">
    </c:if>
    <div class="section">
        <div class="wholeCol">
            <div class="row requireField">
                <c:set var="formName" value="_14_highestDegreeEarned"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="highestDegree_${formName}" >Highest Degree Earned<span class="required">*</span></label>
                <select id="highestDegree_${formName}" class="bigSelect" name="${formName}">
                    <option value="">Please select</option>
                    <c:forEach var="opt" items="${requestScope['_14_degreeTypes']}">
                        <option ${formValue eq opt.description ? 'selected' : ''} value="${opt.description}"><c:out value="${opt.description}" /></option>
                    </c:forEach>
                </select>
            </div>
            <div class="row requireField">
                <c:set var="formName" value="_14_degreeAwardDate"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="degreeAwardDate_${formName}">Degree Award Date<span class="required">*</span></label>
                <span class="dateWrapper floatL">
                    <input id="degreeAwardDate_${formName}" class="date" type="text" name="${formName}" value="${formValue}" maxlength="10"/>
                </span>
            </div>
            <div class="row">
                <c:set var="formName" value="_14_copyOfHighestDegree"></c:set>
                <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                <label for="copyOfDegree_${formName}">Copy of Highest Degree Earned</label>
                <span class="floatL">
                    <input
                      id="copyOfDegree_${formName}"
                      type="file"
                      class="fileUpload newEnrollmentPanelButton"
                      size="10"
                      name="${formName}"
                    />

                    <c:if test="${not empty formValue}">
                        <c:url var="downloadLink" value="/provider/enrollment/attachment">
                             <c:param name="id" value="${requestScope[formName]}"></c:param>
                        </c:url>
                        <div><a href="${downloadLink}">View</a></div>
                        <c:set var="formValue" value="${requestScope[formName]}"></c:set>
                        <input type="hidden" name="${formName}" value="${formValue}"/>
                    </c:if>
                </span>
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
<!-- /.newEnrollmentPanel -->
