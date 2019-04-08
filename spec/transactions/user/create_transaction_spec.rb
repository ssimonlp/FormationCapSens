# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User::CreateTransaction do
  describe 'database' do
    subject { described_class.new.call(params: params) }

    context 'with valid params' do
      let(:params) do
        attributes_for(:user).merge(
          profile_attributes: attributes_for(:profile)
        )
      end

      it 'creates a user' do
        expect { subject }.to change(User, :count).by(+1)
      end
      it 'creates a profile' do
        expect { subject }.to change(Profile, :count).by(+1)
      end
      it 'sends the confirmation email' do
        expect { subject }.to change(ActionMailer::Base.deliveries, :count).by(+1)
      end
    end

    context 'with invalid params' do
      let(:params) do
        attributes_for(:wrong_user).merge(
          profile_attributes: attributes_for(:profile)
        )
      end

      it 'does not save the user' do
        expect { subject }.not_to change(User, :count)
      end
      it 'results in failure' do
        expect(subject.failure?).to be_truthy
      end
      it 'does not send the email' do
        expect { subject }.not_to change(ActionMailer::Base.deliveries, :count)
      end
    end

    context 'with missing params' do
      let(:params) do
        attributes_for(:user).merge(
          profile_attributes: attributes_for(:wrong_profile)
        )
      end

      it 'does not save the profile' do
        expect { subject }.not_to change(Profile, :count)
      end
      it 'does not save the user' do
        expect { subject }.not_to change(User, :count)
      end
      it 'results in failure' do
        expect(subject.failure?).to be_truthy
      end
    end
  end
end
