$(document).ready(function() {
  $(".best_in_place").best_in_place();
  $(".datetimepicker").datetimepicker({
    locale: "sv",
    format: "YYYY-MM-DD HH:mm"
  });
  $("#datetimepicker-opens").on("change.datetimepicker", event => {
    $("#datetimepicker-closes").datetimepicker("minDate", event.date);
  });
});
