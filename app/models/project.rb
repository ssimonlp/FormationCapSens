class Project < ApplicationRecord
  belongs_to :category

  include ImageUploader::Attachment.new(:image)
end
