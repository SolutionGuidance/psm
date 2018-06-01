window.addEventListener("load", function drawDraftsLineGraph() {
  "use strict";
  var reportJson = reportUtils.tableToJson($(".reportTable"));

  var points = reportJson.reduce(
    reportUtils.extractPoints.bind(undefined, "month", "documents"),
    []
  );

  var color = d3.schemeCategory10[0];

  var lines = [reportUtils.makeLineData("Reviewed Documents", color, points)];

  reportUtils.drawMonthsLineGraph(
    "#reviewedDocumentsLineGraph",
    "",
    "Reviewed Documents",
    lines,
    reportUtils.getAxisDomains(lines)
  );
});
