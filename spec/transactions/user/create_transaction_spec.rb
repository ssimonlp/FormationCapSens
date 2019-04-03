# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User::CreateTransaction do
  subject { described_class.call( email: email, password: password, profile_attributes: { first_name: first_name, last_name: last_name, date_of_birth: date_of_birth }) }


end
