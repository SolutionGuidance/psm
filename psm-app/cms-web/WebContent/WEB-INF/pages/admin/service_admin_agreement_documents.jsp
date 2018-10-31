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
  - Description: This is the admin agreement documents page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>

<!DOCTYPE html>
<html lang="en-US">
  <c:set var="title" value="Agreements & Addendums - Functions (Service Admin)"/>
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
            <c:set var="functionsServiceActiveMenuAgreement" value="1"/>
            <h:handlebars template="admin/includes/functions_service_nav" context="${pageContext}" />
            <div class="tabContent" id="tabAgreement">
              <div id="agreementPanel">
                <c:set var="searchResult" value="${agreementDocumentsSearchResult}"/>

                <form:form
                  id="searchForm"
                  cssClass="paginationForm"
                  action="${ctx}/admin/viewAgreementDocuments"
                  modelAttribute="searchCriteria"
                  method="post"
                >
                  <form:hidden id="searchFormPageSize" path="pageSize" />
                  <form:hidden id="searchFormPageNumber" path="pageNumber" />
                  <form:hidden id="searchFormSortColumn" path="sortColumn" />
                  <form:hidden id="searchFormAscending" path="ascending" />
                  <form:hidden id="searchFormShowFilterPanel" path="showFilterPanel" />

                  <form:hidden id="searchFormAgreementDocumentTitle" path="title" />
                  <form:hidden id="searchFormAgreementType" path="type" />
                </form:form>

                <div class="pagination">
                  <div class="right">
                    <a href="${ctx}/admin/editAgreementDocument?agreementId=0&agreementDocumentType=AGREEMENT"
                      class="purpleBtn addAgreementBtn">
                      Add Agreement
                    </a>
                    <a href="${ctx}/admin/editAgreementDocument?agreementId=0&agreementDocumentType=ADDENDUM"
                      class="purpleBtn addAgreementBtn">
                      Add Addendum
                    </a>
                    <a href="javascript:" class="userHelpLink agreementsAddendumsHelpLink">?</a>
                  </div>
                </div>
                <div class="pagination">
                  <%@ include file="/WEB-INF/pages/includes/pagination_details_wrapper.jsp" %>
                  <div class="right">
                    <c:choose>
                    <c:when test="${searchCriteria.showFilterPanel}">
                      <a href="javascript:;" class="blueBtn filterBtn hideFilter"><span class="text">Hide Filter</span><span class="arrow"></span></a>
                    </c:when>
                    <c:otherwise>
                      <a href="javascript:;" class="blueBtn filterBtn showFilter"><span class="text">Filter</span><span class="arrow"></span></a>
                    </c:otherwise>
                    </c:choose>
                    <c:if test="${searchResult.total > 0}">
                      <a href="javascript:;" class="greyBtn deleteAgreementDocumentsBtn">Delete Selected Agreement</a>
                    </c:if>
                  </div>
                </div>
                <!-- /.pagination -->

                <div <c:if test="${!searchCriteria.showFilterPanel}">style="display: none"</c:if> class="filterPanel">
                  <div class="floatW">
                    <div class="leftCol">
                      <div class="row">
                        <label for="agreementDocumentTitleFilterText">Title</label>
                        <input id="agreementDocumentTitleFilterText" value="${searchCriteria.title}" type="text" class="normalInput"/>
                      </div>
                    </div>
                    <div class="rightCol">
                      <div class="row">
                        <label for="agreementDocumentTypeFilterText">Agreement Type</label>
                        <select id="agreementDocumentTypeFilterText">
                          <option value="">---SELECT---</option>
                          <option <c:if test="${searchCriteria.type=='AGREEMENT'}">selected="selected"</c:if> value="AGREEMENT">AGREEMENT</option>
                          <option <c:if test="${searchCriteria.type=='ADDENDUM'}">selected="selected"</c:if> value="ADDENDUM">ADDENDUM</option>
                        </select>
                      </div>
                    </div>
                  </div>
                  <a id="searchAgreementDocuments" href="javascript:;" class="purpleBtn showFilter">Filter</a>
                </div>
                <!-- /.filterPanel -->
                <div class="clearFixed"></div>
                <c:choose>
                <c:when test="${searchResult.total == 0}">
                  <div class="tableWrapper">
                    <div class="tableContainer"></div>
                    <div class="tabFoot">
                      <div class="tabR">
                        <div class="tabM red">
                          No matched data found.
                        </div>
                      </div>
                    </div>
                  </div>
                </c:when>
                <c:otherwise>
                  <div class="tableWrapper">
                    <div class="tableContainer">
                      <table
                        class="generalTable linedTable"
                        id="agreementTable"
                      >
                        <thead>
                          <tr>
                            <th class="alignCenter">
                              <input title="Select All" type="checkbox" name="agreementType" class="selectAll" />
                              <span class="sep"></span>
                            </th>
                            <th>
                              <c:choose>
                              <c:when test="${searchCriteria.sortColumn == 'title'}">
                              <a class="sortable_column" rel="title" href="javascript:;"><span>Title</span>
                                <c:choose>
                                <c:when test="${searchCriteria.ascending}">
                                <span class="sort-up"></span>
                                </c:when>
                                <c:otherwise>
                                <span class="sort-down"></span>
                                </c:otherwise>
                                </c:choose>
                              </a>
                              </c:when>
                              <c:otherwise>
                              <a class="sortable_column" rel="title" href="javascript:;"><span>Title</span></a>
                              </c:otherwise>
                              </c:choose>
                              <span class="sep"></span>
                            </th>
                            <th>
                              <c:choose>
                              <c:when test="${searchCriteria.sortColumn == 'type'}">
                              <a class="sortable_column" rel="type" href="javascript:;"><span>Agreement Type</span>
                                <c:choose>
                                <c:when test="${searchCriteria.ascending}">
                                <span class="sort-up"></span>
                                </c:when>
                                <c:otherwise>
                                <span class="sort-down"></span>
                                </c:otherwise>
                                </c:choose>
                              </a>
                              </c:when>
                              <c:otherwise>
                              <a class="sortable_column" rel="type" href="javascript:;"><span>Agreement Type</span></a>
                              </c:otherwise>
                              </c:choose>
                              <span class="sep"></span>
                            </th>
                            <th class="alignCenter">Action</th>
                          </tr>
                        </thead>
                        <tbody>
                          <c:forEach
                            var="item"
                            items="${searchResult.items}"
                            varStatus="status"
                          >
                            <tr class="${status.index % 2 == 0 ? 'odd' : 'even'}">
                              <td class="alignCenter">
                                <input id="agreement_type_${item.id}" <c:if test="${!item.canDelete}">disabled="disabled"</c:if> class="agreementDocumentCheckBox" value="${item.id}" type="checkbox" name="agreementType"/>
                              </td>
                              <td>${item.title}</td>
                              <td><label for="agreement_type_${item.id}">${item.type}</label></td>
                              <td class="alignCenter">
                                <a
                                  href="${ctx}/admin/getAgreementDocument?agreementId=${item.id}"
                                  class="actionLink viewAgreementLink"
                                >
                                  View
                                </a>
                                <a
                                  href="${ctx}/admin/editAgreementDocument?agreementId=${item.id}"
                                  class="actionLink editAgreementLink"
                                >
                                  Edit
                                </a>
                                <c:choose>
                                  <c:when test="${item.canDelete}">
                                    <a
                                      rel="${item.id}"
                                      href="javascript:;"
                                      class="actionLink deleteAgreementDocumentBtn"
                                    >
                                      Delete
                                    </a>
                                  </c:when>
                                  <c:otherwise>
                                    <a
                                      href="javascript:;"
                                      class="actionLink disabledBtn"
                                    >
                                      Delete
                                    </a>
                                  </c:otherwise>
                                </c:choose>
                              </td>
                            </tr>
                          </c:forEach>
                        </tbody>
                      </table>
                    </div>
                    <!-- /.tableContainer -->
                    <div class="tabFoot">
                      <div class="tabR">
                        <div class="tabM">
                          <%@ include file="/WEB-INF/pages/includes/pagination_details_and_links.jsp" %>
                        </div>
                      </div>
                    </div>
                    <!-- /.tabFoot -->
                  </div>
                </c:otherwise>
                </c:choose>
              </div>
              <!--/#agreementPanel -->
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
      <div class="modal" id="deleteAgreementModal">
        <div class="modalHeader">
          <div class="corner">
            <div class="cornerR">
              <div class="cornerM">
                <a href="javascript:;" class="closeModal">CLOSE</a>
                <h2>Delete Agreement Document</h2>
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
                  <p class="modal_title"></p>
                  <div class="buttons">
                    <a href="javascript:;" class="purpleBtn deleteOKBtn">Delete</a>
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

      <div class="modal" id="noSelectedItemsModal">
        <div class="modalHeader">
          <div class="corner">
            <div class="cornerR">
              <div class="cornerM">
                <a href="javascript:;" class="closeModal">CLOSE</a>
                <h2>No Selected Agreement Document</h2>
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
                  <p class="modal_title red">Please select at least one agreement document.</p>
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

      <div id="new-modal">
        <c:set var="userHelpModalId" value="user-help-modal"/>
        <h:handlebars template="includes/userhelp/user_help_modal" context="${pageContext}" />
      </div>

    </div>
  </body>
</html>
