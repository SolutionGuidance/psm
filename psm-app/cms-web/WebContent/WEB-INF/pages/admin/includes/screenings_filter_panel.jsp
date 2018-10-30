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
<%--
  The filter panel for: admin user login > Screenings > All/Passed/Failed/etc.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp"%>
<div
  id="screeningsTabFilterPanel"
  <c:choose>
    <c:when test="${searchCriteria.showFilterPanel}">
      style="display: block"
    </c:when>
    <c:otherwise>
      style="display: none"
    </c:otherwise>
  </c:choose>
  class="filterPanel screeningsTabFilterPanel"
>

  <div class="floatW">
    <div class="leftCol">
      <div class="row">
        <input id="recentScreeningsFilterInput" type="checkbox" value="" />
        <label style="width:90%">
          Most recent screenings (per provider and screening type)
        </label>
      </div>
    </div>
    <div class="rightCol">
      <div class="row">
        <input id="rescreeningsFilterInput" type="checkbox" value="" />
        <label style="width:90%">
          Re-screenings
        </label>
      </div>
    </div>
  </div>

  <a
    id="screeningsTabFilterBtn"
    href="javascript:;"
    class="purpleBtn showResultBtn"
  >
    Filter
  </a>

</div>
<div class="clearFixed"></div>
<!-- /.filterPanel -->
