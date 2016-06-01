class Appt < ActiveRecord::Base

	after_initialize :fix_dates

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

		where("start_time >= ? AND end_time <= ?", start_date, end_date)
	end



	private

	def fix_dates
		if start_time.year.to_s.length != 4
			year = Time.now.year.to_s[0..1]
			start = "#{year}#{self.start_time.to_s[2..-5]}"
			end_d = "#{year}#{self.end_time.to_s[2..-5]}"
			self.start_time = Chronic.parse(start)
			self.end_time 	= Chronic.parse(end_d)
		end

	end
	
	def no_current_appointment
		args = {"start": start_time.to_s, "end": end_time.to_s}.stringify_keys
		unless Appt.search(args).empty?
			errors.add(:start_time, "appointment schedule overlap")
		end
	end

end
