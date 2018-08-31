window.addEventListener("load", function drawProviderTypesLineGraph() {
  "use strict";

  // Parse the html tables into JSON data.
  // 'reportJson' becomes an array of objects with the keys 'month',
  // 'providerType', and 'applicationsReviewed'.
  var reportJson = [];
  $(".reportTable")
    .find(".tableData")
    .each(function handleTable(idx, tableWrapper) {
      var month = $(tableWrapper)
        .find(".tableTitle h2")
        .text();

      var reportRows = $(tableWrapper).find(".reportRow");
      if (reportRows.length === 0) {
        reportJson.push({ month: month });
      } else {
        reportRows.each(function handleRow(idx, row) {
          var dataEntry = {
            month: month,
          };

          $(row)
            .find(".reportDatum")
            .each(function handleDatum(idx, datum) {
              dataEntry[$(datum).attr("reportField")] = $(datum).attr(
                "reportValue"
              );
            });

          reportJson.push(dataEntry);
        });
      }
    });

  /**
   * Convert the data into an object that maps provider types to
   * objects that map months to provider type counts.
   * E.g. { "Dentist": { "2018-05-31": 4, ... }, ...}
   */
  var byType = reportJson.reduce(function toByType(result, d) {
    if (result[d.providerType]) {
      result[d.providerType][d.month] = Number(d.applicationsReviewed);
    } else if (d.providerType && d.applicationsReviewed) {
      var obj = {};
      obj[d.month] = Number(d.applicationsReviewed);
      result[d.providerType] = obj;
    }

    return result;
  }, {});

  var types = Object.keys(byType);

  /**
   * Add up the totals for each type, for sorting purposes.
   * @return array of arrays  E.g. [["Dentist", 12], ...]
   */
  var typeTotals = types.map(function getTotals(type) {
    var typeData = byType[type];
    var months = Object.keys(typeData);
    var total = months.reduce(function total(total, month) {
      var count = typeData[month];
      return total + count;
    }, 0);

    return [type, total];
  });

  // Sort by totals, descending.
  typeTotals.sort(function sortTypes(a, b) {
    return a[1] < b[1];
  });

  // Get the ten types with the largest totals, and sort them alphabetically.
  var topTen = typeTotals.slice(0, 9).sort(function sortAlphabetically(a, b) {
    return a[0] > b[0];
  });

  var months = reportJson.map(function getMonth(d) {
    return d.month;
  });

  // Generate line data for the top ten types.
  var lines = topTen.map(function makeLine(typeTotal, i) {
    var type = typeTotal[0];
    var points = months.map(function makePoints(month) {
      if (!byType[type][month]) {
        return { x: month, y: 0 };
      } else {
        return { x: month, y: byType[type][month] };
      }
    });

    var color = d3.schemeCategory10[i];

    return reportUtils.makeLineData(type, color, points);
  });

  reportUtils.drawMonthsLineGraph(
    "#providerTypesLineGraph",
    "",
    "Applications Reviewed",
    lines,
    reportUtils.getAxisDomains(lines)
  );

  if (typeTotals.length > 10) {
    d3.select(".legend")
      .append("div")
      .attr("class", "lineGraphNote")
      .text(
        "Only the ten most frequently reviewed provider types are shown on the graph."
      );
  }
});
