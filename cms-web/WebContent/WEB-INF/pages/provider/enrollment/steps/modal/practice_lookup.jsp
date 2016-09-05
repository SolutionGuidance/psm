<%--
    JSP Fragment for common practice lookup modal.

    @author j3_guile
    @version 1.0
 --%>
<!-- /#practiceLookupModal-->
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<div id="practiceLookupModal" class="outLay">
    <div class="inner"> 
        <!-- title -->
        <div class="modal-title">
            <div class="right">
                <div class="middle">
                    <a href="javascript:;" class="closeModal"></a> 
                    <h2>Find Practice Data in Existing Record</h2>
                    
                </div>
            </div>
        </div>
        <!-- End .modal-title --> 

        <!-- content -->
        <div class="modal-content">
            <div class="right">
                <div class="middle">
                    <div class="searchRow">
                        <c:url var="lookupUrl" value="/provider/enrollment/lookup" />
                        <form action="${lookupUrl}" id="practiceLookupForm">
                        <span>
                            <label>Practice Name:</label>
                            <input type="hidden" name="agency" value="false"/>
                            <input type="text" class="normalInput inputL" name="name"/>
                        </span>
                        <span>
                            <label>NPI / UMPI:</label>
                            <input type="text" class="normalInput inputL" name="npi"/>
                        </span>
                        <span>
                            <label>City:</label>
                            <input type="text" class="normalInput inputM" name="city"/>
                        </span>
                        <span>
                            <label>State:</label>
                            <input type="text" class="normalInput inputM" name="state"/>
                        </span>
                        <span class="last">
                            <label>Zip:</label>
                            <input type="text" class="normalInput inputS" name="zip"/>
                        </span>
                        <div class="clear"></div>
                        </form>
                    </div>
                    <div class="buttonArea"> 
                        <a href="javascript:performPracticeLookup();" class="purpleBtn searchBtn"><span class="btR"><span class="btM"><span class="icon">Search</span></span></span></a> 
                    </div>
                    <div class="tableContainer hide">
                        <p><strong id="practiceLookupMatches">5 matching practices found:</strong></p>
                        <table cellpadding="0" cellspacing="0" class="generalTable tablesorter" id="draftTable">
                            <colgroup>
                                <col width="30" />
                                <col width="125" />
                                <col width="125" />
                                <col width="135" />
                                <col width="130" />
                                <col width="165" />
                                <col width="100" />
                            </colgroup>
                            <thead>
                                <tr class="tablesorter-header">
                                    <th class="alignCenter"><span class="sep"></span></th>
                                    <th class="alignCenter">Practice Name<span class="sep"></span></th>
                                    <th class="alignCenter">NPI / UMPI<span class="sep"></span></th>
                                    <th class="alignCenter">Address<span class="sep"></span></th>
                                    <th class="alignCenter">City<span class="sep"></span></th>
                                    <th class="alignCenter">State<span class="sep"></span></th>
                                    <th class="alignCenter">ZIP</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                        <div class="clear"></div>
                         <div class="buttonArea"> 
                            <a href="javascript:copySelectedPracticeData();" class="purpleBtn copySelectedPracticeDataBtn"><span class="btR"><span class="btM">Copy Selected Practice Data</span></span></a> 
                            <a href="javascript:;" class="greyBtn closeModal"><span class="btR"><span class="btM">Cancel</span></span></a> 
                        </div>
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
<!-- /#practiceLookupModal-->

<div class="hide">
	<table class="hide" id="practiceLookupTableTemplate">
	    <tbody>
	        <tr>
	            <td class="alignCenter"></td>
	            <td class="alignCenter"></td>
	            <td class="alignCenter"></td>
	            <td class="alignCenter"></td>
	            <td class="alignCenter"></td>
	            <td class="alignCenter"></td>
	            <td class="alignCenter"></td>
	        </tr>
	    </tbody>
	</table>

</div>
