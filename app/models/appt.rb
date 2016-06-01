class Appt < ActiveRecord::Base

	# before_validation :str_to_date
	validates :first_name, :last_name, presence: true

	# end time validates both for better error handling
	validates_datetime :start_time, after: lambda {Time.now}
	validates_datetime :end_time, 	on_or_after: lambda {Time.now}, 
																	after: :start_time

	def self.by_id id
		self.find_by(id: id)
	end



	private

	def str_to_date
		p Chronic.parse(start_time)
		self.start_time = Chronic.parse(start_time).to_datetime
		unless self.start_time
			errors.add(:start_time, "must be a valid date")
		end

		if end_time
			end_time = Chronic.parse(end_time).to_datetime
		end
	end


end
