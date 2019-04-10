# frozen_string_literal: true

# == Schema Information
#
# Table name: projects
#
#  id                :bigint(8)        not null, primary key
#  name              :string
#  short_description :text
#  long_description  :text
#  goal              :float
#  image_data        :text
#  category_id       :bigint(8)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#


require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'Model instantiation' do
    subject(:new_project) { described_class.new }

    describe 'Database' do
      it { is_expected.to have_db_column(:id).of_type(:integer) }
      it { is_expected.to have_db_column(:name).of_type(:string) }
      it { is_expected.to have_db_column(:short_description).of_type(:text) }
      it { is_expected.to have_db_column(:long_description).of_type(:text) }
      it { is_expected.to have_db_column(:goal).of_type(:float) }
      it { is_expected.to have_db_column(:image_data).of_type(:text) }
      it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
      it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    end

    context 'when testing associations' do
      it { is_expected.to belong_to(:category) }
    end

    context 'when testing validation' do
      it { is_expected.to validate_presence_of(:goal)}
      it { is_expected.to validate_numericality_of(:goal).is_greater_than(0) }
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_uniqueness_of(:name) }
      it { is_expected.to allow_value("Super Objet").for(:name) }
      it { is_expected.not_to allow_value("Super Objet\n").for(:name) }
      it { is_expected.to validate_length_of(:name).is_at_least(3).is_at_most(30) }
      it { is_expected.to validate_length_of(:short_description).is_at_least(10).is_at_most(200) }
      it { is_expected.to validate_length_of(:long_description).is_at_least(100).is_at_most(600) }
    end
  end
end
