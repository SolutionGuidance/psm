window.addEventListener("load", function drawDraftsLineGraph() {
  "use strict";
  var reportJson = reportUtils.tableToJson($(".reportTable"));
  var monthCounts = reportUtils.getDateCounts("month", reportJson);
  var months = Object.keys(monthCounts);

  var draftsPoints = months.map(function makePoints(month) {
    return {
      x: month,
      y: monthCounts[month],
    };
  });

  var color = d3.schemeCategory10[0];

  var lines = [
    reportUtils.makeLineData("Draft Applications", color, draftsPoints),
  ];

  reportUtils.drawMonthsLineGraph(
    "#draftApplicationsLineGraph",
    "",
    "Draft Applications",
    lines,
    reportUtils.getAxisDomains(lines)
  );
});
