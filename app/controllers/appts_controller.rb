class ApptsController < ApplicationController
	
	def index
		@appts = Appt.all
		render json: @appts
	end



	def create
		@appt = Appt.create(appt_params)
		if @appt.save
			render json: @appt, status: 201
		else
			render json: { errors: @appt.errors.full_messages }, status: 400
		end
	end



	def update
		@appt = Appt.by_id(params[:id])
		if @appt.update(appt_params)
			render json: @appt
		else
			render json: { errors: @appt.errors.full_messages }, status: 400
		end
	end


	
	def destroy
		@appt = Appt.by_id(params[:id])
		if @appt
			render json: @appt.destroy
		else
			render json: {errors: "appointment not found"}, status: 400
		end
	end



	private

	def appt_params
		params.require(:appt).permit(:start_time, :end_time, :first_name, :last_name, :comments)
	end
end
