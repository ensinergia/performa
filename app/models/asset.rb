class Asset < ActiveRecord::Base
  
  belongs_to :pointer
  
  has_attached_file :asset,
      :storage => :s3,
      :bucket => 'ensinergiaphotos',
      :s3_credentials => {
        :access_key_id => "AKIAJYKCWTZMXFO2YBNA",
        :secret_access_key => "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"
      }
end
