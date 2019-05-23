class Task < ApplicationRecord
  include Rails.application.routes.url_helpers
  has_one_attached :picture

  def picture_url
    picture.attached? ?  url_for(picture) : nil
  end
end
