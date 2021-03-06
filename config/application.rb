require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Datingscene
  class Application < Rails::Application
    config.exceptions_app = self.routes
    config.assets.paths << Rails.root.join('vendor', 'assets', 'swfs')
    config.generators do |g|
      g.template_engine :slim
    end
  end
end
