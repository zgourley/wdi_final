// $(document).on('page:change', function(){
//     $('.pagination a').on('click', function(event){
//         $.get(this.href, null, null, 'script');
//         event.preventDefault();
//     })
// });

$(document).on('page:update', function(){
    $('#spinner').hide();

    $('.pagination a').on('click', function(event){
        $('#books-partial').hide();
        $('#spinner').show();
        $.get(this.href, null, null, 'script');
        event.preventDefault();
    })
});
