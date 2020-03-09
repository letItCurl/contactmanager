class Contact < ApplicationRecord
  belongs_to :group

  validates :name, :email, :group_id, presence: true
  validates :name, length: {minimum: 2}

  include ImageUploader::Attachment(:image)

  def gravatar
    hash = Digest::MD5.hexdigest(email.downcase)
    "https://picsum.photos/seed/#{hash}/100/100"
  end

  def self.search(term)
    if term && !term.empty?
      where('name ILIKE ?', "%#{term}%")
    else
      all
    end
  end

  def self.by_group(group_id)
    if group_id && !group_id.empty?
      where(group_id: group_id)
    else
      all
    end
  end
end
