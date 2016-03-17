import $ from 'jquery'

const Modal = {

  open: function(id, opts) {
    $('#modal').show();
    // TODO 内容を入れる
  },

  close: function() {
    $('#modal').hide();
    $('#modal .content').empty();
  },

};

window.Modal = Modal;
export default Modal;
