class CreateSurveyQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :survey_questions do |t|
      t.text :body
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
