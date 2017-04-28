<%--
    JSP Fragment for assurance statement form.

    @author cyberjag
    @version 1.0
 --%>

<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<input type="hidden" name="formNames" value="<%= ViewStatics.CHEMICAL_DEPENDENCY_SERVICE_ASSURANCE_FORM %>">
<div class="newEnrollmentPanel practicePanel memberInfoPanel">
    <div class="tableHeader topHeader"><span>CCDTF Residential/Inpatient Assurance</span></div>
    <div class="clearFixed"></div>
    <div class="section">
        <div>
        	<div  id="inServiceTable">
				<c:set var="formName" value="_41_inServiceSize"></c:set>
				<c:forEach begin="1" end="${requestScope[formName]}" varStatus="status">
					<div class="row in-services">
						<div class="wholeCol assuredServicePanel">
							<div class="row">
								<label>Service Track<span class="required">*</span></label>
								<span class="floatL"><b>:</b></span>
								<c:set var="formName" value="_41_inServiceType_${status.index - 1}"></c:set>
								<c:set var="formValue" value="${requestScope[formName]}"></c:set>
								<select onchange="doInServiceSelect(this);" class="bigSelect" name="${formName}">
									<option value="">Please select</option>
									<c:forEach var="opt" items="${requestScope['_41_availableInServices']}">
										<option ${formValue eq opt.code ? 'selected' : ''} value="${opt.code}"><c:out value="${opt.description}" /></option>
									</c:forEach>
								</select>
							</div>
							<div class="row">
								<c:forEach var="opt" items="${requestScope['_41_availableInServices']}">
									<c:set var="formName" value="_41_availableInServices_${opt.code}_${status.index - 1}"></c:set>
									<c:set var="formValue" value="${requestScope[formName]}"></c:set>
									<c:set var="key" value="_41_availableInServices_${opt.code}"></c:set>
									<c:set var="parentName" value="_41_inServiceType_${status.index - 1}"></c:set>
									<c:set var="parentValue" value="${requestScope[parentName]}"></c:set>
									<div class="${parentValue eq opt.code ? '' : 'hide'} ext-services ext-services-${opt.code}">
									<ul>
										<c:forEach var="exTyp" items="${requestScope[key]}" varStatus="inStatus">
											<c:set var="formName" value="_41_availableInServices_${opt.code}_${inStatus.index}"></c:set>
											<li class='no-width'>
												<input type="checkbox" ${formValue eq exTyp.code ? 'checked="checked"' : ''} value="${exTyp.code}" name="${formName}"/> ${exTyp.description}
											</li>
										</c:forEach>
									</ul>
									</div>
								</c:forEach>
							</div>
							<div class="row">
								<label>&nbsp;</label>
								<span class="floatL"><b>&nbsp;</b></span>
								<c:set var="formName" value="_41_inServiceTypeStatus_${status.index - 1}"></c:set>
								<c:set var="formValue" value="${requestScope[formName]}"></c:set>
								<label class="inline"><input type="radio" value="1" name="${formName}" ${formValue eq '1' ? 'checked' : ''}>Initiate New</label>
								<label class="inline"><input type="radio" value="2" name="${formName}" ${formValue eq '2' ? 'checked' : ''}>Continue Current</label>
								<label class="inline"><input type="radio" value="3" name="${formName}" ${formValue eq '3' ? 'checked' : ''}>Terminate</label>
							</div>
							<div class="row">
								<label>Effective Date<span class="required">*</span></label>
								<span class="floatL"><b>:</b></span>
								<span class="dateWrapper">
									<c:set var="formName" value="_41_inServiceEffDt_${status.index - 1}"></c:set>
									<c:set var="formValue" value="${requestScope[formName]}"></c:set>
									<input class="date" type="text"  name="${formName}" value="${formValue}"/>
								</span>
							</div>
							<div class="row">
								<a href="javascript:;" class="remove">REMOVE</a>
							</div>
							<div class="clearFixed"></div>
						</div>
					</div>
				<div class="clearFixed"></div>
				</c:forEach>
            </div>
            <div class="tableBottom">
		        <a href="javascript:;" id="addInService">+ Add Another Service</a>
		    </div>
        </div>
    </div>
    <!-- /.section -->
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>

