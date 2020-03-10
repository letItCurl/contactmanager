class Contact < ApplicationRecord
  belongs_to :group

  validates :name, :email, :group_id, presence: true
  validates :name, length: {minimum: 2}

  include ImageUploader::Attachment(:image)

  def gravatar
    hash = Digest::MD5.hexdigest(email.downcase)
    "https://picsum.photos/seed/#{hash}/100/100"
  end
  
  scope :search, -> (term) do 
    #refract: ILIKE for POSTGRESQL 
    where('name ILIKE :term OR company ILIKE :term OR email ILIKE :term', term: "%#{term}%") if term.present? 
  end

  scope :by_group, -> (group_id) { where(group_id: group_id) if group_id.present? }

end
