<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%--
    JSP Fragment for common NPI explanation modal.

 --%>
<!-- /#saveAsDraftModal-->
<div id="NPIdefinitionModal" class="outLay NPIdefinition definitionsModal">
    <div class="inner">
    <!-- title -->
        <div class="modal-title">
            <a href="javascript:;" class="greyBtn"><span class="btR">
                <span class="btM">
                    <img src="<c:url value="/i/icon-x.png" />" alt=""/>
		    Close
                </span>
            </span></a>

        <h2>NPI Definition</h2>
        </div>
    <!-- End .modal-title -->
    <!-- content -->
    <div class="modal-content">

        <div class="section">
            An <strong>NPI</strong> is a National Provider Identifier number.
            You can search NPIs or register for an NPI at <a href="https://nppes.cms.hhs.gov">NPPES
            (the National Plan &amp; Provider Enumeration System)</a>.
        </div>
        <!-- /#tabSection -->

        <div class="clear"></div>

    </div>
    <!-- End .content -->
</div>
