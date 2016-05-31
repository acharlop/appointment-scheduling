class ApptsController < ApplicationController
	
	def index
		@appts = Appt.all
		render json: @appts
	end



	def create
		@appt = Appt.new(appt_params)
	end



	def update
		@appt = Appt.by_id(params[:id])
		@appt.update(appt_params)
	end



	def destroy
		@appt = Appt.by_id(params[:id]).destroy
	end


	
	private

	def appt_params
		params.require(:appt).permit(:start_time, :end_time, :first_name, :last_name, :comments)
	end
end
