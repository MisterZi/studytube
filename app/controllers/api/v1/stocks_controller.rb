module Api
  module V1
    class StocksController < ApplicationController
      rescue_from(ActiveRecord::RecordNotFound) do |ex|
        render_error "#{ex.model} not found", status: :not_found
      end

      rescue_from(ActiveRecord::RecordInvalid) do |ex|
        render_validation_error ex.record
      end

      def index
        render_json stocks
      end

      # Perhaps I misunderstood the third point of the task
      # ("If you need to change the bearer, a new object needs to be created"),
      # so lets discuss implementation
      def create
        new_stock = ApplicationRecord.transaction do
          Stock.create!(bearer:, name: stock_params[:name])
        end

        render_json new_stock, status: :created
      end

      # Perhaps I misunderstood the third point of the task
      # ("If you need to change the bearer, a new object needs to be created"),
      # so lets discuss implementation
      def update
        ApplicationRecord.transaction do
          stock.name = stock_params[:name]
          stock.bearer = bearer if stock_params[:bearer_name]
          stock.save!
        end

        render_json stock
      end

      def destroy
        # soft delete (see stock model)
        stock.destroy
      end

      private

      def stock_params
        params.require(:stock).permit(:bearer_name, :name)
      end

      def stock
        @stock ||= Stock.find(params.require(:id))
      end

      def stocks
        @stocks ||= Stock.includes(:bearer)
      end

      def bearer
        @bearer||= Bearer.find_or_create_by!(name: stock_params[:bearer_name])
      end

      def render_validation_error(obj)
        render_error("Validation failed for #{obj.class.name}: #{obj.errors.full_messages.join(', ')}")
      end
    end
  end
end
