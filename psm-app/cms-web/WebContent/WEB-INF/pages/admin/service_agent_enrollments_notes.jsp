 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the enrollments notes page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <c:set var="title" value="Enrollment"/>
    <%@ include file="/WEB-INF/pages/admin/includes/html_head.jsp" %>
    <body>
        <div id="wrapper">
            <%@ include file="/WEB-INF/pages/includes/header.jsp" %>
            <div id="mainContent">
                <div class="contentWidth">
                    <div class="mainNav">
                        <%@include file="/WEB-INF/pages/includes/logo.jsp" %>
                        <c:set var="activeTab" value="2"></c:set>
                        <%@include file="/WEB-INF/pages/includes/nav.jsp" %>
                    </div>
                    <!-- /.mainNav -->
                    <div class="breadCrumb">
                        Enrollments
                    </div>
                    <h1>Enrollments</h1>
                    <div class="tabSection" id="enrollmentSection">
                        <c:set var="active_enrollment_tab" value="notes"/>
                        <c:set var="enrollmentSearchFormAction" value="${ctx}/provider/search/notes?statuses="/>
                        <c:set var="searchResult" value="${results}"/>
                        <c:set var="itemsName" value="Enrollment${searchResult.total>1?'s':''}"/>
                        <%@ include file="/WEB-INF/pages/admin/includes/enrollment_tab_section.jsp" %>
                        <%@ include file="/WEB-INF/pages/admin/includes/enrollment_search_form.jsp" %>
                        <!-- /.tabHead -->
                        <div class="tabContent" id="tabNotes">
                            <div class="pagination">
                                <%@ include file="/WEB-INF/pages/admin/includes/page_left_navigation.jsp" %>
                                <%@ include file="/WEB-INF/pages/admin/includes/enrollment_buttons.jsp" %>
                            </div>
                            <%@ include file="/WEB-INF/pages/admin/includes/enrollment_search_filter_panel.jsp" %>
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
                                            <%@ include file="/WEB-INF/pages/admin/includes/enrollment_search_result_table.jsp" %>
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
                    </div>
                    <!-- /.tabSection -->
                </div>
            </div>
            <!-- /#mainContent -->
            <%@ include file="/WEB-INF/pages/includes/footer.jsp" %>
            <!-- #footer -->
        </div>
        <!-- /#wrapper -->
        <div id="modalBackground"></div>
        <div id="modal">
            <div class="modal" id="writeNotesModal">
                <div class="modalHeader">
                    <div class="corner">
                        <div class="cornerR">
                            <div class="cornerM">
                                <a href="javascript:;" class="closeModal">CLOSE</a>
                                <h2>Write Notes</h2>
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
                                    <textarea rows="6" cols="60" class="textarea">Write your note here...</textarea>
                                    <div class="buttons">
                                        <a id="saveNote" href="javascript:;" class="purpleBtn saveBtn"><span class="btR"><span class="btM">Save</span></span></a>
                                        <a href="javascript:;" class="greyBtn closeModal"><span class="btR"><span class="btM">CANCEL</span></span></a>
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
            <!-- /#writeNoteModal -->
            <div class="modal" id="viewNotesModal">
                <div class="modalHeader">
                    <div class="corner">
                        <div class="cornerR">
                            <div class="cornerM">
                                <a href="javascript:;" class="closeModal">CLOSE</a>
                                <h2>View Notes</h2>
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
                                    <textarea id="viewNotesModalNotesBody" rows="6" cols="60" class="textarea disable" disabled="disabled"></textarea>
                                    <div class="buttons">
                                        <div class="links">
                                            <a id="preNote" href="javascript:;">&laquo; Previous</a>
                                            <a id="nextNote" href="javascript:;" class="nextLink">Next &raquo;</a>
                                        </div>
                                        <a href="javascript:;" class="greyBtn closeModal"><span class="btR"><span class="btM">CANCEL</span></span></a>
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
            <!-- /#viewNotesModal -->
        </div>
    </body>
</html>