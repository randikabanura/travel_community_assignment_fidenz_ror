$(document).on 'turbolinks:load', ->
  return unless page.controller() == 'welcome' && page.action() == 'index'
  $('footer').append '<script>
    function isfollowing(current_user_id, follow_user) {
        if(current_user_id!=follow_user.id) {
            var value;
            $.post("api/v1/isfollowing", {
                current_user_id: current_user_id,
                follow_user_id: follow_user.id
            }, function (data, status) {
                if (data.data == true){
                    value = "Unfollow"
                    }
                else{
                    value = "Follow"
                    }
                $.get("/api/v1/users/" + follow_user.id + "/avatar_image_thumbnail", function (image, status) {
                    var link;
                    if (image.link != null){
                        link = image.link
                        }
                    else{
                        link = "http://www.gravatar.com/avatar?s=50"
                        }
                    $(\'#user_list\').append(\'<div class="single_user"><div class="card border-dark mb-3" style="min-width: 16rem;">\\n\' +
                        \'  <div class="card-body text-dark image_card" data-userid="<%= current_user.id %>">\\n\' +
                        \'     <div><img src="\' + link + \'" style="border-radius: 50%"/></div><div><a href="/profile/users/\' + follow_user.id + \'" ><h5 class="card-title">\' + follow_user.name + \'</h5></a>\\n\' +
                        \'    <button type="button" id=\' + follow_user.id + \' class="btn btn-primary submit user_btn">\' + value + \'</button>\\n\' +
                        \'  </div>\\n\' +
                        \'</div></div></div>\')
                })
            })
        }
    }
    var url = "/api/v1/users";
    $.get(url, function (data, status) {
        $(\'#user_list\').empty();
        $.each(data.data, function (i, item) {
            isfollowing($(\'#user_list\').attr("data-userid"), item)
        });
    });
</script>'