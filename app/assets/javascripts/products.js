$(document).ready(function() {
  $(".product-thumbs span a").mouseenter(function() {
    var newImage = $(this).parent().find("div a").clone().fancybox();
    $("#main-product-image a").replaceWith(newImage);
  });
  
  $("a[rel=product-images]").fancybox();
});