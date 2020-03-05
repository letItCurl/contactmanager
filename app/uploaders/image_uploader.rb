require "image_processing/mini_magick"

class ImageUploader < Shrine
    # plugins and uploading logic
    plugin :store_dimensions
    plugin :validation_helpers
    plugin :remove_invalid
    plugin :versions

    Attacher.validate do
        validate_mime_type_inclusion %w[image/jpeg image/png image/gif]
        validate_extension_inclusion %w[jpg jpeg png gif]
    end

    Attacher.derivatives do |original|
        magick = ImageProcessing::MiniMagick.source(original)
     
        { 
          small:  magick.resize_to_limit!(300, 300),
          medium: magick.resize_to_limit!(500, 500),
          large:  magick.resize_to_limit!(800, 800),
        }
    end
end
