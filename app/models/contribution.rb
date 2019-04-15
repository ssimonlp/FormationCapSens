# frozen_string_literal: true

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

  validates :value, presence: true, numericality: { greater_than: 0 }
  validate :contribution_uniqueness

  def contribution_uniqueness
    return unless Contribution.exists?(user_id: user_id, project_id: project_id)

    errors.add(:base, 'You can\'t contribute to the same project twice')
  end

  def contributor
    user.profile.first_name + " " + user.profile.last_name
  end

  def counterpart_chosen
    counterpart.nil? ? "No counterpart selected." : counterpart.name
  end
end
