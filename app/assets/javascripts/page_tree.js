$(document).ready(function(){

  $('.nested_sortable').nestedSortable({
    handle: 'span.handle',
    items: 'li',
    toleranceElement: '> div',
    tolerance: 'pointer',
    update: function(event, ui){
      $.post($(this).data("update-url"),$(this).nestedSortable('serialize'));
    },
    //maxlevels: 3
    placeholder: 'sortable_placeholder'
  });

});
