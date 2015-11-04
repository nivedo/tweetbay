$(function() {
  function validateInputs(fields) {
    var errors = false;
    $reqs = fields.find('.req');
    $reqs.removeClass('field-error');
    $reqs.removeClass('field-success');

    $reqs.each(function(){
      if($(this).val() == '' || $(this).val() == 'nil') {
        $(this).addClass('field-error');
        errors = true;
      } else {
        $(this).addClass('field-success');
      }
    });

    return errors;
  }

  $('.submit').click(function(event){
    $curpart = $(this).closest('fieldset');
    if(validateInputs($curpart)) {
      event.preventDefault();
      return false;
    }
  });

  $('.req').change(function(event){
    event.preventDefault();
    $(this).removeClass('field-success');
    $('.req').each(function(){
      if($(this).val() != '' || $(this).val() == 'nil') {
        $(this).removeClass('field-error');
        $(this).addClass('field-success');
      }
    });
    return false;
  });

  $('#populate').click(function(event) {
    event.preventDefault();
    $curpart = $(this).closest('fieldset');
    if(!validateInputs($curpart)) {
      console.log("populate valid");
      $('#card-title')[0].innerHTML = $('#title').val();
      $('#buynow-price')[0].innerHTML = '$' + parseFloat($('#price').val()).toFixed(2)
      $('#buynow-merchant')[0].innerHTML = 'TweetBay'
      // console.log($('#title').val());
      // console.log($('#card-title')[0].innerHTML);
      var bg = $('#media-dropzone').css('background-image');
      var bg_url = bg.replace('url(','').replace(')','');
      // console.log(bg);
      // console.log(bg_url);
      $('#card-image').attr('src', bg_url);
      // $('.preview-container')[0].style.display = "block";
      $('#modal-wrapper').toggle();
      event.stopPropagation();
    }
    return true;
  });
})
