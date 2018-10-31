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
<div id="tabStatement" class="tabContent">
    <div class="topPanel">
    </div>
    <div class="tableHeader">
        <span>Provider Statement</span>
    </div>
    <div class="bottomPanel">
        <div class="row">
            <p>
                I certify that the information provided on this form is accurate, complete and truthful.
                I will notify MHCP Provider Application of any changes to this information. I acknowledge
                that any misrepresentations in the information submitted to MHCP, including false claims,
                statements, documents, or concealment of a material fact, may be cause for denial or termination
                of participation as a Medicaid provider.
            </p>
        </div>
        <div class="row">
            <div class="leftCol">
                <div class="row">
                    <label>Provider Name</label>
                    <span>${requestScope['_19_name']}</span>
                </div>
                <div class="row">
                    <label>Provider Title</label>
                    <span>${requestScope['_19_title']}</span>
                </div>
            </div>
        </div>
        <div class="row">&nbsp;</div>
        <div class="bl"></div>
        <div class="br"></div>
    </div>
</div>
