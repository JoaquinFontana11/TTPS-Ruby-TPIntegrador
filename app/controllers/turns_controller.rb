class TurnsController < ApplicationController

    def home
        @turns = Turn.all
        render "turns/home"
    end

    def show
        @turn = Turn.find(params[:id])
    end

    def new
        puts "------------------------------------"
        puts params
        puts "------------------------------------"
        @turn = Turn.new turn_params
    end

    private

    def turn_params
        params.fetch(:turn, {}).permit(:date, :hour,:state, :reaseon)

    end
end


