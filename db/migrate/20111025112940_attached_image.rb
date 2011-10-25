class AttachedImage < ActiveRecord::Migration
  def up
    add_column :pois, :image_file_name,    :string
    add_column :pois, :image_content_type, :string
    add_column :pois, :image_file_size,    :integer
    add_column :pois, :image_updated_at,   :datetime
    add_column :pois, :url,                :string
  end

  def down
    remove_column :pois, :image_file_name
    remove_column :pois, :image_content_type
    remove_column :pois, :image_file_size
    remove_column :pois, :image_updated_at
    remove_column :pois, :url
  end
end
