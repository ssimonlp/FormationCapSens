# == Schema Information
#
# Table name: contributions
#
#  id             :bigint(8)        not null, primary key
#  value          :float
#  user_id        :bigint(8)
#  project_id     :bigint(8)
#  counterpart_id :bigint(8)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Contribution < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :counterpart, optional: true
end
