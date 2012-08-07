$(document).ready(function(){

  $('.nested_sortable').nestedSortable({
    handle: 'span.handle',
    items: 'li',
    toleranceElement: '> div',
    tolerance: 'pointer',
    update: function(event, ui){
      $.post('pages/sort',$(this).nestedSortable('serialize'));
    },
    placeholder: 'sortable_placeholder'
  });

});
