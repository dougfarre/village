class EventValidator < ActiveModel::Validator
	def validate(record)
		if (record.end_date - record.start_date).to_i <= 0
			record.errors[:base] << "The start and end dates are not valid."
		end
	end
end
