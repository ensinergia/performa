require 'carrierwave/orm/activerecord'

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

Fog.credentials_path = Rails.root.join('config/fog_credentials.yml') 
CarrierWave.configure do |config|
  config.fog_credentials = {:provider => 'AWS'}
  config.fog_directory = "ensinergia"
end