
// Set all ajax request's header contain X-CSRF-Token for csrf authenticate.
$.ajaxSetup({
  headers: {
    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
  }
});

//The layout plugin manages the Adminlte's layout in case of css failure to reset the height or width of the content.
document.addEventListener('turbolinks:load', function(){
  $('body').layout('fix');
})