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
<c:if test="${requestScope['_26_bound'] eq 'Y'}">
<div class="section">
    <div class="leftCol">
        <c:if test="${requestScope['_26_countyIndicator'] eq 'Y'}">
            <div class="row">
                <label>County</label>
                <span >${requestScope['_26_countyName']}</span>
            </div>
        </c:if>
        <c:if test="${requestScope['_26_countyIndicator'] eq 'N'}">
            <div class="row">
                <label>Have a contract with a county</label>
                <span >Y</span>
            </div>
        </c:if>
    </div>
    <div class="clearFixed"></div>
</div>
</c:if>
