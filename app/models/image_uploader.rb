# frozen_string_literal: true

class ImageUploader < Shrine
  plugin :processing
  plugin :activerecord
  plugin :determine_mime_type
  plugin :logging, logger: Rails.logger
  plugin :store_dimensions
  plugin :validation_helpers
  plugin :versions

  Attacher.validate do
    validate_max_size 5.megabytes, message: 'is too large (max is 5 MB)'
    validate_mime_type_inclusion ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']
  end

  process(:store) do |io, _context|
    original = io.download
    pipeline = ImageProcessing::MiniMagick.source(original)

    landscape = pipeline.resize_to_limit!( 500, 500)
    thumb = pipeline.resize_to_limit!(200, 200)

    original.close!

    { landscape: landscape, thumb: thumb }
  end
end
