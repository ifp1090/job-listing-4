class AddCategoryNameToJob < ActiveRecord::Migration[5.0]
  def change
  	add_column :jobs, :category_name, :string, :default => "技术"
  end
end
