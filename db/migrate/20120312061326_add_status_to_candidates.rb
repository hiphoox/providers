class AddStatusToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :status, :string

  end
end
