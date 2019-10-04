$(document).on 'turbolinks:load', ->
  return unless page.controller() == 'profile' && page.action() == 'show'
  $('footer').append '<script>
  function loadUserDataFollowers(user) {
        var value;
        Rails.ajax({
            url: "/api/v1/follows/"+ user +"/allfollowers",
            type: "GET",
            success: function (data) {
                $(".tab-pane#followers #user_followers_tab").empty();
                if(data.length === 0){
                  $(".tab-pane#followers #user_followers_tab").append(\'<h4>No followers to show</h4>\')
                }
                $.each(data, function (i) {
                        $.get("/api/v1/users/" + data[i].id + "/avatar_image_thumbnail", function (image, status) {
                            var link;
                            if (image.link != null) {
                                link = image.link
                            }
                            else {
                                link = "http://www.gravatar.com/avatar?s=50"
                            }
                            $(".tab-pane#followers #user_followers_tab").append(\'<div class="single_user"><div class="card mb-3" style="min-width: 16rem;">\\n\' +
                                \'  <div class="card-body text-dark image_card">\\n\' +
                                \'     <div><img src="\' + link + \'" style="border-radius: 50%"/></div><div><a href="/profile/users/\' + data[i].id + \'" ><h5 class="card-title">\' + data[i].name + \'</h5></a>\\n\' +
                                \'  </div>\\n\' +
                                \'</div></div></div>\')
                        })
                    }
                )
            }
        })
    }

    function loadUserDataFollowing(user) {
        var value;
        Rails.ajax({
            url: "/api/v1/follows/"+ user +"/allfollowing",
            type: "GET",
            success: function (data) {
                $(".tab-pane#following #user_following_tab").empty();
                if(data.length === 0){
                  $(".tab-pane#following #user_following_tab").append(\'<h4>This user not following anyone at the moment</h4>\')
                }
                $.each(data, function (i) {
                    $.get("/api/v1/users/" + data[i].id + "/avatar_image_thumbnail", function (image, status) {
                        var link;
                        if (image.link != null) {
                            link = image.link
                        }
                        else {
                            link = "http://www.gravatar.com/avatar?s=50"
                        }
                        $(".tab-pane#following #user_following_tab").append(\'<div class="single_user"><div class="card mb-3" style="min-width: 16rem;">\\n\' +
                            \'  <div class="card-body text-dark image_card">\\n\' +
                            \'    <div><img src="\' + link + \'" style="border-radius: 50%"/></div><div><a href="/profile/users/\' + data[i].id + \'" ><h5 class="card-title">\' + data[i].name + \'</h5></a>\\n\' +
                            \'  </div>\\n\' +
                            \'</div></div></div>\')
                    })
                })
            }
        })
    }
</script>'