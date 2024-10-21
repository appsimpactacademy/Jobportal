class AddExtraColumnsToCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :about, :text
    add_column :companies, :domain, :string
    add_column :companies, :website, :string
  end
end
