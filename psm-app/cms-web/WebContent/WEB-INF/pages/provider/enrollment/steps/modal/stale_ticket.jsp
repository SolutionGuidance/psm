<%--
    JSP Fragment for common save as draft modal.

    @author j3_guile
    @version 1.0
 --%>
<!-- /#saveAsDraftModal-->
<div id="staleTicket" class="outLay">
    <div class="inner">
        <!-- title -->
        <div class="modal-title">
            <div class="right">
                <div class="middle">
                    <button class="closeModal" title="Close" aria-label="Close"></button>
                    <h2>ERROR</h2>
                </div>
            </div>
        </div>
        <!-- End .modal-title -->

        <!-- content -->
        <div class="modal-content">
            <div class="right">
                <div class="middle">
                    <p>The referenced profile has been modified by another user or system and this may not be showing the latest data.
                    Submission will not be allowed. Please create a new request using the latest profile information.</p>
                    <div class="buttonArea">
                        <a href="javascript:;" class="purpleBtn closeModal okBtn">OK</a>
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
