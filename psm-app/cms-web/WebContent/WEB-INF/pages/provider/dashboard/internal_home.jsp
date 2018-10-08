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
<!DOCTYPE html>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="h" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html lang="en-US">
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
            <h:handlebars template="includes/banner" context="${pageContext}"/>
            <c:set var="activeTabProfile" value="true"/>
            <h:handlebars template="includes/nav" context="${pageContext}"/>
          </div>
          <div class="breadCrumb"></div>
          <h1>Account Setup</h1>
          <div class="tabSection">
            <div class="detailPanel">
              <div class="section" id="updateProfile">
                <div class="wholeCol">
                  <div class="row">
                    <h3>New Applications</h3>
                    <p>
                      You can now begin the application process.
                    </p>
                    <div class="">
                      <h:create-application-button cssClass="purpleBtn"/>
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
                        Get Profiles
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
