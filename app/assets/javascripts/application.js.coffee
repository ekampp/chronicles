#= require jquery
#= require jquery.migrate
#= require jquery_ujs
#= require bootstrap
#= require bootstrap-fileupload
#= require redactor.min
#= require_tree .

jQuery ->

  # Standard redactor text field
  $(".redactor-standard").each ->
    $(this).redactor
      buttons: [ "bold", "italic", "unorderedlist", "orderedlist", "outdent", "indent", "alignment", "|", "link"]
