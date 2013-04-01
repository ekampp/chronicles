#= require jquery
#= require jquery_ujs
#= require jquery.isotope
#= require jquery.anchor
#= require jquery.prettyPhoto
#= require bootstrap
#= require bootstrap.fileupload
#= require_tree .

jQuery ->

  # Contact
  $("footer").css({ "max-height": "55px" })
  $("footer").mouseover ->
    $("footer").css({ "max-height": "330px" })
  $("footer").mouseout ->
    $("footer").css({ "max-height": "55px" })

  # Anchor Link
  $("a.anchorLink").anchorAnimate()

  # Scroll spy
  $('.navbar').scrollspy()
