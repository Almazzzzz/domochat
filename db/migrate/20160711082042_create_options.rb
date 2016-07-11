class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :poll_option
      t.references :poll, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
