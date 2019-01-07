class PhotoUploader < BaseUploader

  def store_dir
    'uploads/photos/'
  end

  def filename
    "#{Date.today.year}/#{SecureRandom.uuid}.#{file.extension.downcase}"
  end

end