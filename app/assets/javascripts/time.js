

$( document ).ready(function() {
  $( ".time" ).each(function( index ) {
    $( this ).text(moment($( this ).text()).fromNow());
  });
});
