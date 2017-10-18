<%-- This file renders one help item. --%>
<div class="row row{{help_title_start_letter}}">
    <strong>{{help_title_start_letter}}</strong>
    <ul>
        <c:forEach items="${helpItems}" var="item">
            <c:if test="${fn:startsWith (fn:toUpperCase(item.title), help_title_start_letter)}">
                <li><a href="{{ctx}}/agent/enrollment/viewHelpItem?helpItemId={{item.id}}">{{item.title}}</a></li>
            </c:if>
        </c:forEach>
    </ul>
</div>
