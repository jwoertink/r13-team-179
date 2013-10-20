class VideoCompilationWorker
  include Sidekiq::Worker
  
  sidekiq_options queue: :critical
  
  def perform(profile_id)
    @profile = Profile.find(profile_id)
    @profile.compile_video
  rescue ActiveRecord::RecordNotFound
    Rails.logger.info "Looks like profile #{profile_id} is missing"
  end
end