{{!-- This page renders the functions service navigation. --}}
<div class="tabHead">
  <div class="tabR">
    <div class="tabM">
      <a class="tab first {{#if functionsServiceActiveMenuProviderTypes}} active {{/if}}" href="{{ctx}}/admin/viewProviderTypes"><span class="aR"><span class="aM">Provider Types</span></span></a>
      <a class="tab {{#if functionsServiceActiveMenuScreeningSchedules}} active {{/if}}" href="{{ctx}}/admin/getScreeningSchedule"><span class="aR"><span class="aM">Screening Schedules</span></span></a>
      <a class="tab {{#if functionsServiceActiveMenuHelpTopics}} active {{/if}}" href="{{ctx}}/admin/searchHelp"><span class="aR"><span class="aM">Help Topics</span></span></a>
      <a class="tab {{#if functionsServiceActiveMenuAgreement}} active {{/if}}" href="{{ctx}}/admin/viewAgreementDocuments"><span class="aR"><span class="aM">Agreements &amp; Addendums</span></span></a>
      <a class="tab {{#if functionsServiceActiveMenuServiceAgents}} active {{/if}}" href="{{ctx}}/admin/viewAgents"><span class="aR"><span class="aM">Service Agents</span></span></a>
      {{#if functionsServiceActiveMenuProviderTypes }}<a href="{{ctx}}/admin/beginCreateProviderType" class="purpleBtn addProviderBtn"><span class="btR"><span class="btM">Add Provider Type</span></span></a>{{/if}}
    </div>
  </div>
</div>
