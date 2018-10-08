<%--
  Copyright 2012 TopCoder Inc.
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
  - Description: This is the admin provider types page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>

<!DOCTYPE html>
<html lang="en-US">
  <c:set var="title" value="View Provider Type - Functions (Service Admin)"/>
  <h:handlebars template="includes/html_head" context="${pageContext}" />
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>
      <div id="mainContent">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <h:handlebars template="includes/banner" context="${pageContext}"/>
            <c:set var="activeTabFunctions" value="true"></c:set>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <div class="breadCrumb">
            Functions
          </div>
          <h1>Functions</h1>
          <div class="tabSection functionTab" id="applicationSection">
            <c:set var="functionsServiceActiveMenuProviderTypes" value="1"/>
            <h:handlebars template="admin/includes/functions_service_nav" context="${pageContext}" />
            <div class="tabContent" id="tabProviderTypes">
              <div id="viewProviderPanel">
                <div class="sideBorder">
                  <h3>Provider Type Details</h3>
                  <a href="${ctx}/admin/viewProviderTypes" class="greyBtn">Back</a>
                  <c:choose>
                  <c:when test="${providerType.canDelete}"><a href="javascript:;" rel="${providerType.code}" class="greyBtn deleteProviderTypesOnViewBtn">Delete</a></c:when>
                  <c:otherwise>
                  <a href="javascript:;" class="greyBtn disabledBtn">Delete</a>
                  </c:otherwise>
                  </c:choose>
                  <a href="${ctx}/admin/beginEditProviderType?providerTypeId=${providerType.code}" class="purpleBtn editProviderLink">Edit</a>
                </div>
                <div class="newApplicationPanel">
                  <div class="section">
                    <div class="wholeCol">
                      <label>Provider Type</label>
                      <span class="marginLeft10">${providerType.description}</span>
                    </div>
                    <div class="tableHeader"><span>Agreements and Addendums</span></div>
                    <div class="wholeCol">
                      <div class="row">
                        <div class="col2">
                          <c:forEach var="agreement" items="${agreements}">
                            <div class="row">
                              <span>${agreement.title}</span>
                            </div>
                          </c:forEach>
                        </div>
                      </div>
                    </div>
                    <div class="tableHeader"><span>Applicable Licenses</span></div>
                    <div class="wholeCol">
                      <div class="row">
                        <div class="col2">
                          <c:forEach var="licenseType" items="${licenseTypes}">
                            <div class="row">${licenseType.description}</div>
                          </c:forEach>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="bl"></div>
                <div class="br"></div>
              </div>
            </div>
            <!--/ #viewProviderPanel -->
          </div>
        </div>
      </div>
    </div>
    <!-- /#mainContent -->

    <h:handlebars template="includes/footer" context="${pageContext}"/>
    </div>
    <!-- /#wrapper -->
    <!-- modal -->
    <div id="modalBackground"></div>
    <div id="modal">
      <div class="modal" id="deleteProviderTypesModal">
        <div class="modalHeader">
          <div class="corner">
            <div class="cornerR">
              <div class="cornerM">
                <a href="javascript:;" class="closeModal">CLOSE</a>
                <h2>Delete Provider Type</h2>
              </div>
            </div>
          </div>
        </div>
        <!-- /.modalHeader -->
        <div class="modalBody">
          <div class="corner">
            <div class="cornerR">
              <div class="cornerM">
                <div class="container">
                  <p class="modal_title">Are you sure you want to delete the selected provider type?</p>
                  <div class="buttons">
                    <a href="javascript:;" rel="${ctx}/admin/deleteProviderTypes?providerTypeIds=${providerType.code}" class="purpleBtn deleteOKBtn">Delete</a>
                    <a href="javascript:;" class="greyBtn closeModal">Cancel</a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- /.modalBody -->
        <div class="modalFooter">
          <div class="corner">
            <div class="cornerR">
              <div class="cornerM">
              </div>
            </div>
          </div>
        </div>
        <!-- /.modalFooter -->
      </div>
    </div>
  </body>
</html>
