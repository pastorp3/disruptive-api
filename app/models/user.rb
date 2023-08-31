class User < ApplicationRecord
  has_secure_password

  has_one :wallet

  after_create :create_wallet

  private

  def create_wallet
    Wallet.create(balance: 0, user_id: self.id)
  end
end