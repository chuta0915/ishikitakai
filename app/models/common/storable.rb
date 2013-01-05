require 'open-uri'
module Common::Storable
  def self.included(base)
    base.extend ClassMethods
    base.class_eval do
      class_attribute :storable_file_column
      attr_accessor :stored_url
      after_save :save_to_s3
    end
    base.storable_file_column = 'image'
  end

  module ClassMethods
    def storable_file(name)
      self.storable_file_column = name
    end
  end
  
  private
  def save_to_s3
    if self.image =~ /#{ENV['AWS_S3_BUCKET']}\.s3\.amazonaws\.com/
      self.stored_url = self.image
      return
    end
    storage = Fog::Storage.new(
      provider: 'AWS',
      aws_access_key_id:ENV['AWS_S3_KEY_ID'],
      aws_secret_access_key:ENV['AWS_S3_SECRET_KEY'],
      region: ENV['AWS_REGION']
    )
    bucket = storage.directories.get(ENV['AWS_S3_BUCKET']) 
    bucket = storage.directories.create(key: ENV['AWS_S3_BUCKET']) unless bucket

    save_file = self.send(self.storable_file_column)
    dir = self.class.to_s.tableize
    path_to_save = "#{dir}/#{self.storable_file_column.to_s}/#{self.try(:id)||0 % 1000}/#{self.try(:id)}"

    file = bucket.files.create(key: path_to_save, public: true, body: open(save_file))
    self.stored_url = file.public_url
  end
end
