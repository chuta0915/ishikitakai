require 'open-uri'
module Common::Storable
  def self.included(base)
    base.extend ClassMethods
    base.class_eval do
      class_attribute :storable_file_column
    end
    base.storable_file_column = 'image'
  end

  module ClassMethods
    def storable_file(name)
      self.storable_file_column = name
    end
  end
  
  def save_to_s3
    storage = Fog::Storage.new(
      provider: 'AWS',
      aws_access_key_id:Figaro.env.aws_s3_key_id,
      aws_secret_access_key:Figaro.env.aws_s3_secret_key,
      region: Figaro.env.aws_region
    )
    bucket = storage.directories.get(Figaro.env.aws_s3_bucket) 
    bucket = storage.directories.create(key: Figaro.env.aws_s3_bucket) unless bucket

    save_file = self.send(self.storable_file_column)
    dir = self.class.to_s.tableize
    path_to_save = "#{dir}/#{self.storable_file_column.to_s}/#{self.try(:id)||0 % 1000}/#{self.try(:id)}"

    file = bucket.files.create(key: path_to_save, public: true, body: open(save_file))
    storable_url = "#{file.public_url}?#{Time.current.to_i}"
    self.update_column(self.storable_file_column, storable_url)
  end
end
