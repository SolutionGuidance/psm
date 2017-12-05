<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- <c:out value="${pageScope['javax.servlet.jsp.jspPage']}"></c:out> -->
<html xmlns="http://www.w3.org/1999/xhtml" lang="en-US" xml:lang="en-US">
  <c:set var="title" value="Welcome"/>
  <h:handlebars template="includes/html_head" context="${pageContext}"/>
  <body>
    <div id="wrapper">
      <h:handlebars template="includes/header" context="${pageContext}"/>
      <!-- /#header -->

      <div id="mainContent">
        <div class="contentWidth">
          <div class="mainNav">
            <h:handlebars template="includes/logo" context="${pageContext}"/>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <div class="breadCrumb"></div>
          <h1>Account Setup</h1>
          <div class="tabSection">
            <div class="detailPanel">
              <div class="section" id="updateProfile">
                <div class="wholeCol">
                  <div class="row">
                    <h3>New Enrollments</h3>
                    <p>
                      You can now begin the enrollment process.
                    </p>
                    <div class="">
                      <h:create-enrollment-button cssClass="purpleBtn"/>
                    </div>
                  </div>
                </div>
              </div>
              <!-- /.section -->
              <div class="tl"></div>
              <div class="tr"></div>
              <div class="bl"></div>
              <div class="br"></div>
            </div>

            <!--
            Commented out the "Linked Profiles" section below because that
            functionality isn't enabled right now.  See commit f5d70d7bb93
            and any followup commits that refer to it.

            The commenting-out actually uses two separate comment blocks
            below, in order to avoid a comment nesting situation with the
            "/.section" comment that appears in the block.  The first block
            comments out the opening "div" element followed by a nested (but
            balanced) div block, and the second comments out four small
            balanced divs followed by the closing /div that corresponds to
            that first opening div.
            -->
            <!--
            <div class="detailPanel">
              <div class="section" id="updateProfile">
                <div class="wholeCol">
                  <div class="row">
                    <h3>Linked Profiles</h3>
                    <p>
                      You can link your online account to any existing profiles in partner services.
                    </p>
                    <div class="">
                      <a href="<c:url value="/provider/onboarding/link" />" class="purpleBtn">
                        <span class="btR">
                          <span class="btM">Get Profiles</span>
                        </span>
                      </a>
                    </div>
                  </div>
                </div>
              </div>
              -->
            <!-- /.section -->
            <!--
            <div class="tl"></div>
            <div class="tr"></div>
            <div class="bl"></div>
            <div class="br"></div>
          </div>
          -->
          </div>
          <!-- /.tabSection -->
        </div>
      </div>
      <!-- /#mainContent -->

      <h:handlebars template="includes/footer" context="${pageContext}"/>
      <div class="clear"></div>
    </div>
    <!-- /#wrapper -->
  </body>
</html>
