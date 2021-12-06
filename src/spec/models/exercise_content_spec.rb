require 'rails_helper'

RSpec.describe ExerciseContent, type: :model do
  let(:exercise_content) { FactoryBot.build(:exercise_content) }
  aaa = FactoryBot.create(:exercise_category)
  pp aaa
end
