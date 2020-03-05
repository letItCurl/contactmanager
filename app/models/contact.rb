class Contact < ApplicationRecord
  belongs_to :group

  validates :name, :email, :group_id, presence: true
  validates :name, length: {minimum: 2}

  include ImageUploader::Attachment(:image)

  def gravatar
    hash = Digest::MD5.hexdigest(email.downcase)
    "https://picsum.photos/seed/#{hash}/100/100"
  end

end
