class Appt < ActiveRecord::Base

	validates :start_time, :end_time, :first_name, :last_name, presence: true

	validate :appt_in_the_future


	def self.by_id id
		self.find_by(id: id)
	end



	private

	def appt_in_the_future
		errors.add(:start_time, "must be in the future") unless start_time > Time.now
		errors.add(:end_time, 	"must be in the future") unless end_time 	 > Time.now
		errors.add(:end_time, 	"must be after start time") unless end_time > start_time
	end
end
