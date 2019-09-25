class Micropost < ApplicationRecord
  belongs_to :user
  scope :sort_by_created_at, ->{order created_at: :desc}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true,
            length: {maximum: Settings.micropost[:maximum_content]}
  validate  :picture_size
  scope :where_user_id_equal_id, (lambda do |following_ids, id|
    where("user_id IN (?) OR user_id = ?", following_ids, id)
  end)

  private

  def picture_size
    return unless picture.size > Settings.image[:maximum_size].megabytes

    errors.add(:picture, I18n.t("micropost.new.error_picture_size"))
  end
end
