$(document).ready(function () {
    $('form.js-subscribe-category').submit(function (e) {
        e.preventDefault();
        e.stopImmediatePropagation();

        let $btn = $(this).find('input[type="submit"]');
        let $form = $(this);

        $.ajax({
            dataType: 'JSON',
            method: 'POST',
            url: $form.attr('action'),
            success: function (category) {
                $btn.removeClass('btn-primary').val('Unsubscribe');
                //alert(JSON.stringify(category))

                $form.attr(JSON.stringify(category['subscribed_path']))
            },
            error: function (error) {
                alert(error)
            }
        });
    });


    $('form.js-unsubscribe-category').submit(function (e) {
        e.preventDefault();
        e.stopImmediatePropagation();

        let $btn = $(this).find('input[type="submit"]');
        let $form = $(this);

        $.ajax({
            dataType: 'JSON',
            method: 'DELETE',
            url: $(this).attr('action'),
            success: function (category) {
                $btn.addClass('btn-primary').val('Subscribe');
                $form.attr(JSON.stringify(category['unsubscribed_path']))
            },
            error: function (error) {
                alert(error)
            }
        });
    });
});