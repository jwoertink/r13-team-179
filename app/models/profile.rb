class Profile < ActiveRecord::Base
  include VideoCompiler
  
  has_many :interests
  mount_uploader :video, ProfileVideoUploader
  
  after_initialize :generate_url_key
  before_create :download_temp_video
  
  def self.completed
    where(completed: true)
  end
    
  # The macro process to generating the new video
  # clean up old videos, and remove tmp videos from system
  # ensure new video is pushed to S3, and saved onto the model
  def compile_video
    @profile = self
    
    # Gather Question Videos
    collect_question_videos(@profile.question_ids.split(','))
    
    # Divide Source Video into 4 Sections
    split_source(@profile.tmp_video_path)
    
    # Combine and Order Question Videos with Source Clips
    combine_and_order_files(@clips)
    
    # Convert all pieces to match TS media type and create compile Recipe
    convert_all_media_to_ts(@order)
    create_recipe_final_ts
    
    # Compile 
    compile_recipe
    
    # Add Background Music
    seperate_audio_from_compiled_video
    mixin_background_was_with_audio_file
    overlay_mixed_audio_back_on_video
    
    # Create a Screenshot
    # TODO: push screetshot to aws::s3 and associate to profile
    # take_screenshot 
    
    # Push Final Production up to AWS::S3
    upload_final_production_to_s3(@profile)
    
    # Cleanup the mess
    cleanup_ffmpeg_files
    
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
