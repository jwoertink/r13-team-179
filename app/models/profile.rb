class Profile < ActiveRecord::Base
  include VideoCompiler
  
  has_many :interests
  mount_uploader :video, VideoUploader
  
  after_initialize :generate_url_key
  after_create :download_temp_video
  
  def self.completed
    where(completed: true)
  end
  
  def question_ids=(ids)
    self.write_attribute(:question_ids, ids)
  end
  
  def compile_video
    create_recipe
    process_files
    upload_and_cleanup
    self.update_attribute(:completed, true)
  end
  
  private
  
  def generate_url_key
    self.url_key = Time.now.to_i.to_s([31, 32, 33, 34].sample)
  end
  
  def download_temp_video
    # TODO: download the video from the original_url
    #  Save to the local system and associate the video with the id
    # After video is downloaded, then compile final product
  end
  
end
