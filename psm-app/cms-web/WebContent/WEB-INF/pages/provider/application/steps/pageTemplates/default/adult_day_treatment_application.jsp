<%--
  Copyright 2018 The MITRE Corporation
  
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at
  
      http://www.apache.org/licenses/LICENSE-2.0
  
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--%>
<%@page import="gov.medicaid.entities.dto.ViewStatics"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags" %>

<input type="hidden" name="formNames" value="<%= ViewStatics.ADULT_DAY_TREATMENT_APPLICATION_FORM %>">
<c:set var="selectedMarkup" value='selected="selected"' />

<div class="newApplicationPanel practicePanel memberInfoPanel">
    <div class="tableHeader topHeader"><span>Adult Day Treatment Application</span></div>
    <div class="clearFixed"></div>

    <div class="section">
        <div class="">
            <div class="row requireField">
                <label class="mediumLbl">Please upload a copy of application*</label>
                <span class="floatL">
                    <c:set var="formName" value="_35_application" />
                    <h:attachment
                        name="${formName}"
                        title="Adult Day Treatment Application"
                        attachmentId="${requestScope[formName]}"
                        attachmentIdName="${formName}"
                        filename="Download"
                    />
                </span>
            </div>
        </div>
        <div class="clearFixed"></div>
    </div>

    <!-- /.section -->
    <div class="tl"></div>
    <div class="tr"></div>
    <div class="bl"></div>
    <div class="br"></div>
</div>
