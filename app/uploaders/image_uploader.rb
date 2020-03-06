require "image_processing/mini_magick"

class ImageUploader < Shrine
    # plugins and uploading logic
    #plugin :store_dimensions
    #plugin :validation_helpers
    #plugin :remove_invalid
    plugin :derivatives
    plugin :pretty_location, namespace: "/"
    #plugin :remove_attachment
=begin
    Attacher.validate do
        validate_mime_type_inclusion %w[image/jpeg image/png image/gif]
        validate_extension_inclusion %w[jpg jpeg png gif]
    end
=end
    Attacher.derivatives do |original|
        magick = ImageProcessing::MiniMagick.source(original)
        { 
          small:  magick.resize_to_limit!(150, 150),
          medium: magick.resize_to_limit!(300, 300),
          large:  magick.resize_to_limit!(500, 500),
        }
    end

    def generate_location(io, record: nil, **context)
        identifier = record.email if record.is_a?(Contact)
        pretty_location(io, record: record, identifier: identifier, **context)
    end

end
