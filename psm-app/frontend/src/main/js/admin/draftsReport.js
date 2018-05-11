"use strict";

// Data processing

var reportJson = reportTableToJson($(".reportTable"));

var monthCounts = reportJson.reduce(function(result, item) {
  var month = item.month;
  result[month] ? (result[month] += 1) : (result[month] = 1);
  return result;
}, {});

var months = Object.keys(monthCounts);
var counts = months.map(function(month) {
  return monthCounts[month];
});

var maxDrafts = d3.max(counts);

var points = months.map(function(month) {
  return {
    month: month,
    drafts: monthCounts[month]
  };
});

var firstMonth = d3.min(months);
var lastMonth = d3.max(months);

// Rendering line graph

var WIDTH = 960;
var HEIGHT = 460;
var MARGINS = {
  top: 20,
  right: 20,
  bottom: 20,
  left: 50
};

var root = d3
  .select("#lineGraph")
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
  .x(function(d) {
    return xScale(new Date(d.month));
  })
  .y(function(d) {
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
  .text("Draft Applications");
