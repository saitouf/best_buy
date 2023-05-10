module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_customer

    def connect
      reject_unauthorized_connection unless find_verified_customer
    end

    private

    def find_verified_customer
      self.current_customer = env['warden'].user
    end
  end
end