<div class="newEnrollmentPanel practicePanel memberInfoPanel">
    <div class="tableHeader topHeader"><span>CCDTF Outpatient Services Assurance</span></div>
    <div class="clearFixed"></div>
    <div class="section">
        <div>
            <div  id="outServiceTable">
				<c:set var="formName" value="_41_outServiceSize"></c:set>
				<c:forEach begin="1" end="${requestScope[formName]}" varStatus="status">
					<div class="row out-services">
						<div class="wholeCol assuredServicePanel">
							<div class="row">
								<label>Service Track<span class="required">*</span></label>
								<span class="floatL"><b>:</b></span>
								<c:set var="formName" value="_41_outServiceType_${status.index - 1}"></c:set>
								<c:set var="formValue" value="${requestScope[formName]}"></c:set>
								<select onchange="doOutServiceSelect(this);" class="bigSelect" name="${formName}">
									<option value="">Please select</option>
									<c:forEach var="opt" items="${requestScope['_41_availableOutServices']}">
										<option value="${opt.code}"><c:out value="${opt.description}" /></option>
									</c:forEach>
								</select>
							</div>
							<div class="row">
								<c:forEach var="opt" items="${requestScope['_41_availableOutServices']}">
									<c:set var="formName" value="_41_availableOutServices_${opt.code}_${status.index - 1}"></c:set>
									<c:set var="formValue" value="${requestScope[formName]}"></c:set>
									<c:set var="key" value="_41_availableOutServices_${opt.code}"></c:set>
									<c:set var="parentName" value="_41_outServiceType_${status.index - 1}"></c:set>
									<c:set var="parentValue" value="${requestScope[parentName]}"></c:set>
									<div class="${parentValue eq opt.code ? '' : 'hide'} ext-services ext-services-${opt.code}">
									<ul>
										<c:forEach var="exTyp" items="${requestScope[key]}" varStatus="inStatus">
											<c:set var="formName" value="_41_availableOutServices_${opt.code}_${inStatus.index}"></c:set>
											<li class='no-width'>
												<input type="checkbox" ${formValue eq exTyp.code ? 'checked="checked"' : ''} value="${exTyp.code}" name="${formName}"/> ${exTyp.description}
											</li>
										</c:forEach>
									</ul>
									</div>
								</c:forEach>
							</div>
							<div class="row">
								<label>&nbsp;</label>
								<span class="floatL"><b>&nbsp;</b></span>
								<c:set var="formName" value="_41_outServiceTypeStatus_${status.index - 1}"></c:set>
								<c:set var="formValue" value="${requestScope[formName]}"></c:set>
								<label class="inline"><input type="radio" value="1" name="${formName}" ${formValue eq '1' ? 'checked' : ''}>Initiate New</label>
								<label class="inline"><input type="radio" value="2" name="${formName}" ${formValue eq '2' ? 'checked' : ''}>Continue Current</label>
								<label class="inline"><input type="radio" value="3" name="${formName}" ${formValue eq '3' ? 'checked' : ''}>Terminate</label>
							</div>
							<div class="row">
								<label>Effective Date<span class="required">*</span></label>
								<span class="floatL"><b>:</b></span>
								<span class="dateWrapper">
									<c:set var="formName" value="_41_outServiceEffDt_${status.index - 1}"></c:set>
									<c:set var="formValue" value="${requestScope[formName]}"></c:set>
									<input class="date" type="text"  name="${formName}" value="${formValue}"/>
								</span>
							</div>
							<div class="row">
								<a href="javascript:;" class="remove">REMOVE</a>
							</div>
							<div class="clearFixed"></div>
						</div>
					</div>
				</c:forEach>
            </div>
            <div class="tableBottom">
        		<a href="javascript:;" id="addOutService">+ Add Another Service</a>
		    </div>
        </div>
    </div>
    <!-- /.section -->
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>

