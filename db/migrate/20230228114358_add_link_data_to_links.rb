class AddLinkDataToLinks < ActiveRecord::Migration[7.0]
  def change
    add_column :links, :title, :string
    add_column :links, :image_url, :string
  end
end
