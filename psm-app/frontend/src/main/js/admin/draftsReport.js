"use strict";

var reportJson = reportTableToJson($(".reportTable"));

var monthCounts = getDateCounts("month", reportJson);

drawMonthsLineGraph(
  "#draftApplicationsLineGraph",
  "Draft Applications",
  monthCounts
);
