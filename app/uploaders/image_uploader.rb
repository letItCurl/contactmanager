class ImageUploader < Shrine
    # plugins and uploading logic
    plugin :store_dimensions
    plugin :validation_helpers
    plugin :processing
    plugin :remove_invalid
    plugin :versions

    include ImageProcessing::MiniMagick
    require "image_processing/mini_magick"

    process(:store) do |io, context|
        {
            original: io,
            small: resize_to_limit(io.download, 150,150),
            medium: resize_to_limit(io.download, 300,300)
        }
    end

    Attacher.validate do
        validate_mime_type_inclusion %w[image/jpeg image/png image/gif]
        validate_extension_inclusion %w[jpg jpeg png gif]
    end
end