function reportTableToJson (table) {
  data = [];
  $(table).find(".reportRow").each(function(idx, row) {
    var dataEntry = {};
    $(row).find(".reportDatum").each(function(idx, datum) {
      dataEntry[$(datum).attr("reportField")] = $(datum).attr("reportValue");
    });
    data.push(dataEntry);
  });

  return data;
}
