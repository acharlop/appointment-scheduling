require "csv"

def csv_date(str)
	DateTime.strptime(str,"%m/%d/%y %H:%M")
end

CSV.foreach("app/assets/appt_data.csv", {headers: true}) do |appt|
	Appt.create(
		start_time: csv_date(appt["start_time"]),
		end_time: 	csv_date(appt["end_time"]),
		first_name: appt["first_name"],
		last_name: 	appt["last_name"],
		comments: 	appt["comments"]
	)
end
