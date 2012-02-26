class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :first_name
      t.string :last_name
      t.string :mother_name
      t.string :rfc

      t.timestamps
    end
  end
end
