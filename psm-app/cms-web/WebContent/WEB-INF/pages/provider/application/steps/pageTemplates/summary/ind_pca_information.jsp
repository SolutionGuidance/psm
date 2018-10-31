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
<%-- Used for Personal Care Assistant application --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags" %>
<c:if test="${requestScope['_10_bound'] eq 'Y'}">
    <div class="practiceSection">
        <div class="wholeCol">
           <%@include file="/WEB-INF/pages/provider/application/steps/pageTemplates/common/ind_pca_rows.jsp" %>
        </div>
        <div class="clearFixed"></div>
    </div>
</c:if>
