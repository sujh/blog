class AvatarUploader < BaseUploader

  def store_dir
    'uploads/avatar'
  end

  def filename
    "avatar.#{file.extension.downcase}"
  end

  process resize_to_fill: [100, 100]

  version :small do
    process resize_to_fill: [30, 30]
  end

end