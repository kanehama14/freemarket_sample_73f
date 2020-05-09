$(document).on('turbolinks:load', function() {
  $('.o3imglist').click(function () {
    let $src = $(this).attr('src');
    $('.o3mainimg').attr('src', $src);
  });
});