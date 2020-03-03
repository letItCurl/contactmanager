class Contact < ApplicationRecord
  belongs_to :group

  def gravatar
    hash = Digest::MD5.hexdigest(email.downcase)
    "https://picsum.photos/seed/#{hash}/100/100"
  end

end
