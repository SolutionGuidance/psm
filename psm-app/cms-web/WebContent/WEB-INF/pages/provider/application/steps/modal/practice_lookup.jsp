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
    JSP Fragment for common practice lookup modal.

 --%>
<!-- /#practiceLookupModal-->
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<div id="practiceLookupModal" class="outLay">
  <div class="inner">
    <!-- title -->
    <div class="modal-title">
      <div class="right">
        <div class="middle">
          <button class="closeModal" title="Close" aria-label="Close"></button>
          <h2 class="practiceLookupModalTitle">Find Practice Data in Existing Record</h2>
        </div>
      </div>
    </div>
    <!-- End .modal-title -->

    <!-- content -->
    <div class="modal-content">
      <div class="right">
        <div class="middle">
          <c:url var="lookupUrl" value="/provider/application/lookup" />
          <form action="${lookupUrl}" id="practiceLookupForm">
            <sec:csrfInput />
            <div class="searchRow">
              <span>
                <label for="practiceLookupPracticeName">Practice Name:</label>
                <input type="hidden" name="agency" value="false"/>
                <input id="practiceLookupPracticeName" type="text" class="normalInput inputL" name="name"/>
              </span>
              <span>
                <label for="practiceLookupNpi">NPI / UMPI:</label>
                <input id="practiceLookupNpi" type="text" class="normalInput inputL" name="npi"/>
              </span>
              <span>
                <label for="practiceLookupCity">City:</label>
                <input id="practiceLookupCity" type="text" class="normalInput inputM" name="city"/>
              </span>
              <span>
                <label for="practiceLookupState">State/Territory:</label>
                <input id="practiceLookupState" type="text" class="normalInput inputM" name="state"/>
              </span>
              <span class="last">
                <label for="practiceLookupZip">Zip:</label>
                <input id="practiceLookupZip" type="text" class="normalInput inputS zipInputFor" name="zip"/>
              </span>
              <div class="clear"></div>
            </div>
            <div class="buttonArea">
              <button class="purpleBtn searchBtn performPracticeLookupBtn" type="submit"><span class="icon">Search</span></button>
            </div>
          </form>
          <div class="tableContainer hide">
            <p><strong id="practiceLookupMatches">5 matching practices found:</strong></p>
            <table class="generalTable tablesorter" id="draftTable">
              <colgroup>
                <col width="30" />
                <col width="125" />
                <col width="125" />
                <col width="135" />
                <col width="130" />
                <col width="165" />
                <col width="100" />
              </colgroup>
              <thead>
                <tr class="tablesorter-header">
                  <th class="alignCenter"><span class="sep"></span></th>
                  <th class="alignCenter">Practice Name<span class="sep"></span></th>
                  <th class="alignCenter">NPI / UMPI<span class="sep"></span></th>
                  <th class="alignCenter">Address<span class="sep"></span></th>
                  <th class="alignCenter">City<span class="sep"></span></th>
                  <th class="alignCenter">State/Territory<span class="sep"></span></th>
                  <th class="alignCenter">ZIP</th>
                </tr>
              </thead>
              <tbody>
              </tbody>
            </table>
            <div class="clear"></div>
            <div class="buttonArea">
              <a href="javascript:copySelectedPracticeData();" class="purpleBtn copySelectedPracticeDataBtn">Copy Selected Practice Data</a>
              <a href="javascript:;" class="greyBtn closeModal">Cancel</a>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- End .content -->
    <div class="modal-footer">
      <div class="right">
        <div class="middle"></div>
      </div>
    </div>
  </div>
</div>
<!-- /#practiceLookupModal-->

<div class="hide">
  <table class="hide" id="practiceLookupTableTemplate">
    <tbody>
      <tr>
        <td class="alignCenter"></td>
        <td class="alignCenter"></td>
        <td class="alignCenter"></td>
        <td class="alignCenter"></td>
        <td class="alignCenter"></td>
        <td class="alignCenter"></td>
        <td class="alignCenter"></td>
      </tr>
    </tbody>
  </table>
</div>
