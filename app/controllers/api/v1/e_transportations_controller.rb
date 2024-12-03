module Api
  module V1
    class ETransportationsController < ApplicationController
      before_action :set_e_transportation, only: [:show, :update, :destroy, :edit]

      # GET /api/v1/e_transportations
      def index
        @e_transportations = ETransportation.all
        render json: @e_transportations, status: :ok
      end

      # GET /api/v1/e_transportations/:id

      def show
        render json: @e_transportation, status: :ok
      end

      # POST /api/v1/e_transportations
      def create
        @e_transportation = ETransportation.new(e_transportation_params)

        if @e_transportation.save
          render json: @e_transportation, status: :created
        else
          render json: { errors: @e_transportation.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # GET /api/v1/e_transportations/:id/edit
      def edit
        render json: @e_transportation, status: :ok
      end

      # PATCH/PUT /api/v1/e_transportations/:id
      def update
        if @e_transportation.update(e_transportation_params)
          render json: @e_transportation, status: :ok
        else
          render json: { errors: @e_transportation.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /e_transportations/:id
      def destroy
        @e_transportation.destroy
        head :no_content
      end

      # GET /api/v1/count
      def count
        counts = ETransportation.group(:transportation_type, :sensor_type)
                                 .where(in_zone: false)
                                 .count
        render json: counts, status: :ok
      end

      private

      def set_e_transportation
        @e_transportation = ETransportation.find_by(id: params[:id])

        unless @e_transportation
          render json: { error: "ETransportation not found" }, status: :not_found
        end
      end

      def e_transportation_params
        params.require(:e_transportation).permit(:transportation_type, :sensor_type, :owner_id, :in_zone, :lost_sensor)
      end
    end
  end
end
