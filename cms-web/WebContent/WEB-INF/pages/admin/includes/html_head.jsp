<%--
  - Author: TCSASSEMBLER
  - Version: 1.0
  - Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
  -
  - Description: This page fragment is to be included to all pages.
  - It includes the CSS and JavaScript files.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    
    <title>${title}</title>
    <link rel="stylesheet" href="${ctx}/css/reset.css" type="text/css" media="all"/>
    <link rel="stylesheet" href="${ctx}/css/style.css" type="text/css" media="all"/>
    <link rel="stylesheet" href="${ctx}/css/jquery.ui.css" type="text/css" media="all"/>
	<link rel="stylesheet" href="${ctx}/js/chosen/chosen.css" type="text/css" media="all"/>
	<link rel="stylesheet" href="${ctx}/js/jwysiwyg/jquery.wysiwyg.css" type="text/css"/>
	
    <!--[if IE 7]>
    <link rel="stylesheet" href="${ctx}/css/style-ie7.css" type="text/css" />
    <![endif]-->
    <script type="text/javascript">
        var ctx = "${ctx}";
    </script>
    <script src="${ctx}/js/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="${ctx}/js/jquery.tablesorter.min.js" type="text/javascript"></script>
    <script src="${ctx}/js/jquery.tablesorter.widgets.js" type="text/javascript"></script>
    <script src="${ctx}/js/jquery.ui.core.js" type="text/javascript"></script>
    <script src="${ctx}/js/jquery.ui.widget.js" type="text/javascript"></script>
    <script src="${ctx}/js/jquery.ui.datepicker.js" type="text/javascript"></script>
    <script src="${ctx}/js/jquery.tinyscrollbar.min.js" type="text/javascript"></script>
    <script src="${ctx}/js/jquery.validate.min.js" type="text/javascript"></script>
    <script src="${ctx}/js/chosen/chosen.jquery.min.js" type="text/javascript"></script>
	<script src="${ctx}/js/jquery.maskedinput.min.js" type="text/javascript"></script>
	<script src="${ctx}/js/jwysiwyg/jquery.wysiwyg.js" type="text/javascript"></script>
	<script src="${ctx}/js/jwysiwyg/jquery.wysiwyg.js" type="text/javascript"></script>
	<script src="${ctx}/js/jwysiwyg/controls/wysiwyg.image.js" type="text/javascript"></script>
	<script src="${ctx}/js/jwysiwyg/controls/wysiwyg.link.js" type="text/javascript" ></script>
	<script src="${ctx}/js/jwysiwyg/controls/wysiwyg.table.js" type="text/javascript" ></script>
    <script src="${ctx}/js/admin/script.js" type="text/javascript"></script>
</head>

