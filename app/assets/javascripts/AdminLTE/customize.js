
// Set all ajax request's header contain X-CSRF-Token for csrf authenticate.
$.ajaxSetup({
  headers: {
    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
  }
});