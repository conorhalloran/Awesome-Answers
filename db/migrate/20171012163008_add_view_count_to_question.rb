class AddViewCountToQuestion < ActiveRecord::Migration[5.1]
  def change
    #           table         column      value
    add_column :questions, :view_count, :integer
  end
end