<div class="hide">
	<div id="tableInServiceTemplate" class="hide">
		<div class="row in-services">
			<div class="wholeCol assuredServicePanel">
				<div class="row">
					<label>Service Track<span class="required">*</span></label>
					<span class="floatL"><b>:</b></span>
					<c:set var="formName" value="_41_inServiceType"></c:set>
					<c:set var="formValue" value="${requestScope[formName]}"></c:set>
					<select onchange="doInServiceSelect(this);" class="bigSelect" name="${formName}">
						<option value="">Please select</option>
						<c:forEach var="opt" items="${requestScope['_41_availableInServices']}">
							<option value="${opt.code}"><c:out value="${opt.description}" /></option>
						</c:forEach>
					</select>
				</div>
				<div class="row">
					<c:forEach var="opt" items="${requestScope['_41_availableInServices']}">
						<c:set var="formName" value="_41_availableInServices_${opt.code}"></c:set>
						<div class="hide ext-services ext-services-${opt.code}">
						<ul>
							<c:forEach var="exTyp" items="${requestScope[formName]}">
							<li class='no-width'>
								<input type="checkbox" value="${exTyp.code}" name="${formName}_1"/> ${exTyp.description}
							</li>
							</c:forEach>
						</ul>
						</div>
					</c:forEach>
				</div>
				<div class="row">
					<label>&nbsp;</label>
					<span class="floatL"><b>&nbsp;</b></span>
					<c:set var="formName" value="_41_inServiceTypeStatus"></c:set>
					<c:set var="formValue" value="${requestScope[formName]}"></c:set>
					<label class="inline"><input type="radio" value="1" name="${formName}" ${formValue eq '1' ? 'checked' : ''}>Initiate New</label>
					<label class="inline"><input type="radio" value="2" name="${formName}" ${formValue eq '2' ? 'checked' : ''}>Continue Current</label>
					<label class="inline"><input type="radio" value="3" name="${formName}" ${formValue eq '3' ? 'checked' : ''}>Terminate</label>
				</div>
				<div class="row">
					<label>Effective Date<span class="required">*</span></label>
					<span class="floatL"><b>:</b></span>
					<span class="dateWrapper">
						<c:set var="formName" value="_41_inServiceEffDt"></c:set>
						<c:set var="formValue" value="${requestScope[formName]}"></c:set>
						<input class="date" type="text"  name="${formName}" value="${formValue}"/>
					</span>
				</div>
				<div class="row">
					<a href="javascript:;" class="remove">REMOVE</a>
				</div>
				<div class="clearFixed"></div>
			</div>
		</div>
	</div>
	<div id="tableOutServiceTemplate" class="hide">
		<div class="row out-services">
			<div class="wholeCol assuredServicePanel">
				<div class="row">
					<label>Service Track<span class="required">*</span></label>
					<span class="floatL"><b>:</b></span>
					<c:set var="formName" value="_41_outServiceType"></c:set>
					<c:set var="formValue" value="${requestScope[formName]}"></c:set>
					<select onchange="doOutServiceSelect(this);" class="bigSelect" name="${formName}">
						<option value="">Please select</option>
						<c:forEach var="opt" items="${requestScope['_41_availableOutServices']}">
							<option value="${opt.code}"><c:out value="${opt.description}" /></option>
						</c:forEach>
					</select>
				</div>
				<div class="row">
					<c:forEach var="opt" items="${requestScope['_41_availableOutServices']}">
						<c:set var="formName" value="_41_availableOutServices_${opt.code}"></c:set>
						<div class="hide ext-services ext-services-${opt.code}">
						<ul>
							<c:forEach var="exTyp" items="${requestScope[formName]}">
							<li class='no-width'>
								<input type="checkbox" value="${exTyp.code}" name="${formName}_1"/> ${exTyp.description}
							</li>
							</c:forEach>
						</ul>
						</div>
					</c:forEach>
				</div>
				<div class="row">
					<label>&nbsp;</label>
					<span class="floatL"><b>&nbsp;</b></span>
					<c:set var="formName" value="_41_outServiceTypeStatus"></c:set>
					<c:set var="formValue" value="${requestScope[formName]}"></c:set>
					<label class="inline"><input type="radio" value="1" name="${formName}" ${formValue eq '1' ? 'checked' : ''}>Initiate New</label>
					<label class="inline"><input type="radio" value="2" name="${formName}" ${formValue eq '2' ? 'checked' : ''}>Continue Current</label>
					<label class="inline"><input type="radio" value="3" name="${formName}" ${formValue eq '3' ? 'checked' : ''}>Terminate</label>
				</div>
				<div class="row">
					<label>Effective Date<span class="required">*</span></label>
					<span class="floatL"><b>:</b></span>
					<span class="dateWrapper">
						<c:set var="formName" value="_41_outServiceEffDt"></c:set>
						<c:set var="formValue" value="${requestScope[formName]}"></c:set>
						<input class="date" type="text"  name="${formName}" value="${formValue}"/>
					</span>
				</div>
				<div class="row">
					<a href="javascript:;" class="remove">REMOVE</a>
				</div>
				<div class="clearFixed"></div>
			</div>
		</div>
	</div>
</div>