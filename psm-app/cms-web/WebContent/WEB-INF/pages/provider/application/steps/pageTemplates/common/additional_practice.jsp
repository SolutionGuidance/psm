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
<table class="generalTable noInput">
    <colgroup>
        <col width="22" />
        <col width="126" />
        <col width="127" />
        <col width="121" />
        <col width="130" />
        <col width="86" />
        <col width="145" />
        <col width="86" />
        <col width="87" />
    </colgroup>
    <thead>
        <tr>
            <th class="firstTheader">#<span class="sep"></span></th>
            <th>Group NPI / UMPI<span class="sep"></span></th>
            <th>Group Name<span class="sep"></span></th>
            <th>Effective Date<span class="sep"></span></th>
            <th>Practice Address<span class="sep"></span></th>
            <th>City<span class="sep"></span></th>
            <th>State/Territory<span class="sep"></span></th>
            <th>ZIP Code<span class="sep"></span></th>
            <th>County<span class="sep"></span></th>
        </tr>
    </thead>
    <tbody>
        <c:set var="formName" value="_07_additonalLocationSize"></c:set>
        <c:forEach begin="1" end="${requestScope[formName]}" varStatus="status">
            <tr>
                <td class="alignCenter">${status.count}</td>
                <c:set var="formName" value="_07_npi_${status.index - 1}"></c:set>
                <td>${requestScope[formName]}</td>
                <c:set var="formName" value="_07_name_${status.index - 1}"></c:set>
                <td>${requestScope[formName]}</td>
                <c:set var="formName" value="_07_effectiveDate_${status.index - 1}"></c:set>
                <td>${requestScope[formName]}</td>
                <td class="address">
                    <c:set var="formName" value="_07_addressLine1_${status.index - 1}"></c:set>
                    <c:if test="${not empty requestScope[formName]}">${requestScope[formName]} <br /></c:if>
                    <c:set var="formName" value="_07_addressLine2_${status.index - 1}"></c:set>
                    ${requestScope[formName]}
                </td>
                <c:set var="formName" value="_07_city_${status.index - 1}"></c:set>
                <td>${requestScope[formName]}</td>
                <c:set var="formName" value="_07_state_${status.index - 1}"></c:set>
                <td>${requestScope[formName]}</td>
                <c:set var="formName" value="_07_zip_${status.index - 1}"></c:set>
                <td>${requestScope[formName]}</td>
                <c:set var="formName" value="_07_county_${status.index - 1}"></c:set>
                <td>${requestScope[formName]}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<!-- /.section -->
<div class="clearFixed"></div>
