class AddSomeCloumnToJob < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :location, :string
    add_column :jobs, :company_name, :string
    add_column :jobs, :company_url, :string
    add_column :jobs, :company_contact_email, :string
    add_column :jobs, :category, :string
  end
end
