# == Schema Information
#
# Table name: doodles
#
#  id         :integer          not null, primary key
#  prompt_id  :integer
#  image      :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class DoodleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
