$(document).on 'turbolinks:load', ->
  return unless page.controller() == 'welcome' && page.action() == 'index'
  $('footer').append '<script>
   function isfollowing(current_user_id, follow_user) {
        if (current_user_id != follow_user.id) {
            var value;
            var method;
            var url;
            $.post("api/v1/isfollowing", {
                current_user_id: current_user_id,
                follow_user_id: follow_user.id
            }, function (data, status) {
                if (data.data == true) {
                    value = "Unfollow";
                    method = "delete";
                    url = "/api/v1/follows/" + Math.random() * 10;
                } else {
                    value = "Follow";
                    method = "post";
                    url = "/api/v1/follows/"
                }
                $.get("/api/v1/users/" + follow_user.id + "/avatar_image_thumbnail", function (image, status) {
                    var link;
                    if (image.link != null) {
                        link = image.link
                    } else {
                        link = "http://www.gravatar.com/avatar?s=50"
                    }
                    $(\'#user_list\').append(\'<div class="single_user"><div class="card border-dark mb-3" style="min-width: 16rem;">\\n\' +
                        \'  <div class="card-body text-dark image_card" data-userid="\' + current_user_id + \'">\\n\' +
                        \'     <div><img src="\' + link + \'" style="border-radius: 50%"/></div><div><a href="/profile/users/\' + follow_user.id + \'" ><h5 class="card-title">\' + follow_user.name + \'</h5></a>\\n\' +
                        \'    <button type="button" id=\' + follow_user.id + \' class="btn btn-primary submit user_btn" data-remote="true" data-method="\'+ method +\'" data-url="\'+ url +\'" data-params="current_user_id=\' + current_user_id + \'&follow_user_id=\' + follow_user.id + \'">\' + value + \'</button>\\n\' +
                        \'  </div>\\n\' +
                        \'</div></div></div>\')
                }).done(function(){
                    var u_btn = document.getElementById(follow_user.id);
                    u_btn.addEventListener(\'ajax:success\', function (event) {
                        if (u_btn.innerText == "Follow") {
                            u_btn.innerHTML = "Unfollow";
                            $(this).attr("data-method", "delete");
                            $(this).attr("data-url","/api/v1/follows/" + Math.random() * 10)
                        } else if (u_btn.innerText == "Unfollow") {
                            u_btn.innerHTML = "Follow";
                            $(this).attr("data-method", "post");
                            $(this).attr("data-url","/api/v1/follows/");
                        }
                    })
            })
        })
}
}


    var url = "/api/v1/users";
    $.get(url, function (data, status) {
        $("#user_list").empty();
        $.each(data.data, function (i, item) {
            isfollowing($(\'#user_list\').attr("data-userid"), item)
        })
    });




</script>'