 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the admin agreement documents page.
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
                        <c:set var="functions_service_active_menu" value="agreement"/>
                        <%@ include file="/WEB-INF/pages/admin/includes/functions_service_nav.jsp" %>
                        <div class="tabContent" id="tabAgreement">
                            <div id="agreementPanel">
                                <c:set var="itemsName" value="Agreement and AddendumTypes"/>
                                <c:set var="searchResult" value="${agreementDocumentsSearchResult}"/>
                                
                                <form:form id="searchForm" action="${ctx}/admin/viewAgreementDocuments" modelAttribute="searchCriteria" method="post">
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
                                        <a href="${ctx}/admin/editAgreementDocument?agreementId=0&agreementDocumentType=ADDENDUM" class="purpleBtn addAgreementBtn"><span class="btR"><span class="btM">Add Agreement Addendum</span></span></a>
                                        <a href="${ctx}/admin/editAgreementDocument?agreementId=0&agreementDocumentType=AGREEMENT" class="purpleBtn addAgreementBtn"><span class="btR"><span class="btM">Add Agreement</span></span></a>
                                    </div>
                                </div>
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
                                            <a href="javascript:;" class="greyBtn deleteAgreementDocumentsBtn"><span class="btR"><span class="btM">Delete Selected Agreement</span></span></a>
                                        </c:if>
                                    </div>
                                </div>
                                <!-- /.pagination -->
                                
                                <div <c:if test="${!searchCriteria.showFilterPanel}">style="display: none"</c:if> class="filterPanel">
                                    <div class="floatW">
                                        <div class="leftCol">
                                            <div class="row">
                                                <label>Title</label>
                                                <span class="floatL"><b>:</b></span>
                                                <input id="agreementDocumentTitleFilterText" value="${searchCriteria.title}" type="text" class="normalInput"/>
                                            </div>
                                        </div>
                                        <div class="rightCol">
                                            <div class="row">
                                                <label>Agreement Type</label>
                                                <span class="floatL"><b>:</b></span>
                                                <select id="agreementDocumentTypeFilterText">
                                                    <option value="">---SELECT---</option>
                                                    <option <c:if test="${searchCriteria.type=='AGREEMENT'}">selected="selected"</c:if> value="AGREEMENT">AGREEMENT</option>
                                                    <option <c:if test="${searchCriteria.type=='ADDENDUM'}">selected="selected"</c:if> value="ADDENDUM">ADDENDUM</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <a id="searchAgreementDocuments" href="javascript:;" class="purpleBtn showFilter"><span class="btR"><span class="btM">Filter</span></span></a>
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
                                                <table cellpadding="0" cellspacing="0" class="generalTable" id="agreementTable">
                                                    <thead>
                                                        <tr>
                                                            <th class="alignCenter">
                                                                <input type="checkbox" name="agreementType" class="selectAll"/>
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
                                                        <c:forEach var="item" items="${searchResult.items}">
                                                            <tr>
                                                                <td class="alignCenter">
                                                                    <input <c:if test="${!item.canDelete}">disabled="disabled"</c:if> class="agreementDocumentCheckBox" value="${item.id}" type="checkbox" name="agreementType"/>
                                                                </td>
                                                                <td><a href="${ctx}/admin/getAgreementDocument?agreementId=${item.id}" class="viewAgreementLink">${item.title}</a></td>
                                                                <td>${item.type}</td>
                                                                <td class="alignCenter"><a href="${ctx}/admin/editAgreementDocument?agreementId=${item.id}" class="editAgreementLink">Edit</a>
                                                                    <span class="sep">|</span>
                                                                    <c:choose>
                                                                        <c:when test="${item.canDelete}"><a rel="${item.id}" href="javascript:;" class="deleteAgreementDocumentBtn">Delete</a></c:when>
                                                                        <c:otherwise><a style="text-decoration: none;color: gray" href="javascript:;" class="disabledBtn">Delete</a></c:otherwise>
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
                                                        <%@ include file="/WEB-INF/pages/admin/includes/page_navigation.jsp" %>
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

            <%@ include file="/WEB-INF/pages/includes/footer.jsp" %>
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
        </div>
    </body>
</html>