class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :title
      t.text :body
      t.datetime :start
      t.datetime :finish
      t.integer :status
      t.integer :type
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
