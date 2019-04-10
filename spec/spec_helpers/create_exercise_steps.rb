# frozen_string_literal: true

def create_exercise
  @exercise = Exercise.new
  @exercise.title = 'How to be a Stoic?'
  @exercise.general_description = '3 Easy steps to Stoic practice.'
  @exercise.save!
end

def create_rehearsal
  @rehearsal = Rehearsal.new
  @rehearsal.id = 1
  @rehearsal.tally = 2
  @rehearsal.exercise_id = 1
  @rehearsal.user_id = 1
  @rehearsal.save!
end

def create_e_question
  @e_question = EQuestion.new
  @e_question.exercise_id = 1
  @e_question.question = 'Do you practice the Discipline of Assent?'
  @e_question.save!
end

def create_e_answer
  @e_answer = EAnswer.new
  @e_answer.e_question_id = 1
  @e_answer.answer = 'Yes, I practice it every day.'
  @e_answer.rehearsal_id = 1
  @e_answer.save!
end

def set_exercise_owned_by_normal_user
  @exercise.user_id = @normal_user.id
end

def set_exercise_owned_by_admin_user
  @exercise.user_id = @admin_user.id
end

def visit_exercise_page
  visit exercise_path(@exercise.id)
end

def visit_edit_exercise_page
  visit edit_exercise_path(@exercise.id)
end
