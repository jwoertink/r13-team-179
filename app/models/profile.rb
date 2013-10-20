class Profile < ActiveRecord::Base
  has_many :interests
  mount_uploader :video, VideoUploader
  
  def compile_now
    include VideoWorker
    create_recipe
    process_files
    upload_and_cleanup
  end
  
  def create_recipe
  end
  
  def process_files
  end
  
  def upload_and_cleanup
  end
  
end
