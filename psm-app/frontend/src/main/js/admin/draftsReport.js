"use strict";

window.addEventListener("load", function () {
  var reportJson = reportTableToJson($(".reportTable"));

  var monthCounts = getDateCounts("month", reportJson);

  drawMonthsLineGraph(
    "#draftApplicationsLineGraph",
    "Draft Applications",
    monthCounts
  );
});
