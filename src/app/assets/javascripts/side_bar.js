
$(".sidebar-dropdown > a").click(function() {
  $(".sidebar-submenu").slideUp(200);
  if (
    $(this)
      .parent()
      .hasClass("active")
  ) {
    $(".sidebar-dropdown").removeClass("active");
    $(this)
      .parent()
      .removeClass("active");
  } else {
    $(".sidebar-dropdown").removeClass("active");
    $(this)
      .next(".sidebar-submenu")
      .slideDown(200);
    $(this)
      .parent()
      .addClass("active");
  }
});

var windowWidth = $(window).width();
var windowSm = 768;
if (windowWidth <= windowSm) {
  document.addEventListener("turbolinks:load", function () {
    $("#close-sidebar").click(function() {
      $(".page-wrapper").removeClass("toggled");
    });
  });
  document.addEventListener("turbolinks:load", function () {
    $("#show-sidebar").click(function() {
      $(".page-wrapper").addClass("toggled");
    });
  });
} else {

}

