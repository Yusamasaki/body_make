$(function() {
  // limits the number of categories
  $('#detail-association-insertion-point').on('cocoon:after-insert', function() {
    check_to_hide_or_show_add_link();
  });

  $('#detail-association-insertion-point').on('cocoon:after-remove', function() {
    check_to_hide_or_show_add_link();
  });

  check_to_hide_or_show_add_link();

  function check_to_hide_or_show_add_link() {
    if ($('#detail-association-insertion-point .nested-fields').length == 49) {
      $('#add-link').hide();
    } else {
      $('#add-link').show();
    }
  }
})
