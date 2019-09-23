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

  def trip_image(trip)
    if trip.photos.attached?
      if !trip.photos.content_type.in?(%('image/jpeg image/png'))
        default_image_url = "https://www.srilankatravelandtourism.com/activities-sri-lanka/railway-sri-lanka/train-tours-images/train-tours-1-sri-lanka.jpg"
        image_url(default_image_url)
      else
        trip.photos
      end
    else
      default_image_url = "https://www.srilankatravelandtourism.com/activities-sri-lanka/railway-sri-lanka/train-tours-images/train-tours-1-sri-lanka.jpg"
      image_url(default_image_url)
    end
  end

  def reviewed?(input)
    if current_user
      Review.exists?(['user_id = ? AND trip_id = ?', current_user.id, input])
    else
      nil
    end
  end

end
