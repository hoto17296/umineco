import $ from 'jquery'

const Modal = {

  open: function(id) {
    $('#modal').show();
    var $container = $('#modal .container');
    var content = $('#'+id).clone(true);
    $container.find('.content').empty().append(content);
    var title = content.data('title');
    $container.find('header .title').empty().append(title);
  },

  close: function() {
    $('#modal').hide();
    $('#modal .content').empty();
  },

};

window.Modal = Modal;
export default Modal;
