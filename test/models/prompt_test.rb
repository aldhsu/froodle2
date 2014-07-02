# == Schema Information
#
# Table name: prompts
#
#  id         :integer          not null, primary key
#  difficulty :integer
#  question   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class PromptTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
