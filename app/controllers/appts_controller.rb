class ApptsController < ApplicationController
	skip_before_filter  :verify_authenticity_token

	def index
		@appts = Appt.search params
		render json: @appts
	end



	def create
		@appt = Appt.new(appt_params)
		if @appt.save
			render json: @appt, status: 201
		else
			p @appt
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
		pars = params.require(:appt).permit(:start_time, :end_time, :first_name, :last_name, :comments)
		pars[:start_time] = Chronic.parse(params[:start_time]).to_s
		pars[:end_time	 ] = Chronic.parse(params[:end_time	 ]).to_s
		pars
	end
	
end
