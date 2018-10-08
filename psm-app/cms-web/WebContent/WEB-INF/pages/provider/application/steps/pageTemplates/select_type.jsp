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
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<div class="tabSection">
  <form action="<c:url value="/provider/application/steps/next" />"
        id="applicationForm"
        method="post">
    <sec:csrfInput />
    <%@include file="/WEB-INF/pages/provider/application/steps/errors.jsp" %>

    <div class="detailPanel firstRegistrant" style="width: 940px;">

      <%@include file="/WEB-INF/pages/provider/application/steps/pageTemplates/default/provider_type.jsp" %>

      <!-- /.section -->
      <div class="tl"></div>
      <div class="tr"></div>
      <div class="bl"></div>
      <div class="br"></div>
    </div>

    <div class="buttonBox">
      <input type="hidden" name="pageName" value="${pageName}"/>
      <button type="submit" class="nextBtn greyBtn"><span class="icon">Next</span></button>
    </div>
  </form>
</div>
