# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'Model instantiation' do
    subject(:new_category) { described_class.new }

    describe 'Database' do
      it { is_expected.to have_db_column(:id).of_type(:integer) }
      it { is_expected.to have_db_column(:name).of_type(:string) }
      it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
      it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    end
  end

  context 'when testing associations' do
    it { is_expected.to have_many(:projects) }
  end

  context 'when testing validations' do
    it { is_expected.to validate_presence_of(:name).on(:create) }
  end

  context 'when destroying a category' do
    let(:category) { create(:category) }

    it 'destroys the corresponding projects' do
      create_list(:project, 5, category: category)
      expect { category.destroy }.to change(Project, :count).by(-5)
    end
  end
end
