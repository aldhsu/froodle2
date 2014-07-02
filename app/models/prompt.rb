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

class Prompt < ActiveRecord::Base
  has_many :doodles
end
