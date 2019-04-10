class ImageUploader < Shrine
  include ImageProcessing::MiniMagick

  plugin :activerecord
  plugin :determine_mime_type
  plugin :logging, logger: Rails.logger
  plugin :store_dimensions
  plugin :validation_helpers
  plugin :versions, names: %i[thumb landscape]

   Attacher.validate do
    validate_max_size 2.megabytes, message: 'is too large (max is 2 MB)'
    validate_mime_type_inclusion ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']
  end

  def process(io, context)
    case context[:phase]
    
    when :store
      landscape = io.download
      thumb = resize_to_limit!(io.download, 200, 200)
      { landscape: landscape, thumb: thumb }
    end
  end
end
