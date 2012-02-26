class AddRelationshipToCandidate < ActiveRecord::Migration
  def change
    add_column :candidates, :admin_user_id, :integer
  end
end
