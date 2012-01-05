// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
  $('#attendee_state_name').autocomplete({
    source: '/states.json',
    minLength: 2
  });

  $('#attendee_country_name').autocomplete({
    source: '/countries.json',
    minLength: 2
  });

  $('#attendee_company_name').autocomplete({
    source: '/pages/companies_autocomplete.json',
    minLength: 2
  });

  $('table.attendees-table').dataTable({
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": "/attendees.json",
    "sPaginationType": "full_numbers"
  });
});
