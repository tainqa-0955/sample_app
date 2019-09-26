module UsersHelper
  def gravatar_for user, size: Settings.image[:gravatar_user_default_size]
    gravatar_id = Digest::MD5.hexdigest user.email.downcase
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end

  def find_user followed_id
    current_user.active_relationships.find_by followed_id: followed_id
  end
end
