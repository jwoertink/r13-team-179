require 'fileutils'

module VideoCompiler
  
  # the path to where we will store tmp videos locally
  def tmp_video_path
    Rails.root.join('tmp', 'videos')
  end
  
  # create the tmp videos directory if it doesn't exist
  def create_videos_tmp_directory
    FileUtils.mkdir_p tmp_video_path
  end
  
  def download_tmp_video(url_source)
    create_videos_tmp_directory unless Dir.exists? tmp_video_path
    tmp_file_path = tmp_video_path.join("video-#{Time.now.to_i}.mp4")
    File.open(tmp_file_path, "wb") do |file|
      file.write open(url_source).read
    end
    tmp_file_path
  end
  
  # return the new S3 url for the fully compiled video
  def get_remote_video_url
    ''
  end
  
  def collect_question_videos(array_of_question_ids)
    @clips = [] # it should be paths to videos
    array_of_question_ids.each do |id|
      @clips << Question.find(id).video.url
    end
  end
  
  def split_source(profile_tmp_video_path)
    @source = profile_tmp_video_path
    
    `ffmpeg -i /root/#{@source} -vcodec copy -acodec copy -ss 00:00:05 -t 00:00:05 /tmp/clip-1.mp4`
    `ffmpeg -i /root/#{@source} -vcodec copy -acodec copy -ss 00:00:05 -t 00:00:05 /tmp/clip-2.mp4`
    `ffmpeg -i /root/#{@source} -vcodec copy -acodec copy -ss 00:00:10 -t 00:00:05 /tmp/clip-3.mp4`
    `ffmpeg -i /root/#{@source} -vcodec copy -acodec copy -ss 00:00:15 -t 00:00:05 /tmp/clip-4.mp4`
  end
  
  def combine_and_order_files(@clips)
    @order = []
    @selfies = ["/tmp/clip-1.mp4", "/tmp/clip-2.mp4", "/tmp/clip-3.mp4", "/tmp/clip-4.mp4"]
    @clips.each_with_index do |path, index|
      @order << path << @selfies[index]
    end
  end
  
  def convert_all_media_to_ts(@order)
    @recipe = []
    @order.each_with_index do |path, index|
      `ffmpeg -i #{path} -c:v libx264 -vf scale=640:480 -r 60 -c:a aac -ar 48000 -b:a 160k -strict experimental -f mpegts /tmp/#{index}.ts`
      @recipe << "/tmp/#{index}.ts"
    end
  end
  
  def create_recipe_final_ts
    `cat 0.ts 1.ts 2.ts 3.ts 4.ts 5.ts 6.ts 7.ts > final.ts`
    #File.open('recipe.txt', "w+") do |file|
    #  @order.each do |clip|
    #    file.write("file '" + clip + "'\n")
    #  end
    #end
  end
  
  def compile_recipe
    `ffmpeg -f concat -i recipe.txt -c copy preprossed.mp4`
  end
  
  def seperate_audio_from_compiled_videos
    `ffmpeg -i preprocced.mp4 script.wav`
  end
  
  def mixin_background_wav_with_audio_file
    `ffmpeg -i script.wav -i background.wav -filter_complex amerge -c:a libmp3lame -q:a 4 track.wav`
  end
  
  def overlay_mixed_audio_back_on_video
    `ffmpeg -i preprocessed.mp4 -i track.wav -c:v copy -c:a aac -strict experimental completed.mp4`
  end
  
  def take_screenshot
    # take a screenshot 7sec from begining of video
  end
  
  def upload_final_production_to_s3(object)
    object.update_attribute(:video, 'completed.mp4')
    # kick-off notification to profile owner
  end
  
  def cleanup_ffmpeg_files
    `rm -rf preprocessed.mp4`
    `rm -rf script.wav`
    `rm -rf track.wav`
    `rm -rf completed.mp4`
  end
end