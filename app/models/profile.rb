class Profile < ActiveRecord::Base
  include VideoCompiler
  
  has_many :interests
  mount_uploader :video, ProfileVideoUploader
  
  after_initialize :generate_url_key
  before_create :download_temp_video
  
  def self.completed
    where(completed: true)
  end
  
  def question_ids=(ids)
    self.write_attribute(:question_ids, ids)
  end
  
  # The macro process to generating the new video
  # clean up old videos, and remove tmp videos from system
  # ensure new video is pushed to S3, and saved onto the model
  def compile_video
    create_recipe
    process_files
    upload_and_cleanup
    
    # mark profile as completed with the new video url
    self.remote_video_url = get_remote_video_url
    self.completed = true
    save!
  end
  
  private
  
  def generate_url_key
    self.url_key = Time.now.to_i.to_s([31, 32, 33, 34].sample)
  end
  
  def download_temp_video
    self.tmp_video_path = download_tmp_video(original_url)
  end
  
end
