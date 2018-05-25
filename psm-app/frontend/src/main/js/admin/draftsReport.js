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

  var lines = [
    reportUtils.makeLineData("Draft Applications", "#0d4478", draftsPoints),
  ];

  reportUtils.drawMonthsLineGraph(
    "#draftApplicationsLineGraph",
    "",
    "Draft Applications",
    lines,
    reportUtils.getAxisDomains(lines)
  );
});
