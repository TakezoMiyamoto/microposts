CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => 'AKIAJDARU7YAN4LV6MVA',
      :aws_secret_access_key  => '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',
      :region                 => 'ap-northeast-1',
      :path_style             => true,
  }

  
      config.fog_directory = 's3user-takezo-bucket'

end