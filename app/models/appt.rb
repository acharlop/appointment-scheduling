class Appt < ActiveRecord::Base
	def self.by_id id
		self.find_by(id: id)
	end
end
