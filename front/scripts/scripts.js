$(document).ready(function(){
  
  $(".navbar a, footer a[href='#myPage']").on('click', function(event) {

  if (this.hash !== "") {
  
    event.preventDefault();

    // Store hash
    var hash = this.hash;

    
    $('html, body').animate({
      scrollTop: $(hash).offset().top
    }, 900, function(){
    
    // Add hash (#) to URL when done scrolling (default click behavior)
    window.location.hash = hash;
    });
  } // End if
  });
  
  $(window).scroll(function() {
  $(".slideanim").each(function(){
    var pos = $(this).offset().top;

    var winTop = $(window).scrollTop();
    if (pos < winTop + 600) {
      $(this).addClass("slide");
    }
  });
  });


});

