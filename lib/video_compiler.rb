module VideoCompiler
  def gather_recordings
    @selfies = {}
    # collect tmp recording in selfies_array
  end
  
  def collect_question_videos
    @clips = []
    # Use array to collect question clips_array
  end
  
  def combine_and_order_files
    @order = []
    @selfies.each do |s|
      @order << Question.find(s.id) << s.video
    end
    # pair up question clips with videos
    # join arrays to create recipe order
  end
  
  def write_paths_to_tmp_file
    File.open('recipe.txt', "w+") do |file|
      @recipe_order.each do |clip|
        file.write(clip + "\n")
      end
    end
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
  
  def upload_final_production_to_s3(object)
    object.update_attribute(:video, completed.mp4)
    # kick-off notification to profile owner
  end
  
  def cleanup_ffmpeg_files
    `rm -rf preprocessed.mp4`
    `rm -rf script.wav`
    `rm -rf track.wav`
    `rm -rf completed.mp4`
  end
end