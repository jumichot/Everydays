class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.integer :form_user
      t.integer :to_user_id
      t.string :to_email
      t.datetime :created_at
      t.string :url

      t.timestamps null: false
    end
  end
end
