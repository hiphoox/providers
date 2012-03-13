class AddAttributesToCandidate < ActiveRecord::Migration
  def change
    add_column :candidates, :phone_number, :string

    add_column :candidates, :email, :string

    add_column :candidates, :technology, :string

  end
end
