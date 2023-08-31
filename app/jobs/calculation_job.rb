require 'csv'

class CalculationJob < ApplicationJob
  def initialize(coin, value, investment_months, initial_balance)
    @coin = coin
    @coin_value = value
    @investment_months = investment_months
    @initial_balance = initial_balance.to_i
  end

  def perform
    current_balance = @initial_balance * @coin_value
    coin_type = get_coin_type
    data = get_csv_data
    monthly_growth_rate = data[coin_type]["Interes_mensual"].to_i


    @investment_months.times do
      monthly_growth = (@coin_value * monthly_growth_rate) / 100
      current_balance += monthly_growth
    end
  
    current_balance
  end

  private
  
  def get_csv_data
    file_path = Rails.root.join('public', 'origen.csv')
    column_names = ['Interes_mensual', 'balance_ini']
    extracted_data = []

    CSV.foreach(file_path, headers: true) do |row|
      data = {}
      column_names.each do |column_name|
          data[column_name] = row[column_name]
      end
      extracted_data << data
    end

    extracted_data
  end

  def get_coin_type
    case @coin
    when 'BTC'
      return 0
    when 'ETH'
      return 1
    end
      return 2
  end
end