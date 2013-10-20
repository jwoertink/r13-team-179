class Profile < ActiveRecord::Base
  has_many :interests
  mount_uploader :video, VideoUploader
  
  after_initialize :generate_url_key
  after_create :grab_video
  
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
  
  def question_ids=(ids)
    self.write_attribute(:question_ids, ids)
  end
  
  private
  
  def generate_url_key
    self.url_key = Time.now.to_i.to_s([31, 32, 33, 34].sample)
  end
  
  def grab_video
    # TODO: download the video from the original_url
    #  Save to the local system and associate the video with the id
    # After video is downloaded, then compile final product
  end
  
end
