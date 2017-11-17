class CreateSurveyAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :survey_answers do |t|
      t.text :body
      t.references :user, foreign_key: true
      t.references :survey_question, foreign_key: true

      t.timestamps
    end
  end
end
