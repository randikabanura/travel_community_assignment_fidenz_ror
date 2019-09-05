$(document).on 'turbolinks:load', ->
  return unless page.controller() == 'registrations' && page.action() == 'edit'
  $('footer').append '<script>
  function loadDataFollowers() {
        var value;
        Rails.ajax({
            url: "/api/v1/follows/" + $(\'#followers_tab\').attr("data-userid") + "/allfollowers",
            type: "GET",
            success: function (data) {
                $(".tab-pane#followers #followers_tab").empty();
                $.each(data, function (i) {
                    $.ajax({
                        type: "POST",
                        url: "/api/v1/isfollowing",
                        data: {
                            current_user_id: $(\'#followers_tab\').attr("data-userid"),
                            follow_user_id: data[i].id
                        },
                        success: function (data2) {
                            if (data2.data == true) {
                                value = "Unfollow"
                            }
                            else {
                                value = "Follow"
                            }
                            $.get("/api/v1/users/" + data[i].id + "/avatar_image_thumbnail", function (image, status) {
                                var link;
                                if (image.link != null){
                                    link = image.link
                                    }
                                else{
                                    link = "http://www.gravatar.com/avatar?s=50"
                                    }
                                $(".tab-pane#followers #followers_tab").append(\'<div class="single_user"><div class="card border-dark mb-3" style="min-width: 16rem;">\\n\' +
                                    \'  <div class="card-body text-dark image_card" data-userid="<%= current_user.id %>">\\n\' +
                                    \'      <div><img src="\' + link + \'" style="border-radius: 50%"/></div><div><a href="/profile/users/\' + data[i].id + \'" ><h5 class="card-title">\' + data[i].name + \'</h5></a>\\n\' +
                                    \'    <button type="button" id=\' + data[i].id + \' class="btn btn-primary submit user_btn">\' + value + \'</button>\\n\' +
                                    \'  </div>\\n\' +
                                    \'</div></div></div>\')
                            })
                        }
                    })
                })
            }
        })
    }

    function loadDataFollowing() {
        var value;
        Rails.ajax({
            url: "/api/v1/follows/" + $(\'#following_tab\').attr("data-userid") + "/allfollowing",
            type: "GET",
            success: function (data) {
                $(".tab-pane#following #following_tab").empty();
                $.each(data, function (i) {
                    $.get("/api/v1/users/" + data[i].id + "/avatar_image_thumbnail", function (image, status) {
                        var link;
                        if (image.link != null) {
                            link = image.link
                        }
                        else {
                            link = "http://www.gravatar.com/avatar?s=50"
                        }
                        $(".tab-pane#following #following_tab").append(\'<div class="single_user"><div class="card border-dark mb-3" style="min-width: 16rem;">\\n\' +
                            \'  <div class="card-body text-dark image_card" data-userid="<%= current_user.id %>">\\n\' +
                            \'     <div><img src="\' + link + \'" style="border-radius: 50%"/></div><div><a href="/profile/users/\' + data[i].id + \'" ><h5 class="card-title">\' + data[i].name + \'</h5></a>\\n\' +
                            \'    <button type="button" id=\' + data[i].id + \' class="btn btn-primary submit user_btn" data-followingbtn="1">Unfollow</button>\\n\' +
                            \'  </div>\\n\' +
                            \'</div></div></div>\')
                    })
                })
            }
        })
    }
</script>'