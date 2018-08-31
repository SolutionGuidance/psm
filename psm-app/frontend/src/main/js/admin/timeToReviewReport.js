window.addEventListener("load", function drawTimeToReviewLineGraph() {
  "use strict";
  var reportJson = reportUtils.tableToJson($(".reportTable"));

  var medianPoints = reportJson.reduce(
    reportUtils.extractPoints.bind(undefined, "month", "medianReviewTime"),
    []
  );

  var meanPoints = reportJson.reduce(
    reportUtils.extractPoints.bind(undefined, "month", "meanReviewTime"),
    []
  );

  var meanColor = d3.schemeCategory10[0];
  var medianColor = d3.schemeCategory10[1];

  var lines = [
    reportUtils.makeLineData("Mean", meanColor, meanPoints),
    reportUtils.makeLineData("Median", medianColor, medianPoints),
  ];

  reportUtils.drawMonthsLineGraph(
    "#timeToReviewLineGraph",
    "",
    "Time to Review in Days",
    lines,
    reportUtils.getAxisDomains(lines)
  );
});
