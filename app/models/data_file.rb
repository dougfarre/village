class DataFile < ActiveRecord::Base
	def self.save(upload)
		name = upload['datafile'].origonal_filename
		directory = "public/file"
		path = File.join(directory, name)
		File.open(path, "wb") { |f| f.write(upload['datafile'].read)}
		end
	end

end
