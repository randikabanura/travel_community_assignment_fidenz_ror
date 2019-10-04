$(document).on 'turbolinks:load', ->
  return unless page.controller() == 'registrations' && page.action() == 'edit'
  $('footer').append '<script>
  function loadDataFollowers(user_id) {
        var value;
        var method;
        var url;
        Rails.ajax({
            url: "/api/v1/follows/" + $(\'#followers_tab\').attr("data-userid") + "/allfollowers",
            type: "GET",
            success: function (data) {
                $(".tab-pane#followers #followers_tab").empty();
                if(data.length === 0){
                  $(".tab-pane#followers #followers_tab").append(\'<h4>No followers to show</h4>\')
                }
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
                                value = "Unfollow";
                                method = "delete";
                                url = "/api/v1/follows/" + Math.random() * 10;
                            }
                            else {
                                value = "Follow";
                                method = "post";
                                url = "/api/v1/follows/";
                            }
                            $.get("/api/v1/users/" + data[i].id + "/avatar_image_thumbnail", function (image, status) {
                                var link;
                                if (image.link != null){
                                    link = image.link
                                    }
                                else{
                                    link = "http://www.gravatar.com/avatar?s=50"
                                    }

                                $(".tab-pane#followers #followers_tab").append(\'<div class="single_user"><div class="card mb-3" style="min-width: 16rem;">\\n\' +
                                    \'  <div class="card-body text-dark image_card" data-userid="\'+ user_id + \'">\\n\' +
                                    \'      <div><img src="\' + link + \'" style="border-radius: 50%"/></div><div><a href="/profile/users/\' + data[i].id + \'" ><h5 class="card-title">\' + data[i].name + \'</h5></a>\\n\' +
                                    \'    <button type="button" id=\' + (data[i].id) + \' class="btn btn-primary submit user_btn" data-remote="true" data-method="\'+ method +\'" data-url="\'+ url +\'" data-params="current_user_id=\' + user_id + \'&follow_user_id=\' + data[i].id + \'">\' + value + \'</button>\\n\' +
                                    \'  </div>\\n\' +
                                    \'</div></div></div>\')
                            }).done( function(){
                              var u_btn = document.getElementById(data[i].id);
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
                        }
                    })
                })
            }
        })
    }

    function loadDataFollowing(user_id) {
        var value;
        var method;
        var url;
        $.ajax({
            url: "/api/v1/follows/" + $(\'#following_tab\').attr("data-userid") + "/allfollowing",
            type: "GET",
            success: function (data) {
                value = "Unfollow";
                method = "delete";
                url = "/api/v1/follows/" + Math.random() * 10;
                $(".tab-pane#following #following_tab").empty();
                if(data.length === 0){
                  $(".tab-pane#following #following_tab").append(\'<h4>Please follow someone to see it in here</h4>\')
                }
                $.each(data, function (i) {
                console.log("dthcg"+ i);
                    $.get("/api/v1/users/" + data[i].id + "/avatar_image_thumbnail", function (image, status) {
                        var link;
                        if (image.link != null) {
                            link = image.link
                        }
                        else {
                            link = "http://www.gravatar.com/avatar?s=50"
                        }

                        $(".tab-pane#following #following_tab").append(\'<div class="single_user" id=\'+data[i].id+\'><div class="card  mb-3" style="min-width: 16rem;">\\n\' +
                            \'  <div class="card-body text-dark image_card" data-userid="\'+ user_id +\'">\\n\' +
                            \'     <div><img src="\' + link + \'" style="border-radius: 50%"/></div><div><a href="/profile/users/\' + data[i].id + \'" ><h5 class="card-title">\' + data[i].name + \'</h5></a>\\n\' +
                            \'    <button type="button" id=\' + data[i].id + \' class="btn btn-primary submit user_btn" data-followingbtn="1" data-userid="\'+ user_id +\'" data-remote="true" data-method="\'+ method +\'" data-url="\'+url+\'" data-params="current_user_id=\' + user_id + \'&follow_user_id=\' + data[i].id + \'">Unfollow</button>\\n\' +
                            \'  </div>\\n\' +
                            \'</div></div></div>\')
                    }).done( function(){
                      var following_tab = document.querySelector(\'button[id="\'+data[i].id+\'"]\');
                      following_tab.addEventListener(\'ajax:success\', function (event) {
                        loadDataFollowing(user_id);
            })
                    })
                })
            }
        })
    }
</script>'