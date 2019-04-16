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

class Project < ApplicationRecord
  include AASM
  include ImageUploader::Attachment.new(:image)

  belongs_to :category
  has_many :contributions, dependent: :destroy
  has_many :counterparts, dependent: :destroy
  has_many :users, through: :contributions

  validates :name, presence: true, uniqueness: true, case_sensitive: false, format: { with: /\A[\x20-\x7E]+\z/, message: "Only alpha-numeric characters" }, length: { in: 3..30 }
  validates :goal, presence: true, numericality: { greater_than: 0 }
  validates :short_description, length: { in: 10..200 }, allow_blank: true
  validates :long_description, length: { in: 100..600 }, allow_blank: true

  aasm do
    state :draft, initial: true
    state :upcoming
    state :ongoing
    state :success
    state :failure

    event :start_upcoming do
      transitions from: :draft, to: :upcoming, guard: :can_upcome?
    end

    event :start_ongoing do
      transitions from: :upcoming, to: :ongoing, guard: :can_ongo?
    end

    event :succeed do
      transitions from: :ongoing, to: :success
    end

    event :fail do
      transitions from: :ongoing, to: :failure
    end
  end

  def can_upcome?
    name.present? && short_description.present? && long_description.present? && image.size == 2
  end

  def can_ongo?
    category_id.present? && !counterparts.nil?
  end

  def collect
    [sum = contributions.sum(:value), (sum / goal * 100).round(2)]
  end

  def rank
    contributions.collect(&:value).sort!.values_at(0, -1)
  end
end
