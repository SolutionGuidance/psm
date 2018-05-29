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

  var lines = [
    reportUtils.makeLineData("Median", "orange", medianPoints),
    reportUtils.makeLineData("Mean", "#0d4478", meanPoints),
  ];

  reportUtils.drawMonthsLineGraph(
    "#timeToReviewLineGraph",
    "",
    "Time to Review in Days (Mean in Blue and Median in Orange)",
    lines,
    reportUtils.getAxisDomains(lines)
  );
});
