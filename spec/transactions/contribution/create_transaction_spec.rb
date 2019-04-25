# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contribution::CreateTransaction do
  describe 'database' do
    subject { described_class.new.call(params: contribution) }

    context 'with valid params' do
      let(:contribution) { build(:complete_contribution) }

      it 'creates a contribution' do
        VCR.use_cassette('contribution/success_response') do
          expect { subject }.to change(Contribution, :count).by(+1)
        end
      end

      it 'gets a successful response from mangopay' do
        VCR.use_cassette('contribution/success_response') do
          expect(subject).to be_success
        end
      end
    end

    context 'with invalid params' do
      let(:contribution)  { build_stubbed(:wrong_contribution) }

      it 'doesn\'t create a contribution' do
        VCR.use_cassette('contribution/failure_response') do
          expect { subject }.not_to change(Contribution, :count)
        end
      end

      it 'gets a failure response from mangopay' do
        VCR.use_cassette('contribution/failure_response') do
          expect(subject).to be_failure
        end
      end
    end
  end
end
