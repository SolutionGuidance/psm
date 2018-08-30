<!DOCTYPE html>
<%@page import="org.springframework.security.web.WebAttributes"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<html lang="en-US">
  <c:set var="title" value="Login"/>
  <h:handlebars template="includes/html_head" context="${pageContext}"/>
  <body>
    <div id="wrapper">
      <div id="header">
        <div class="contentWidth"></div>
        <!-- /.contentWidth -->
      </div>
      <!-- /#header -->

      <div id="mainContent">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <h:handlebars template="includes/banner" context="${pageContext}"/>
          </div>
          <!-- /.mainNav -->

          <%@ include file="/WEB-INF/pages/login_form.jsp" %>

        </div>
      </div>
      <!-- /#mainContent -->

      <h:handlebars template="includes/footer" context="${pageContext}"/>
    </div>
    <!-- /#wrapper -->
  </body>
</html>
