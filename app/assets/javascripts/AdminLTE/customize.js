
//Set all ajax request's header contain X-CSRF-Token for csrf authenticate.
$.ajaxSetup({
  headers: {
    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
  }
});

//The layout plugin manages the Adminlte's layout in case of css failure to reset the height or width of the content.
document.addEventListener('turbolinks:load', function(){
  $('body').layout('fix');
});

function postPreview(){
  $('#pre-btn').click(function () {
    if ($('#pre-area').is(":hidden")) {
      $.ajax({
        url: '/posts/preview',
        type: 'get',
        data: {content: $('#record-content').val()},
        success: function (data) {
          $('#pre-btn').toggleClass('disabled');
          $('#pre-area').html(data).toggle();
          $('#record-content').toggle();
        }
      });
    } else {
      $('#pre-btn').toggleClass('disabled');
      $('#record-content').toggle();
      $('#pre-area').toggle();
    }
  });
}

function uploadImage(){
  $('#file-upload-btn').click(function(){
    $('#file-upload-field').click();
  });

  $('#file-upload-field').change(function(){
    var formData = new FormData();
    formData.append('image', document.getElementById('file-upload-field').files[0]);
    $.post({
      url: '/photos',
      data: formData,
      processData: false,
      contentType: false,
      success: function(rsp){
        if(rsp['code'] == 100){
          var img_url = '![](' + rsp['data']['url'] + ')';
          var $content_area = $('#record-content');
          $content_area.val($content_area.val() + img_url);
        }
      }
    });
  })
}

document.addEventListener('turbolinks:load', postPreview);
document.addEventListener('turbolinks:load', uploadImage);
