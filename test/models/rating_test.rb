# == Schema Information
#
# Table name: ratings
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  doodle_id  :integer
#  rating     :integer
#  created_at :datetime
#  updated_at :datetime
#  guessed    :integer          default(0)
#

require 'test_helper'

class RatingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
