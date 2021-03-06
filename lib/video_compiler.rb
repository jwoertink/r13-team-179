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
    tmp_file_path.to_s
  end
  
  def collect_question_videos(array_of_question_ids)
    @clips = [] # it should be paths to videos
    array_of_question_ids.each do |id|
      @clips << Question.find(id).video.url
    end
  end
  
  def split_source(profile_tmp_video_path)
    @source = profile_tmp_video_path
    
    `ffmpeg -i /root/#{@source} -vcodec copy -acodec copy -ss 00:00:05 -t 00:00:05 /tmp/videos/clip-1.mp4`
    `ffmpeg -i /root/#{@source} -vcodec copy -acodec copy -ss 00:00:05 -t 00:00:05 /tmp/videos/clip-2.mp4`
    `ffmpeg -i /root/#{@source} -vcodec copy -acodec copy -ss 00:00:10 -t 00:00:05 /tmp/videos/clip-3.mp4`
    `ffmpeg -i /root/#{@source} -vcodec copy -acodec copy -ss 00:00:15 -t 00:00:05 /tmp/videos/clip-4.mp4`
  end
  
  def combine_and_order_files(clips)
    @order = []
    @selfies = ["/tmp/videos/clip-1.mp4", "/tmp/videos/clip-2.mp4", "/tmp/videos/clip-3.mp4", "/tmp/videos/clip-4.mp4"]
    clips.each_with_index do |path, index|
      @order << path << @selfies[index]
    end
  end
  
  def convert_all_media_to_ts(order)
    @recipe = []
    order.each_with_index do |path, index|
      `ffmpeg -i #{path} -c:v libx264 -vf scale=640:480 -r 60 -c:a aac -ar 16000 -b:a 160k -strict experimental -f mpegts /tmp/videos/#{index}.ts`
      @recipe << "/tmp/videos/#{index}.ts"
    end
  end
  
  def create_recipe_final_ts
    `cat 0.ts 1.ts 2.ts 3.ts 4.ts 5.ts 6.ts 7.ts > /tmp/videos/final.ts`
  end
  
  def compile_recipe
    `ffmpeg -i /tmp/videos/final.ts -c copy -bsf:a aac_adtstoasc /tmp/videos/preprocessed.mp4`
  end
  
  def seperate_audio_from_compiled_videos
    `ffmpeg -i /tmp/videos/preprocessed.mp4 /tmp/videos/script.wav`
  end
  
  def mixin_background_wav_with_audio_file
    `ffmpeg -i /tmp/videos/script.wav -i background.wav -filter_complex amerge -c:a libmp3lame -q:a 4 /tmp/videos/track.wav`
  end
  
  def overlay_mixed_audio_back_on_video
    `ffmpeg -i /tmp/videos/preprocessed.mp4 -i /tmp/videos/track.wav -c:v copy -c:a aac -strict experimental /tmp/videos/completed.mp4`
  end
  
  def take_screenshot
    `ffmpeg -i /tmp/videos/completed.mp4 -ss 00:00:07.001 -f image2 -vframes 1 /tmp/videos/poster.png`
    # take a screenshot 7sec from begining of video
  end
  
  def cleanup_ffmpeg_files
    `rm -rf /tmp/videos/*.*`
  end
end