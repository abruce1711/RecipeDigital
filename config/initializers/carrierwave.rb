CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
      provider:              'AWS',                        # required
      aws_access_key_id:     ENV["AWS_ACCESS_KEY_ID"],                        # required unless using use_iam_profile
      aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY_ID"],                        # required unless using use_iam_profile
      region:                'eu-west-2',                  # optional, defaults to 'us-east-1'
  }
 config.fog_directory  = ENV["AWS_S3_BUCKET"]                                      # required
end