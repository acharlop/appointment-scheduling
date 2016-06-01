require "csv"

CSV.foreach("app/assets/appt_data.csv", {headers: true}) do |appt|
	Appt.create(
		start_time: appt["start_time"],
		end_time: 	appt["end_time"],
		first_name: appt["first_name"],
		last_name: 	appt["last_name"],
		comments: 	appt["comments"]
	)
end
