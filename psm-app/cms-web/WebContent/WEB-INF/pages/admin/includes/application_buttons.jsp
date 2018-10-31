<%--
  Copyright 2012 TopCoder Inc.
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
<%--
  - Description: it is used to build the application search form.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp"%>
<div class="right">
    <c:choose>
        <c:when test="${searchCriteria.showFilterPanel}">
            <a href="javascript:;" class="blueBtn filterBtn hideFilter"><span class="text">Hide Filter</span><span class="arrow"></span></a>
        </c:when>
        <c:otherwise>
            <a href="javascript:;" class="blueBtn filterBtn showFilter"><span class="text">Filter</span><span class="arrow"></span></a>
        </c:otherwise>
    </c:choose>
    <a id="exportApplicationsToPDF" href="javascript:;" class="greyBtn iconPdf">Export to PDF</a>
    <c:if test="${active_application_tab=='approved'}">
        <a href="javascript:renewSelections('${ctx}/provider/application/bulkRenewApplications');" class="greyBtn">Renew Selected Applications</a>
    </c:if>
</div>
