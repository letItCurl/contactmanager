class AddImageDataToContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :image_data, :text
  end
end
