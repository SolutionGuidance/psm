window.addEventListener("load", function drawDraftsLineGraph() {
  "use strict";
  var reportJson = reportUtils.tableToJson($(".reportTable"));

  var pointsLimited = reportJson.reduce(
    reportUtils.extractPoints.bind(undefined, "month", "limited"),
    []
  );

  var pointsModerate = reportJson.reduce(
    reportUtils.extractPoints.bind(undefined, "month", "moderate"),
    []
  );

  var pointsHigh = reportJson.reduce(
    reportUtils.extractPoints.bind(undefined, "month", "high"),
    []
  );

  var colorLimited = d3.schemeCategory10[0];
  var colorModerate = d3.schemeCategory10[1];
  var colorHigh = d3.schemeCategory10[3];

  var lines = [
    reportUtils.makeLineData("Limited Risk", colorLimited, pointsLimited),
    reportUtils.makeLineData("Moderate Risk", colorModerate, pointsModerate),
    reportUtils.makeLineData("High Risk", colorHigh, pointsHigh),
  ];

  reportUtils.drawMonthsLineGraph(
    "#riskLevelsLineGraph",
    "",
    "Number of Applications",
    lines,
    reportUtils.getAxisDomains(lines)
  );
});
