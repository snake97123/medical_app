class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.references :user
      t.references :answer

      t.timestamps
      t.index [:user_id, :answer_id], unique: true
    end
  end
end
