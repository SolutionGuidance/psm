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
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<div>
    <div class="tabContent" id="tabAgreement">
	    <div id="viewAgreementPanel">
		<div class="sideBorder">
		    <h3><c:out value="${agreementDocument.title}"/></h3>
		</div>
		<div class="newApplicationPanel">
		    <div class="section">
			<div class="wholeCol">
			    ${agreementDocument.text}
			</div>
		    </div>
		    <div class="bl"></div>
		    <div class="br"></div>
		</div>
	    </div>
	    <!-- /#viewAgreementPanel -->
	</div>
</div>
