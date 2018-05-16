"use strict";

function reportTableToJson (table) {
  var data = [];
  $(table).find(".reportRow").each(function(idx, row) {
    var dataEntry = {};
    $(row).find(".reportDatum").each(function(idx, datum) {
      dataEntry[$(datum).attr("reportField")] = $(datum).attr("reportValue");
    });
    data.push(dataEntry);
  });

  return data;
}

// Date arithmetic utilities

function isLeapYear(year) {
  return (year % 4 === 0 && year % 100 !== 0) || year % 400 === 0;
}

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

function addMonths(toAdd, date) {
  var dayOfTheMonth = date.getDate();
  date.setDate(1);
  date.setMonth(date.getMonth() + toAdd);
  date.setDate(Math.min(dayOfTheMonth, getDaysInMonth(date)));
  return date;
}
