# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id              :bigint(8)        not null, primary key
#  first_name      :string
#  last_name       :string
#  date_of_birth   :date
#  registration_ip :inet
#  user_id         :bigint(8)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#


require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
