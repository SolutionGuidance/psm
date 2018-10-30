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
 The modal jsp for deleting user account.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>

<!-- /#modalBackground-->
<div id="modalBackground"></div>
<div id="new-modal">
    <!-- /#deleteUserAccountModal-->
    <div id="deleteUserAccountModal" class="outLay">
        <div class="inner">
            <!-- title -->
            <div class="modal-title">
                <div class="right">
                    <div class="middle">
                        <button class="closeModal" title="Close" aria-label="Close"></button>
                        <h2>Delete User Account</h2>
                    </div>
                </div>
            </div>
            <!-- End .modal-title -->

            <!-- content -->
            <div class="modal-content">
                <div class="right">
                    <div class="middle">
                        <p>Are you sure you want to delete <span class="deleteAccountSpan">this user account</span>?</p>
                        <div class="buttonArea">
                            <a href="javascript:;" class="purpleBtn closeModal okBtn linkRight" id="deleteBtn">Yes, delete</a>
                            <a href="javascript:;" class="greyBtn closeModal">No, retain <span class="deleteAccountSpan">this user account</span> and cancel deletion</a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End .content -->
            <div class="modal-footer">
                <div class="right">
                    <div class="middle"></div>
                </div>
            </div>
        </div>
    </div>
    <!-- /#deleteUserAccountModal-->
</div>
