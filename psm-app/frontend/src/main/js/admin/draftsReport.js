"use strict";

window.addEventListener("load", function drawDraftsLineGraph() {
  var reportJson = reportTableToJson($(".reportTable"));
  var monthCounts = getDateCounts("month", reportJson);
  var months = Object.keys(monthCounts);

  var draftsPoints = months.map(function makePoints(month) {
    return {
      x: month,
      y: monthCounts[month],
    };
  });

  var lines = [makeLineData("Draft Applications", "#0d4478", draftsPoints)];

  drawMonthsLineGraph(
    "#draftApplicationsLineGraph",
    "",
    "Draft Applications",
    lines,
    getAxisDomains(lines)
  );
});
