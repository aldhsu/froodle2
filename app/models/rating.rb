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

class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :doodle
end
