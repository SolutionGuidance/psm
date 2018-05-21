"use strict";

function reportTableToJson(table) {
  var data = [];
  $(table)
    .find(".reportRow")
    .each(function (idx, row) {
      var dataEntry = {};
      $(row)
        .find(".reportDatum")
        .each(function (idx, datum) {
          dataEntry[$(datum).attr("reportField")] = $(datum).attr(
            "reportValue"
          );
        });

      data.push(dataEntry);
    });

  return data;
}

// Date arithmetic functions

/**
 * Determine if a year is a leap year.
 * @param year  An integer representing a year.
 * @return boolean
 */
function isLeapYear(year) {
  return (year % 4 === 0 && year % 100 !== 0) || year % 400 === 0;
}

/**
 * Return the number of days in a given month.
 * @param date  Date object representing a given month.
 * @return integer
 */
function getDaysInMonth(date) {
  var year = date.getFullYear();
  var month = date.getMonth();
  return [
    31,
    isLeapYear(year) ? 29 : 28,
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31
  ][month];
}

/**
 * Adds a number of months (positive or negative) to a JS date object (while
 * taking different lengths of months into account).
 * @param toAdd  A positive or negative integer.
 * @param date   A date object.
 * @return date object  The modified date object that was passed in.
 */
function addMonths(toAdd, date) {
  var dayOfTheMonth = date.getDate();
  date.setDate(1);
  date.setMonth(date.getMonth() + toAdd);
  date.setDate(Math.min(dayOfTheMonth, getDaysInMonth(date)));
  return date;
}

// Line graph functions

/**
 * Convert report data to a mapping from dates to positive integers.
 * @param dateField  The name of the date property (e.g. 'month').
 * @param reportJson  The report data.
 * @return object  Maps date strings (e.g. '2018-05-01') to positive integers.
 */
function getDateCounts(dateField, reportJson) {
  return reportJson.reduce(function (dateCounts, datum) {
    // datum is an object that contains one unit of report data (e.g. a draft
    // application in a given month).  It typically represents one row of a
    // report table.
    var d = datum[dateField];
    dateCounts[d] ? (dateCounts[d] += 1) : (dateCounts[d] = 1);
    return dateCounts;
  }, {});
}

/**
 * Draw a line graph showing a certain amount of something across a range of
 * months.
 * @param elementId string Id of what will become the parent element of the svg.
 * @param yAxisLabel string Label for the Y axis.
 * @param monthCounts object Maps a month string ('2018-05-01') to an integer.
 */
function drawMonthsLineGraph(elementId, yAxisLabel, monthCounts) {
  var months = Object.keys(monthCounts);
  var counts = months.map(function (month) {
    return monthCounts[month];
  });

  var maxDrafts = d3.max(counts);

  var points = months.map(function (month) {
    return {
      month: month,
      drafts: monthCounts[month]
    };
  });

  var firstMonth = d3.min(months);
  var lastMonth = d3.max(months);

  var WIDTH = 960;
  var HEIGHT = 460;
  var MARGINS = {
    top: 20,
    right: 20,
    bottom: 20,
    left: 50
  };

  var root = d3
    .select(elementId)
    .append("svg")
    .attr("width", WIDTH)
    .attr("height", HEIGHT);

  var xScale = d3
    .scaleTime()
    .domain([
      addMonths(-1, new Date(firstMonth)),
      addMonths(1, new Date(lastMonth))
    ])
    .range([MARGINS.left, WIDTH - MARGINS.right]);

  var yScale = d3
    .scaleLinear()
    .domain([0, maxDrafts + maxDrafts * 0.1])
    .range([HEIGHT - MARGINS.top, MARGINS.bottom]);

  var xAxis = d3.axisBottom(xScale).ticks(months.length, "%b %Y");

  var yAxis = d3.axisLeft(yScale);

  root
    .append("g")
    .attr("class", "xAxis")
    .attr("transform", "translate(0," + (HEIGHT - MARGINS.bottom) + ")")
    .call(xAxis);

  root
    .append("g")
    .attr("class", "yAxis")
    .attr("transform", "translate(" + MARGINS.left + ",0)")
    .call(yAxis);

  var lineFunction = d3
    .line()
    .x(function (d) {
      return xScale(new Date(d.month));
    })
    .y(function (d) {
      return yScale(d.drafts);
    });

  root
    .append("path")
    .attr("d", lineFunction(points))
    .attr("stroke", "#0d4478")
    .attr("stroke-width", 2)
    .attr("fill", "none");

  // Render the Y axis label. Due to the 90 degree rotation, the x and
  // y attributes have the opposite effect from what you'd expect.
  root
    .append("text")
    .attr("class", "y-axis-label")
    .attr("font-size", "10px")
    .attr("text-anchor", "middle")
    .attr("y", 20)
    .attr("dy", "0em")
    .attr("x", -(HEIGHT / 2))
    .attr("transform", "rotate(-90)")
    .text(yAxisLabel);
}
