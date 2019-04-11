# == Schema Information
#
# Table name: counterparts
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  descrition :text
#  project_id :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Counterpart, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
