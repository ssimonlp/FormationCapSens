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

require 'rails_helper'

RSpec.describe Contribution, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
