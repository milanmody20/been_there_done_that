class PinsController < ApplicationController
    before_action :redirect_if_not_logged_in            #method defined in application_controller

    def index
        if params[:destination_id] && @destination = Destination.find_by_id(params[:destination_id])
            @pins = @destination.pins
        else
            @pins = Pin.all
        end
    end

    def new
        @pin = Pin.new
        @pin.build_destination
    end

    def create
        @pin = Pin.new(pin_params)
        if @pin.save
            redirect_to pins_path
        else 
            render :new
        end
    end

    def show
        find_pin
    end

    def edit
        find_pin
    end

    def update
        find_pin
        @pin.update(pin_params)
        if @pin.valid?
            redirect_to pins_path(@pin)
        else
            render :edit
        end
    end

    def destroy
        find_pin
        @pin.destroy
            redirect_to pins_path
    end

    private
    def pin_params
        params.require(:pin).permit(:rating, :destination_id, destination_attributes: [:city, :state, :country])
    end

    def find_pin
        @pin = Pin.find_by_id(params[:id])
    end


end