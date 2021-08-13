module Users
  class SessionsController < Devise::SessionsController
    def new
      super do |_|
        @users = User.all.limit(5)
      end
    end
  end
end
