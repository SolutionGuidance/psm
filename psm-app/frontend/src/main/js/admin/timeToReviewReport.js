"use strict";

window.addEventListener("load", function drawTimeToReviewLineGraph() {
  var reportJson = reportTableToJson($(".reportTable"));

  var medianPoints = reportJson.reduce(
    extractPoints.bind(undefined, "month", "medianReviewTime"),
    []
  );

  var meanPoints = reportJson.reduce(
    extractPoints.bind(undefined, "month", "meanReviewTime"),
    []
  );

  var lines = [
    makeLineData("Median", "orange", medianPoints),
    makeLineData("Mean", "#0d4478", meanPoints),
  ];

  drawMonthsLineGraph(
    "#timeToReviewLineGraph",
    "",
    "Time to Review in Days (Mean in Blue and Median in Orange)",
    lines,
    getAxisDomains(lines)
  );
});
