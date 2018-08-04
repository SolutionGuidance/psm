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
<c:if test="${requestScope['_40_bound'] eq 'Y'}">
<div class="section">
    <div class="">
        <div class="row">
            <label>Facility Qualifications</label>
            <span>
                <label>Hospital Based Clinic Designation:  approval letter from CMS</label>
                <span>
                    <c:if test="${requestScope['_40_designationApprovalIndicator'] eq 'Y'}">
                         Provided
                    </c:if>
                    <c:if test="${requestScope['_40_designationApprovalIndicator'] ne 'Y'}">
                         None
                    </c:if>
                </span>
            </span>
        </div>
    </div>
    <div class="clearFixed"></div>
</div>
</c:if>
