class DataFile < ActiveRecord::Base
  mount_uploader :filename, CsvFileUploader
	attr_accessible :attachable_id, :attachable_type, :filename
	belongs_to :attachable, :polymorphic => true

	def self.save(file)
		name = 'test.lol' # upload.basename
		directory = "public/files"
		path = File.join(directory, name)
		File.open(path, "wb") { |f| f.write(file.read)}
	end

end
