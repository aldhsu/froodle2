# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  points     :integer          default(0)
#  gpid       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  has_many :doodles, dependent: :destroy
  has_many :ratings, dependent: :destroy

end
