class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :option_vote
      t.references :option, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
