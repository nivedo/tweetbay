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
});