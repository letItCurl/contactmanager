// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
import "@fortawesome/fontawesome-free/js/all";
require("popper.js");
require("jquery");
require("jquery-ui");
require("bootstrap");

jQuery(function($){
  var autoComplete = function() {
    $('#term').autocomplete({
        source: "/contacts/autocomplete",
        minLength: 1,
        select: function (event, ui) {
            $('#term').val(ui.item.value)
            //$(this).closest('form').submit()
        }
    })
  }
  
  var showGroupBtn = function() {
      $("#add-new-group").hide();
      $('#add-group-btn').click(function () {      
        $("#add-new-group").slideToggle(function() {
          $('#new_group').focus();
        });
        return false;
      });
  }
  var sendGroupBtn = function() {
    $('#save-group-btn').click(function (event) { 
      event.preventDefault()
      var newGroup = $('#add-new-group').find('.input-group')
      $.ajax({
        url: "/groups/create",
        method: "post",
        data: { 
          group: {name: $('#new_group').val()} 
        },
        success: function(group){
          if (group.id != null) {
            newGroup.next('.text-danger').remove()
          }
          var newOption = $('<option/>').attr('value', group.id).attr('selected', true).text(group.name)
          $('#contact_group_id').append(newOption)
          $('#new_group').val("")
          //$("#add-new-group").hide(200)
        },
        error: function(xhr){
          var errors = xhr.responseJSON
          var error = errors.join(" ,")
          if (error) {
            newGroup.next('.text-danger').detach()
            newGroup.after('<p class="text-danger">'+error+'</p>')
          }
        }
      })
    })
  }
  
  document.addEventListener('turbolinks:load', showGroupBtn)
  document.addEventListener('turbolinks:load', autoComplete)
  document.addEventListener('turbolinks:load', sendGroupBtn)

})

