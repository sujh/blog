class PhotosController < ApplicationController

  def create
    uploader = PhotoUploader.new
    uploader.store!(params[:image])
    render json: { code: 100, msg: 'success', data: { url: uploader.url } }
  end

end