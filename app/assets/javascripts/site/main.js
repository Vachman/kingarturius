$(function() {
  $('#navigation ul a:first').addClass('first');
  $('#navigation ul a:last').addClass('last');
  
  var myHeading = $('h1'),  
      myHeadingText = $(myHeading).html(),  
      myFullText = '<div class="hr after"></div><span>' + myHeadingText + '</span><div class="hr before"></div>';

  $(myHeading).html(myFullText);
  
  var myTextWidth = ($(myHeading).width() - $(myHeading).children('span').width()) / 2;
  $(myHeading).children('.hr').css({width: '' + (myTextWidth - 10) + 'px'});
  
  $('img').wrap('<div class="image_wrapper" />');
  $('.input_form select').wrap('<div class="styled-select" />');
  
  $('.image a.lightbox').lightBox();
});
