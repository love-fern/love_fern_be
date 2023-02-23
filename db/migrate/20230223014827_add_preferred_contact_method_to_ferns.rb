class AddPreferredContactMethodToFerns < ActiveRecord::Migration[5.2]
  def change
    add_column :ferns, :preferred_contact_method, :string
    add_column :ferns, :frequency, :integer
    remove_column :ferns, :tag
    remove_column :ferns, :user_id
  end
end
