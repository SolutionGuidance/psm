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
<c:if test="${requestScope['_22_bound'] eq 'Y'}">
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<table class="generalTable noInput">
    <colgroup>
        <col width="28"/>
        <col width="284"/>
    </colgroup>
    <thead>
        <tr>
            <th class="alignCenter">#<span class="sep"></span></th>
            <th>CLIA #<span class="sep"></span></th>
        </tr>
    </thead>
    <tbody>
        <c:set var="formName" value="_22_attachmentSize"></c:set>
        <c:forEach begin="1" end="${requestScope[formName]}" varStatus="status">
            <tr>
                <td class="alignCenter">${status.count}</td>
                <c:set var="formName" value="_22_licenseNumber_${status.index - 1}"></c:set>
                <td>${requestScope[formName]}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<!-- /.section -->
<div class="clearFixed"></div>
</c:if>
