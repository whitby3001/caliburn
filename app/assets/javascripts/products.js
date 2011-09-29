$(document).ready(function() {
  $(".product-thumbs span a").mouseenter(function() {
    $('.product-thumbs span div a').attr('rel', 'main-product-images');
    var newImage = $(this).parent().find("div a").clone().fancybox();
    $("#main-product-image a").replaceWith(newImage);
    $(this).parent().find("div a").removeAttr('rel');
    $("a[rel=main-product-images]").fancybox();
  });
  
  $("a[rel=product-images]").fancybox();
  $("a[rel=main-product-images]").fancybox();
});