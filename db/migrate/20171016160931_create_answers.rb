class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.text :body
      t.references :question, foreign_key: true, index: true 
      # 👆 will generate a colum named 'question_id' of type 'integer' which is meant to refer to a row of 'question_id' in the 'questions' table. 
      t.timestamps
    end
  end
end
