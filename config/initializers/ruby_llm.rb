# config/initializers/ruby_llm.rb or similar

require 'ruby_llm'
RubyLLM.configure do |config|
  config.openai_api_key = Rails.application.credentials.dig(:open_ai, :api_key)
  # Add keys ONLY for providers you intend to use
  # config.anthropic_api_key = ENV.fetch('ANTHROPIC_API_KEY', nil)
  # ... see Configuration guide for all options ...
end
