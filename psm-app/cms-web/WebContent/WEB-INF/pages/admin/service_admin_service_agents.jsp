 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the admin service agents page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <c:set var="title" value="Functions (Service Admin)"/>
    <%@ include file="/WEB-INF/pages/admin/includes/html_head.jsp" %>
    <body>
        <div id="wrapper">
            <%@ include file="/WEB-INF/pages/includes/header.jsp" %>
            <div id="mainContent">
                <div class="contentWidth">
                    <div class="mainNav">
                        <%@include file="/WEB-INF/pages/includes/logo.jsp" %>
                        <c:set var="activeTab" value="4"></c:set>
                        <%@include file="/WEB-INF/pages/includes/nav.jsp" %>
                    </div>
                    <div class="breadCrumb">
                        Functions
                    </div>
                    <h1>Functions</h1>
                    <div class="tabSection functionTab" id="enrollmentSection">
                        <c:set var="functions_service_active_menu" value="serviceAgents"/>
                        <%@ include file="/WEB-INF/pages/admin/includes/functions_service_nav.jsp" %>
                        
                        <div class="tabContent" id="tabServiceAgents">
                            <div id="agentsPanel">
                                <c:set var="itemsName" value="Service Agents"/>
                                <c:set var="searchResult" value="${usersSearchResult}"/>
                                
                                <form:form id="searchForm" action="${ctx}/admin/viewAgents" modelAttribute="searchCriteria" method="post">
                                    <form:hidden id="searchFormPageSize" path="pageSize" />
                                    <form:hidden id="searchFormPageNumber" path="pageNumber" />
                                    <form:hidden id="searchFormSortColumn" path="sortColumn" />
                                    <form:hidden id="searchFormAscending" path="ascending" />
                                    <form:hidden id="searchFormShowFilterPanel" path="showFilterPanel" />
                                    
                                    <form:hidden id="searchFormUserLastName" path="lastName" />
                                    <form:hidden id="searchFormUserFirstName" path="firstName" />
                                </form:form>
                                
                                <div class="pagination">
                                    <%@ include file="/WEB-INF/pages/admin/includes/page_left_navigation.jsp" %>
                                    <div class="right">
                                        <c:choose>
                                            <c:when test="${searchCriteria.showFilterPanel}">
                                                <a href="javascript:;" class="blueBtn filterBtn hideFilter"><span class="btR"><span class="btM"><span class="text">Hide Filter</span><span class="arrow"></span></span></span></a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="javascript:;" class="blueBtn filterBtn showFilter"><span class="btR"><span class="btM"><span class="text">Filter</span><span class="arrow"></span></span></span></a>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:if test="${searchResult.total > 0}">
                                            <a href="javascript:;" class="greyBtn deleteServiceAgentsBtn"><span class="btR"><span class="btM">Delete Selected Agents</span></span></a>
                                        </c:if>
                                        <a href="${ctx}/admin/beginEditAgent?userId=" class="purpleBtn addAgentBtn"><span class="btR"><span class="btM">Add Service Agent</span></span></a>
                                    </div>
                                </div>
                                <!-- /.pagination -->
                                <div <c:if test="${!searchCriteria.showFilterPanel}">style="display: none"</c:if> class="filterPanel">
                                    <div class="floatW">
                                        <div class="leftCol">
                                            <div class="row">
                                                <label>Last Name</label>
                                                <span class="floatL"><b>:</b></span>
                                                <input id="userLastNameFilterText" value="${searchCriteria.lastName}" type="text" class="normalInput"/>
                                            </div>
                                        </div>
                                        <div class="rightCol">
                                            <div class="row">
                                                <label>First Name</label>
                                                <span class="floatL"><b>:</b></span>
                                                <input id="userFirstNameFilterText" value="${searchCriteria.firstName}" type="text" class="normalInput"/>
                                            </div>
                                        </div>
                                    </div>
                                    <a id="searchServiceAgents" href="javascript:;" class="purpleBtn showFilter"><span class="btR"><span class="btM">Filter</span></span></a>
                                </div>
                                <!-- /.filterPanel -->
                                <div class="clearFixed"></div>
                                <c:choose>
                                    <c:when test="${searchResult.total == 0}">
                                        <div class="tableWrapper">
                                            <div class="tableContainer"></div>                                    
                                            <div class="tabFoot">
                                                <div class="tabR">
                                                    <div class="tabM" style="color: red">
                                                        No matched data found.
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="tableWrapper">
                                            <div class="tableContainer">
                                                <table cellpadding="0" cellspacing="0" class="generalTable" id="agentTable">
                                                    <thead>
                                                        <tr>
                                                            <th class="alignCenter">
                                                                <input type="checkbox" name="serviceAgent" class="selectAll"/>
                                                                <span class="sep"></span>
                                                            </th>
                                                            <th>
                                                                <c:choose>
                                                                    <c:when test="${searchCriteria.sortColumn == 'lastName'}">
                                                                        <a class="sortable_column" rel="lastName" href="javascript:;"><span>Last Name</span>
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
                                                                        <a class="sortable_column" rel="lastName" href="javascript:;"><span>Last Name</span></a>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                <span class="sep"></span>
                                                            </th>
                                                            <th>
                                                                <c:choose>
                                                                    <c:when test="${searchCriteria.sortColumn == 'firstName'}">
                                                                        <a class="sortable_column" rel="firstName" href="javascript:;"><span>First Name</span>
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
                                                                        <a class="sortable_column" rel="firstName" href="javascript:;"><span>First Name</span></a>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                <span class="sep"></span>
                                                            </th>
                                                            <th>
                                                                <c:choose>
                                                                    <c:when test="${searchCriteria.sortColumn == 'middleName'}">
                                                                        <a class="sortable_column" rel="middleName" href="javascript:;"><span>Middle Name</span>
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
                                                                        <a class="sortable_column" rel="middleName" href="javascript:;"><span>Middle Name</span></a>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                <span class="sep"></span>
                                                            </th>
                                                            <th>
                                                                <c:choose>
                                                                    <c:when test="${searchCriteria.sortColumn == 'businessPhone'}">
                                                                        <a class="sortable_column" rel="businessPhone" href="javascript:;"><span>Business Phone</span>
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
                                                                        <a class="sortable_column" rel="businessPhone" href="javascript:;"><span>Business Phone</span></a>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                <span class="sep"></span>
                                                            </th>
                                                            <th>
                                                                <c:choose>
                                                                    <c:when test="${searchCriteria.sortColumn == 'email'}">
                                                                        <a class="sortable_column" rel="email" href="javascript:;"><span>Email</span>
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
                                                                        <a class="sortable_column" rel="email" href="javascript:;"><span>Email</span></a>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                <span class="sep"></span>
                                                            </th>
                                                            <th class="alignCenter">Action</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="item" items="${searchResult.items}">
                                                            <tr>
                                                                <td class="alignCenter">
                                                                    <input class="serviceAgentCheckBox" value="${item.userId}" type="checkbox" name="serviceAgent"/>
                                                                </td>
                                                                <td>${item.lastName}</td>
                                                                <td>${item.firstName}</td>
                                                                <td>${item.middleName}</td>
                                                                <td>${item.phoneNumber}</td>
                                                                <td>${item.email}</td>
                                                                <td class="alignCenter">
                                                                    <a href="${ctx}/admin/beginEditAgent?userId=${item.userId}" class="editAgentLink">Edit</a>
                                                                    <span class="sep">|</span>
                                                                    <a rel="${item.userId}" href="javascript:;" class="deleteServiceAgentBtn">Delete</a>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <!-- /.tableWrapper -->
                                        <div class="tabFoot">
                                            <div class="tabR">
                                                <div class="tabM">
                                                    <%@ include file="/WEB-INF/pages/admin/includes/page_navigation.jsp" %>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /.tabFoot -->
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <!--/#agentsPanel -->
                        </div>
                    </div>
                </div>
            </div>
            <!-- /#mainContent -->

            <%@ include file="/WEB-INF/pages/includes/footer.jsp" %>
        </div>
        <!-- /#wrapper -->
        <!-- modal -->
        <div id="modalBackground"></div>
        <div id="modal">
            <div class="modal" id="deleteAgentModal">
                <div class="modalHeader">
                    <div class="corner">
                        <div class="cornerR">
                            <div class="cornerM">
                                <a href="javascript:;" class="closeModal">CLOSE</a>
                                <h2>Delete Service Agent</h2>
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
                                        <a href="javascript:;" class="purpleBtn deleteOKBtn"><span class="btR"><span class="btM">Delete</span></span></a>
                                        <a href="javascript:;" class="greyBtn closeModal"><span class="btR"><span class="btM">Cancel</span></span></a>
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
                                <h2>No Selected Service Agent</h2>
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
                                    <p class="modal_title red">Please select at least one service agent.</p>
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