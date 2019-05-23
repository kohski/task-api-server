class Post < ApplicationRecord
  include Rails.application.routes.url_helpers
  has_one_attached :avatar

  def avatar_url
    avatar.attached? ?  url_for(avatar) : nil
  end
  
end

