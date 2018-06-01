 <%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This is the admin help topics page.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>

<!DOCTYPE html>
<html lang="en-US">
  <c:set var="title" value="Help Topics - Functions (Service Admin)"/>
  <c:set var="adminPage" value="true" />
  <h:handlebars template="includes/html_head" context="${pageContext}" />
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>
      <div id="mainContent">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <c:set var="activeTabFunctions" value="true"></c:set>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <div class="breadCrumb">
            Functions
          </div>
          <h1>Functions</h1>
          <div class="tabSection functionTab" id="enrollmentSection">
            <c:set var="functionsServiceActiveMenuHelpTopics" value="1"/>
            <h:handlebars template="admin/includes/functions_service_nav" context="${pageContext}" />
            <div class="tabContent" id="tabHelpTopics">
              <div id="helpTopicsPanel">
                <div class="pagination">
                  <div class="right">
                    <a href="${ctx}/admin/editHelpItem?helpItemId=0" class="purpleBtn">Add Help Topic</a>
                  </div>
                </div>
                <div class="helpSection">
                  <div class="sectionHeader">
                    <span>View:</span>
                    <a class="helpHeaderLink" href="javascript:;" id="allHelp" style="color: black; font-weight: bold; text-decoration: none; cursor: default;"><strong>All</strong></a>
                    <a class="helpHeaderLink" href="javascript:;" id="letterA">A</a>
                    <a class="helpHeaderLink" href="javascript:;" id="letterB">B</a>
                    <a class="helpHeaderLink" href="javascript:;" id="letterC">C</a>
                    <a class="helpHeaderLink" href="javascript:;" id="letterD">D</a>
                    <a class="helpHeaderLink" href="javascript:;" id="letterE">E</a>
                    <a class="helpHeaderLink" href="javascript:;" id="letterF">F</a>
                    <a class="helpHeaderLink" href="javascript:;" id="letterG">G</a>
                    <a class="helpHeaderLink" href="javascript:;" id="letterH">H</a>
                    <a class="helpHeaderLink" href="javascript:;" id="letterI">I</a>
                    <a class="helpHeaderLink" href="javascript:;" id="letterJ">J</a>
                    <a class="helpHeaderLink" href="javascript:;" id="letterK">K</a>
                    <a class="helpHeaderLink" href="javascript:;" id="letterL">L</a>
                    <a class="helpHeaderLink" href="javascript:;" id="letterM">M</a>
                    <a class="helpHeaderLink" href="javascript:;" id="letterN">N</a>
                    <a class="helpHeaderLink" href="javascript:;" id="letterO">O</a>
                    <a class="helpHeaderLink" href="javascript:;" id="letterP">P</a>
                    <a class="helpHeaderLink" href="javascript:;" id="letterQ">Q</a>
                    <a class="helpHeaderLink" href="javascript:;" id="letterR">R</a>
                    <a class="helpHeaderLink" href="javascript:;" id="letterS">S</a>
                    <a class="helpHeaderLink" href="javascript:;" id="letterT">T</a>
                    <a class="helpHeaderLink" href="javascript:;" id="letterU">U</a>
                    <a class="helpHeaderLink" href="javascript:;" id="letterV">V</a>
                    <a class="helpHeaderLink" href="javascript:;" id="letterW">W</a>
                    <a class="helpHeaderLink" href="javascript:;" id="letterX">X</a>
                    <a class="helpHeaderLink" href="javascript:;" id="letterY">Y</a>
                    <a class="helpHeaderLink" href="javascript:;" id="letterZ">Z</a>
                  </div>
                  <div class="section">
                    <div id="scrollbar">
                      <div class="scrollbar" style="height: 586px;"><div class="track" style="height: 586px;"><div class="thumb" style="top: 0px; height: 161px;"><div class="end"></div></div></div></div>
                      <div class="viewport">
                        <div class="overview" style="top: 0px;">
                          <c:set var="letter_list" value="A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z"/>
                          <c:forEach items="${fn:split(letter_list, ',')}" var="item">
                            <c:set var="help_title_start_letter" value="${item}"/>
                            <%@ include file="/WEB-INF/pages/admin/includes/help_item.jsp" %>
                          </c:forEach>
                        </div>
                      </div>
                    </div>
                    <div class="clearFixed"></div>
                  </div>
                  <!-- /.section -->
                  <div class="bl"></div>
                  <div class="br"></div>
                </div>
              </div>
              <!-- /#helpTopicsPanel -->
            </div>
          </div>
        </div>
      </div>
      <!-- /#mainContent -->

      <h:handlebars template="includes/footer" context="${pageContext}"/>
    </div>
    <!-- /#wrapper -->
  </body>
</html>
