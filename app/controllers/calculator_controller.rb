class CalculatorController < ApplicationController
  def calculate
    calculation = CalculationJob.new(params[:coin], params[:coin_value], 12, params[:invest]).perform

    render :json => calculation
  end
end