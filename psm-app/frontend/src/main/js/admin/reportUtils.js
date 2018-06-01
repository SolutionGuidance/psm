var reportUtils = (function makeReportUtils() {
  "use strict";

  function tableToJson(table) {
    var data = [];
    $(table)
      .find(".reportRow")
      .each(function handleRow(idx, row) {
        var dataEntry = {};
        $(row)
          .find(".reportDatum")
          .each(function handleDatum(idx, datum) {
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
      31,
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
    return reportJson.reduce(function toDateCounts(dateCounts, datum) {
      // datum is an object that contains one unit of report data (e.g. a draft
      // application in a given month).  It typically represents one row of a
      // report table.
      var d = datum[dateField];
      dateCounts[d] ? (dateCounts[d] += 1) : (dateCounts[d] = 1);
      return dateCounts;
    }, {});
  }

  /**
   * Used to extract data from a report JSON object into an array of point
   * objects.  Use .bind() to supply the xKey and yKey, then the resulting
   * function can be used with .reduce() on the report data JSON object.
   * @param xKey string The key for accessing X-axis data.
   * @param yKey string The key for accessing Y-axis data.
   * @param points array Point objects are added to this array.
   * @param datum object An object containg data from a report table row.
   */
  function extractPoints(xKey, yKey, points, datum) {
    var point = {
      x: datum[xKey],
      y: Number(datum[yKey]),
    };
    points.push(point);
    return points;
  }

  /**
   * @param label string  Label for the line.
   * @param color string  A CSS color value.
   * @param points array  An array of points objects.
   * @return An object containing data for a line to be drawn on a line graph.
   */
  function makeLineData(label, color, points) {
    return {
      label: label,
      color: color,
      points: points,
    };
  }

  /**
   * @param line  A line data object (see makeLineData).
   * @return An array of point objects for the line.
   */
  function getPoints(line) {
    return line.points;
  }

  /**
   * @param points An array of point objects.
   * @return An array of the X coordinates for those points.
   */
  function getXs(points) {
    return points.map(function getX(point) {
      return point.x;
    });
  }

  /**
   * @param points An array of point objects.
   * @return An array of the Y coordinates for those points.
   */
  function getYs(points) {
    return points.map(function getY(point) {
      return point.y;
    });
  }

  function getMin(array) {
    return d3.min(array);
  }

  function getMax(array) {
    return d3.max(array);
  }

  /**
   * @param allXs Array of arrays of X coordinates.
   * @return The smallest X coordinate.
   */
  function getMinX(allXs) {
    var minXs = allXs.map(getMin);
    return d3.min(minXs);
  }

  /**
   * @param allXs Array of arrays of X coordinates.
   * @return The largest X coordinate.
   */
  function getMaxX(allXs) {
    var maxXs = allXs.map(getMax);
    return d3.max(maxXs);
  }

  /**
   * @param allYs Array of arrays of Y coordinates.
   * @return The largest Y coordinate.
   */
  function getMaxY(allYs) {
    var maxYs = allYs.map(getMax);
    return d3.max(maxYs);
  }

  /**
   * @param lines array  Contains line data objects (see the makeLineData
   *                     function) with color, label, array of points, etc.
   * @return object  Contains the domains (min and max values) for X and Y axes.
   */
  function getAxisDomains(lines) {
    var allPoints = lines.map(getPoints);
    var allXs = allPoints.map(getXs);
    var allYs = allPoints.map(getYs);

    var minX = getMinX(allXs);
    var maxX = getMaxX(allXs);
    var minY = 0;
    var maxY = getMaxY(allYs);

    return {
      xAxis: [addMonths(-1, new Date(minX)), addMonths(1, new Date(maxX))],
      yAxis: [minY, maxY + maxY * 0.1],
    };
  }

  /**
   * Add a line graph to the page for a range of months (the X axis).
   * @param elementId string  Id of what will be the parent element of the svg.
   * @param xAxisLabel string
   * @param yAxisLabel string
   * @param lines array  Contains line data objects (see the makeLineData
   *                     function) with color, label, array of points, etc.
   * @param axisDomains object  Contains domains for the X and Y axes.
   */
  function drawMonthsLineGraph(
    elementId,
    xAxisLabel,
    yAxisLabel,
    lines,
    axisDomains
  ) {
    var WIDTH = 960;
    var HEIGHT = 460;
    var MARGINS = {
      top: 20,
      right: 20,
      bottom: 20,
      left: 50,
    };

    // Clear loading message.
    $(".lineGraphContainer").empty();

    var root = d3
      .select(elementId)
      .append("svg")
      .attr("width", WIDTH)
      .attr("height", HEIGHT);

    var xScale = d3
      .scaleTime()
      .domain(axisDomains.xAxis)
      .range([MARGINS.left, WIDTH - MARGINS.right]);

    var yScale = d3
      .scaleLinear()
      .domain(axisDomains.yAxis)
      .range([HEIGHT - MARGINS.top, MARGINS.bottom]);

    // Render X and Y axes.

    var xAxis = d3.axisBottom(xScale).tickFormat(d3.timeFormat("%b %Y"));

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

    // Render lines.

    var lineFunction = d3
      .line()
      .x(function scaleX(point) {
        return xScale(new Date(point.x));
      })
      .y(function scaleY(point) {
        return yScale(point.y);
      });

    lines.forEach(function addLine(line) {
      root
        .append("path")
        .attr("d", lineFunction(line.points))
        .attr("stroke", line.color)
        .attr("stroke-width", 2)
        .attr("fill", "none");
    });

    // Render legend.

    var legend = d3
      .select(elementId)
      .append("div")
      .attr("class", "legend");

    lines.forEach(function addLegendItem(line) {
      var item = legend.append("div").attr("class", "legendItem");

      item
        .append("div")
        .attr("class", "legendColorSwatch")
        .attr("style", "background: " + line.color + ";");

      item
        .append("div")
        .attr("class", "legendItemText")
        .text(line.label);
    });
  }

  // Return an object that provides public access to certain functions.
  return {
    tableToJson: tableToJson,
    getDateCounts: getDateCounts,
    extractPoints: extractPoints,
    makeLineData: makeLineData,
    getAxisDomains: getAxisDomains,
    drawMonthsLineGraph: drawMonthsLineGraph,
  };
})();
