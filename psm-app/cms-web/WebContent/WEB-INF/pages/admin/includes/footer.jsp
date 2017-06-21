<%--
 Copyright (C) 2012 TopCoder Inc., All Rights Reserved.

 @author TCSASSEMBLER
 @version 1.0

 The common footer for all the jsps of the application.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>

                    <!-- /.tabSection -->
                </div>
            </div>
            <!-- /#mainContent -->

            <%@include file="/WEB-INF/pages/includes/footer.jsp" %>
            
            <!-- #footer -->
            <div class="clear"></div>
        </div>
        <!-- /#wrapper -->
        <%@ include file="/WEB-INF/pages/admin/includes/modal.jsp" %>
        <input type="hidden" value="<c:url value='/admin/user/list' />" id="userAccountsURL" />
    </body>
</html>
<script type="text/javascript">
var ctx = "${ctx}";
var roles = "${role}";
var searchedResult = "${searchedResult}";
var searchFirstName = "${searchFirstName}";
</script>