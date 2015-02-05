module DeviseCurrentUser
  module ApplicationControllerPatch
    def self.included(base)
      base.class_eval do

        skip_before_filter :check_if_login_required, :if => :redactor_request?
        before_filter :auth_redactor_user, :if => :redactor_request?

        def current_user
          User.current.type == "AnonymousUser" ? nil : User.current
        end

        def redactor_authenticate_user!
          # authenticate_admin_user! # devise before_filter
          true if User.current.type != "AnonymousUser"
        end

        def redactor_current_user
          current_user # devise user helper
        end

        private

        def auth_redactor_user
          User.current= User.find_by_api_key(params[:key])
        end

        def redactor_request?
          request.path.include?("pictures") || request.path.include?("documents")
        end
      end
    end
  end
end