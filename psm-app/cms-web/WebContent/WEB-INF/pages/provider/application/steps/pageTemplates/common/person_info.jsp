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
    <div class="leftCol">
        <div class="row">
            <label>First Name</label>
            <span id="firstName">${requestScope['_02_firstName']}</span>
        </div>
        <div class="row">
            <label>Middle Name</label>
            <span id="middleName">${requestScope['_02_middleName']}</span>
        </div>
        <div class="row">
            <label>Last Name</label>
            <span id="lastName">${requestScope['_02_lastName']}</span>
        </div>
        <div class="row">
            <label>NPI</label>
            <span id="npi">${requestScope['_02_npi']}</span>
        </div>
        <div class="row">
            <label>Social Security Number</label>
            <span id="ssn">${requestScope['_02_ssn']}</span>
        </div>
        <div class="row">
            <label>Date of Birth</label>
            <span id="dob">${requestScope['_02_dob']}</span>
        </div>
    </div>
    <!-- /.leftCol -->
    <div class="rightCol">
        <div class="row">
            <label>Email Address</label>
            <span id="email">${requestScope['_02_email']}</span>
        </div>
    </div>
