module ApplicationHelper

  def user_avatar(user, size = 40)
    if user.avatar.attached?
          if !user.avatar.content_type.in?(%('image/jpeg image/png'))
            gravatar_url = "http://www.gravatar.com/avatar?s=#{size}"
            image_url(gravatar_url, alt: user.name)
          else
            user.avatar.variant(resize: "#{size}x#{size}!");
          end
    else
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
      image_url(gravatar_url, alt: user.name)
    end
  end

end
