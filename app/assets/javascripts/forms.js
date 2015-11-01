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
})