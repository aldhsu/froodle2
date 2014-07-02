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

class Doodle < ActiveRecord::Base
  belongs_to :prompt
  belongs_to :user
  has_many :ratings

  mount_uploader :image, ImageUploader
end
