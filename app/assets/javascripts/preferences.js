// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){
  var qrcode_init = $('#preference_create_qrcode').attr("checked");
  if(qrcode_init != "checked") {
    $('.qrcode-fields input[type=checkbox]').attr("disabled", true);
  }

  var label_init = $('#preference_print_label').attr("checked");
  if(label_init != "checked") {
    $('.label-fields input[type=checkbox]').attr("disabled", true);
  }
});

$('#preference_create_qrcode').live('click', function(e) {
  var status = $(this).attr("checked");
  if(status != "checked") {
    $('.qrcode-fields input[type=checkbox]').attr("disabled", true);
  } else {
    $('.qrcode-fields input[type=checkbox]').removeAttr("disabled");
  }
});

$('#preference_print_label').live('click', function(e) {
  var status = $(this).attr("checked");
  if(status != "checked") {
    $('.label-fields input[type=checkbox]').attr("disabled", true);
  } else {
    $('.label-fields input[type=checkbox]').removeAttr("disabled");
  }
});

