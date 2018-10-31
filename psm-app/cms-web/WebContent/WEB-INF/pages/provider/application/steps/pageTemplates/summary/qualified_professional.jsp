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
<c:if test="${requestScope['_29_bound'] eq 'Y'}">

<c:set var="formName" value="_16_qpSize"></c:set>
<c:forEach begin="1" end="${requestScope[formName]}" varStatus="status">
    <div class="section">
        <div class="leftCol">
            <div class="row">
                <label>QP Type</label>
                <c:set var="formName" value="_29_qpType_${status.index - 1}"></c:set>
                <span>${requestScope[formName]}</span>
            </div>
            <div class="row">
                <label>Name</label>
                <c:set var="formName" value="_29_name_${status.index - 1}"></c:set>
                <span>${requestScope[formName]}</span>
            </div>
            <div class="row">
                <label>NPI</label>
                <c:set var="formName" value="_29_npi_${status.index - 1}"></c:set>
                <span>${requestScope[formName]}</span>
            </div>
            <div class="row">
                <label>Date of Employment</label>
                <c:set var="formName" value="_29_startDate_${status.index - 1}"></c:set>
                <span>${requestScope[formName]}</span>
            </div>
            <div class="clearFixed"></div>
        </div>
        <!-- /.leftCol -->
        <div class="rightCol">
            <div class="row">
                <label>Date of Birth</label>
                <c:set var="formName" value="_29_dob_${status.index - 1}"></c:set>
                <span>${requestScope[formName]}</span>
            </div>
            <div class="row">
                <label>Social Security Number</label>
                <c:set var="formName" value="_29_ssn_${status.index - 1}"></c:set>
                <span>${requestScope[formName]}</span>
            </div>
            <div class="row">
                <label>The affiliation has ended</label>
                <c:set var="formName" value="_29_ended_${status.index - 1}"></c:set>
                <span>${requestScope[formName]}</span>
            </div>
            <div class="row">
                <label>Termination Date</label>
                <c:set var="formName" value="_29_endDate_${status.index - 1}"></c:set>
                <span>${requestScope[formName]}</span>
            </div>
            <div class="clearFixed"></div>
        </div>

        <div class="">
            <div class="row">
                <label>Home Residence Address</label>

                <c:set var="streetAddress" value="_29_addressLine1_${status.index - 1}" />
                <c:set var="extendedAddress" value="_29_addressLine2_${status.index - 1}" />
                <c:set var="city" value="_29_city_${status.index - 1}" />
                <c:set var="state" value="_29_state_${status.index - 1}" />
                <c:set var="postalCode" value="_29_zip_${status.index - 1}" />
                <c:set var="county" value="_29_county_${status.index - 1}" />
                <h:address name="home"
                    streetAddress="${requestScope[streetAddress]}"
                    extendedAddress="${requestScope[extendedAddress]}"
                    city="${requestScope[city]}"
                    state="${requestScope[state]}"
                    postalCode="${requestScope[postalCode]}"
                    county="${requestScope[county]}" />
            </div>
        </div>

        <div class="leftCol">
            <div class="row requireField">
                <label>BGS ID NUMBER <span class="required">*</span></label>
                <c:set var="formName" value="_29_bgsNumber_${status.index - 1}"></c:set>
                <span>${requestScope[formName]}</span>
            </div>
            <div class="clearFixed"></div>
        </div>

        <div class="rightCol">
            <div class="row requireField">
                <label>BGS Clearance Date <span class="required">*</span>
                    <span class="label">(MM/DD/YYYY)</span>
                </label>
                <c:set var="formName" value="_29_bgsClearanceDate_${status.index - 1}"></c:set>
                <span>${requestScope[formName]}</span>
            </div>
            <div class="clearFixed"></div>
        </div>
        <div class="clearFixed"></div>
    </div>
    <div class="clearFixed"></div>
</c:forEach>
</c:if>
