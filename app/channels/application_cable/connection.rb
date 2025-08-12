module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include SetCurrentRequestDetails

    identified_by :current_user, :current_account, :true_user
    impersonates :user

    delegate :params, :session, to: :request

    def connect
      self.current_user = find_verified_user
      set_request_details if current_user
      self.current_account = Current.account

      if current_user && current_account
        logger.add_tags "ActionCable", "User #{current_user.id}", "Account #{current_account.id}"
      elsif current_user
        logger.add_tags "ActionCable", "User #{current_user.id}", "No Account"
      else
        logger.add_tags "ActionCable", "Guest User"
      end
    end

    protected

    def find_verified_user
      if (user = env["warden"]&.user(:user))
        user
      else
        # Allow guest users - don't reject the connection
        # You might want to create a guest user here or return nil
        nil
      end
    end

    def user_signed_in?
      !!current_user
    end

    # Used by set_request_details
    def set_current_tenant(account)
      ActsAsTenant.current_tenant = account
    end
  end
end
