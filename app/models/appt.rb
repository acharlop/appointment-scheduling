class Appt < ActiveRecord::Base

	after_initialize :two_digit_year



	validates :first_name, :last_name, presence: true
	validate :no_current_appointment

	# end time validates both for better error handling
	validates_datetime :start_time, after: lambda {Time.now}
	validates_datetime :end_time, 	on_or_after: lambda {Time.now}, after: :start_time



	def self.by_id id
		self.find_by(id: id)
	end



	def self.search params
		start_date = Chronic.parse params["start"]
		start_date = start_date ? start_date.to_datetime : 100.years.ago

		end_date = Chronic.parse params["end"]
		end_date = end_date ? end_date.to_datetime : 100.years.from_now

		where("start_time > ? AND end_time < ?", start_date, end_date)
	end



	private


	# search in 
	def no_current_appointment
		args = {"start": start_time.to_s, "end": end_time.to_s}.stringify_keys
		unless Appt.search(args).empty?
			errors.add(:start_time, "appointment schedule overlap")
		end
	end

	# should probably be moved to default behavior
	# checks length of year and inserts first 2 digits if necessary
	def two_digit_year
		if start_time && start_time.year.to_s.length == 2
			new_year =  four_digit_year start_time
			self.start_time = start_time.change({year: new_year})
		end
		if end_time && end_time.year.to_s.to_s.length == 2
			new_year =  four_digit_year end_time
			self.end_time = end_time.change({year: new_year})
		end
	end

	def four_digit_year date
		Time.now.year.to_s[0..1] << date.year.to_s[-2..-1]
	end


end
