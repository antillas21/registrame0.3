// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
  $('table.companies-table').dataTable({
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": "/companies.json",
    "sPaginationType": "full_numbers"
  });

  //$('.paginate_button').addClass('btn');
  //$('span span.paginate_active').addClass('btn primary');
});
