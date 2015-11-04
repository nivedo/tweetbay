$(function() {
  document.addEventListener("page:restore", function() {
    app.init();
  });
  Dropzone.autoDiscover = false;
  $("#media-dropzone").dropzone({
    url: "/image_contents",
    addRemoveLinks: false,
    createImageThumbnails: false,
    success: function (file, response) {
      file.previewElement.classList.add("dz-success");
      console.log(response.attachment);
      $('#media-dropzone').css('background-image', 'url(' + response.attachment.url + ')');
      $('#content-image').val( response.attachment.url )
      $('.dz-message').hide()
    },
    complete: function(file) {
      this.removeFile(file);
    },
    error: function (file, response) {
      file.previewElement.classList.add("dz-error");
    }
  });

  $('html').click(function() {
    if($('.modal-wrapper').is(":visible")) {
      $('.modal-wrapper').toggle();
    }
    if($('.dropdown').is(":visible")) {
      $('.dropdown').toggle();
    }
  });

  $('.modal-trigger').click(function(){
    $('#modal-wrapper').toggle();
  });

  $('#demo-trigger').click(function(){
    if(!$('.demo-message').is(":visible")) {
      $('.demo-message').slideToggle("fast");
    }
  });

  $('#dropdown-toggle').click(function(){
    $('.dropdown').toggle();
  });

  $('.modal-body, .modal-trigger').click(function(event){
    event.stopPropagation();
  });

  $('.dropdown, #dropdown-toggle').click(function(event){
    if($('.dropdown').is(":visible")) {
      event.stopPropagation();
    }
  });

  $('.datepicker').pikaday({ minDate: moment().toDate() });
});
