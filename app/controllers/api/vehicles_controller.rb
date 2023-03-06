class Api::VehiclesController < ApplicationController
  def index
    user = User.find(params[:id])
    user.vehicles.order(created_at: :desc)
  end

  def show
    Vehicles.find(params[:id])
  end

  def create
    vehicle = current_user.vehices.new(vehicles_params)

    if vehicle.save
      flash[:notice] = 'vehicle created successfully'
      render json: booking
    else
      render json: booking.errors, status: :vehicle_not_created
    end
  end

  def update
    vehicle = Vehicle.find(params[:id])
    if vehicle.update(vehicles_params)
      flash[:notice] = 'vehicle updated successfully'
      render json: booking
    else
      render json: booking.errors, status: :vehicle_not_updated
    end
  end

  def destroy
    vehicle = Vehicle.find(params[:id])
    if vehicle.destroy
      flash[:notice] = 'vehicle deleted successfully'
      render json: booking
    else
      render json: booking.errors, status: :vehicle_not_deleted
    end
  end

  private

  def vehicles_params
    params.require(:vehicles).permit(:name, :image, :model, :description, :daily_price, :availability)
  end
end