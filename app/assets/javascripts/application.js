// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require bootstrap-datepicker
//= require activestorage
//= require turbolinks
//= require_tree .


$(function () {
    setTimeout(function () {
        $(".alert").fadeOut(1000, function () {
            $(".remove_alert").remove();
        })
    }, 3000);


    $(document).on('click', '.user_btn',function (e) {
        let btn = this
        console.log(btn.innerText)
        e.preventDefault()
        if(btn.innerText == "Follow") {
            $.post("/api/v1/follows", {
                current_user_id: $(this).parent().attr("data-userid"),
                follow_user_id: $(this).attr("id")
            }, function (data, status) {
                $(btn).text("Unfollow");
            })
        }else if(btn.innerText == "Unfollow"){
            $.delete("/api/v1/follows/"+Math.random()*10, {
                current_user_id: $(this).parent().attr("data-userid"),
                follow_user_id: $(this).attr("id")
            }, function (data, status) {
                if(($(btn).data("followingbtn"))) {
                    loadDataFollowing()
                }else {
                    $(btn).text("Follow");
                }
            })
        }
    })

    jQuery.each( [ "put", "delete" ], function( i, method ) {
        jQuery[ method ] = function( url, data, callback, type ) {
            if ( jQuery.isFunction( data ) ) {
                type = type || callback;
                callback = data;
                data = undefined;
            }

            return jQuery.ajax({
                url: url,
                type: method,
                dataType: type,
                data: data,
                success: callback
            });
        };
    });
});