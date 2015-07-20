module UserHelper
  # Returns the gravatar image corresponding to the passed in user
  #
  def gravatar_for(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag gravatar_url, alt: "#{user.name} gravatar", class: 'gravatar'
  end
end
