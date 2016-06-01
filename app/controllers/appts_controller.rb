class ApptsController < ApplicationController
	
	def index
		@appts = Appt.all
		render json: @appts
	end


	# create return status is either:
	# 200 if you are returning data OR
	# 204 if nothing is being returned
	def create
		@appt = Appt.create(appt_params)
		if @appt.save
			render json: @appt
		else
			render json: { errors: @appt.errors.full_messages }, status: 422
		end
	end



	def update
		@appt = Appt.by_id(params[:id])
		if @appt.update(appt_params)
			render json: @appt, status: 201
		else

		end

	end


	# status codes same as create
	def destroy
		@appt = Appt.by_id(params[:id]).destroy
		render json: @appt
	end



	private

	def appt_params
		params.require(:appt).permit(:start_time, :end_time, :first_name, :last_name, :comments)
	end
end
