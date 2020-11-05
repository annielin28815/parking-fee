class ParkController < ApplicationController
  def index
    @park = Park.all
  end

  def new
    calc
  end



  private
    def park_params
      params.permit(:vehicle_type, :parking_hour)
    end

    # 停車場的收費方式為：
    # 機車：不計時數，每天 20 元
    # 汽車：前 2 個小時，每小時 40 元；超過 2 小時之後每小時 30 元。未滿一小時以一小時計費。停車費每天最高上限為 500 元。
    def calc
      @fee = 0
      parking_hour = park_params[:parking_hour].to_f.ceil

      return if park_params[:vehicle_type].blank?
      case park_params[:vehicle_type].to_sym
      when :motocycle
        @fee = 20 
      when :car
        if parking_hour <= 2
          @fee = parking_hour * 40
        else parking_hour > 2
          @fee = 80 + (parking_hour - 2) * 30
        end

        if @fee >= 500
          @fee = 500
        end
      end
    end
end
