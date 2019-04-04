# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User::CreateTransaction do
  describe 'database' do
    context 'with valid params' do
      let(:user_params) { attributes_for(:confirmed_user) }
      let(:profile_params) { attributes_for(:profile) }
      let(:params) { user_params.merge(profile_attributes: profile_params) } # c'est pas super je changerai quand je modifierai ma transaction dans la prochaine carte

      it 'creates a user' do
        expect { described_class.new.call(params) }.to change(User, :count).by(+1)
      end
      it 'creates a profile' do
        expect { described_class.new.call(params) }.to change(Profile, :count).by(+1)
      end
    end

    context 'with invalid params' do
      let(:user_params) { attributes_for(:wrong_user) }
      let(:profile_params) { attributes_for(:profile) }
      let(:params) { user_params.merge(profile_attributes: profile_params) }

      it 'does not save the user' do
        expect { described_class.new.call(params) }.not_to change(User, :count)
      end
      it 'results in failure' do
        expect(described_class.new.call(params).failure?).to be_truthy
      end
    end

    context 'with missing params' do
      let(:user_params) { attributes_for(:confirmed_user) }
      let(:profile_params) { attributes_for(:wrong_profile) }
      let(:params) { user_params.merge(profile_attributes: profile_params) }

      it 'does not save the profile' do
        expect { described_class.new.call(params) }.not_to change(Profile, :count)
      end
      it 'does not save the user' do
        expect { described_class.new.call(params) }.not_to change(User, :count)
      end
      it 'results in failure' do
        expect(described_class.new.call(params).failure?).to be_truthy
      end
    end
  end

  describe 'emailing' do
    context 'with valid params' do
      let(:user_params) { attributes_for(:user) }
      let(:profile_params) { attributes_for(:profile) }
      let(:params) { user_params.merge(profile_attributes: profile_params) }

      it 'sends the confirmation email' do
        expect { described_class.new.call(params) }.to change(ActionMailer::Base.deliveries, :count).by(+2) # comme j'ai pas encore override le mailling de devise y a deux email qui partent, je changerai plus tard
      end
    end
    context 'with unvalid params' do
      let(:user_params) { attributes_for(:wrong_user) }
      let(:profile_params) { attributes_for(:profile) }
      let(:params) { user_params.merge(profile_attributes: profile_params) }

      it 'does not send the email' do
        expect { described_class.new.call(params) }.not_to change(ActionMailer::Base.deliveries, :count)
      end
    end
  end
end
