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


    // $(document).on('click', '.user_btn',function (e) {
    //     let btn = this
    //     console.log(btn.innerText)
    //     e.preventDefault()
    //     if(btn.innerText == "Follow") {
    //         $.post("/api/v1/follows", {
    //             current_user_id: $(this).parent().parent().attr("data-userid"),
    //             follow_user_id: $(this).attr("id")
    //         }, function (data, status) {
    //             $(btn).text("Unfollow");
    //         })
    //     }else if(btn.innerText == "Unfollow"){
    //         $.delete("/api/v1/follows/"+Math.random()*10, {
    //             current_user_id: $(this).parent().parent().attr("data-userid"),
    //             follow_user_id: $(this).attr("id")
    //         }, function (data, status) {
    //             if(($(btn).data("followingbtn"))) {
    //                 alert($(btn).data("userid"))
    //                 loadDataFollowing($(btn).data("userid"))
    //             }else {
    //                 $(btn).text("Follow");
    //             }
    //         })
    //     }
    // })

    // function sfa() {
    //     var u_btn = document.getElementById(follow_user.id);
    //     console.log(u_btn);
    //     u_btn.addEventListener('ajax:success', function (event) {
    //
    //         if (u_btn.innerText == "Follow") {
    //             $.post("/api/v1/follows", {
    //                 current_user_id: $(this).parent().parent().attr("data-userid"),
    //                 follow_user_id: $(this).attr("id")
    //             }, function (data, status) {
    //                 u_btn.innerHTML = "Unfollow"
    //             })
    //         } else if (u_btn.innerText == "Unfollow") {
    //             $.delete("/api/v1/follows/" + Math.random() * 10, {
    //                 current_user_id: $(this).parent().parent().attr("data-userid"),
    //                 follow_user_id: $(this).attr("id")
    //             }, function (data, status) {
    //                 if ($(this).data("followingbtn")) {
    //                     loadDataFollowing($(this).data("userid"))
    //                 } else {
    //                     u_btn.innerHTML = "Follow"
    //                 }
    //             })
    //         }
    //     })
    // }

    // function isfollowing(current_user_id, follow_user) {
    //     if (current_user_id != follow_user.id) {
    //         var value;
    //         var method;
    //         var url;
    //         $.post("api/v1/isfollowing", {
    //             current_user_id: current_user_id,
    //             follow_user_id: follow_user.id
    //         }, function (data, status) {
    //             if (data.data == true) {
    //                 value = "Unfollow";
    //                 method = "delete";
    //                 url = "/api/v1/follows/" + Math.random() * 10;
    //             } else {
    //                 value = "Follow";
    //                 method = "post";
    //                 url = "/api/v1/follows/"
    //             }
    //             $.get("/api/v1/users/" + follow_user.id + "/avatar_image_thumbnail", function (image, status) {
    //                 var link;
    //                 if (image.link != null) {
    //                     link = image.link
    //                 } else {
    //                     link = "http://www.gravatar.com/avatar?s=50"
    //                 }
    //                 $('#user_list').append('<div class="single_user"><div class="card border-dark mb-3" style="min-width: 16rem;">\n' +
    //                     '  <div class="card-body text-dark image_card" data-userid="' + current_user_id + '">\n' +
    //                     '     <div><img src="' + link + '" style="border-radius: 50%"/></div><div><a href="/profile/users/' + follow_user.id + '" ><h5 class="card-title">' + follow_user.name + '</h5></a>\n' +
    //                     '    <button type="button" id=' + follow_user.id + ' class="btn btn-primary submit user_btn" data-remote="true" data-method="'+ method +'" data-url="'+ url +'" data-params="current_user_id=' + current_user_id + '&follow_user_id=' + follow_user.id + '">' + value + '</button>\n' +
    //                     '  </div>\n' +
    //                     '</div></div></div>')
    //             }).done(function(){
    //                 var u_btn = document.getElementById(follow_user.id);
    //                 u_btn.addEventListener('ajax:success', function (event) {
    //                     if (u_btn.innerText == "Follow") {
    //                         u_btn.innerHTML = "Unfollow";
    //                         u_btn.data("method", "delete");
    //                         u_btn.data("url","/api/v1/follows/" + Math.random() * 10);
    //                     } else if (u_btn.innerText == "Unfollow") {
    //                         u_btn.innerHTML = "Follow";
    //                         u_btn.data("method", "post");
    //                         u_btn.data("url","/api/v1/follows/");
    //                     }
    //                 })
    //             })
    //         })
    //     }
    // }

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