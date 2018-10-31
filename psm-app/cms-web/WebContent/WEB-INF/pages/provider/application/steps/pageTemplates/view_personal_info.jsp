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
<div id="tabPersonal" class="tabContent">
    <div class="topPanel">
        <%@include file="/WEB-INF/pages/provider/application/steps/pageTemplates/common/person_info.jsp" %>
    </div>
    <!-- /.topPanel -->
    <c:choose>
        <c:when test="${'Y' != requestScope['_02_useProviderAsContact']}">
            <div class="tableHeader">
                <span>Contact Info</span>
            </div>
            <!-- /.tableHeader -->
            <div class="bottomPanel">
                <div class="leftCol">
                    <%@include file="/WEB-INF/pages/provider/application/steps/pageTemplates/common/contact_info.jsp" %>
                </div>
                <div class="bl"></div>
                <div class="br"></div>
            </div>
            <!-- /.bottomPanel -->
        </c:when>
        <c:otherwise>
            <div class="bottomPanel"></div>
        </c:otherwise>
    </c:choose>
</div>
<!-- /#tabPersonal -->
