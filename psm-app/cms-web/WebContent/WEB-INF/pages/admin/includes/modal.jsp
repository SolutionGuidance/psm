<%--
 Copyright (C) 2012 TopCoder Inc., All Rights Reserved.


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
