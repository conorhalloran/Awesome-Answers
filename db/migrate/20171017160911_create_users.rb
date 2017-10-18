class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      # Because we're often going to search for users by their email, let's add an index for the column. Also
      t.string :email, index: {unique: true}
      t.string :password_digest

      t.timestamps
    end
  end
end
