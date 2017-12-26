<%--
 Copyright (C) 2012 TopCoder Inc., All Rights Reserved.

 @author TCSASSEMBLER
 @version 1.0

 The bottom pagination section for user accounts table.
--%>
<%@ include file="/WEB-INF/pages/admin/includes/taglibs.jsp" %>

<c:if test="${results.total > 0}">
<div class="tabFoot">
    <div class="tabR">
        <div class="tabM">
            <div class="pagination">
                <div class="left">
                    Displaying <strong>${(currentPageNumber-1)*results.pageSize+1}</strong> - <strong>
                    ${results.pageSize == -1 ? results.total : currentPageNumber*results.pageSize>results.total?results.total:currentPageNumber*results.pageSize}
                    </strong> of <strong>${total}</strong> User Accounts | Show:
                    <select title="Shown Accounts">
                        <option value="10" <c:if test="${results.pageSize eq 10}">selected="selected"</c:if>>10</option>
                        <option value="25" <c:if test="${results.pageSize eq 25}">selected="selected"</c:if>>25</option>
                        <option value="50" <c:if test="${results.pageSize eq 50}">selected="selected"</c:if>>50</option>
                        <option value="-1" <c:if test="${results.pageSize eq -1}">selected="selected"</c:if>>All</option>
                    </select>
                </div>
                <div class="right">
                  <div class="pagiBox">
                     <div class="pagi">
                        <c:if test="${(currentPageNumber ne 1)}">
                            <a href="#" class="prev">&lt;&lt; Prev</a>
                        </c:if>
                        <c:forEach var="i" begin="${startPageNum}" end="${endPageNum}" step="1">
                            <c:choose>
                                <c:when test="${i eq currentPageNumber }">
                                    <span class="pageNumber current">${i}</span>
                                </c:when>
                                <c:otherwise>
                                    <a href="#" class="page">${i}</a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <c:if test="${(currentPageNumber ne totalPageCount)  }">
                            <a href="#" class="next">Next &gt;&gt;</a>
                        </c:if>
                     </div>
                  </div>
                    <span class="floatR">Pages:</span>
                </div>
            </div>
            <!-- /.pagination -->
        </div>
    </div>
</div>
<!-- /.tabFoot -->
</c:if>
