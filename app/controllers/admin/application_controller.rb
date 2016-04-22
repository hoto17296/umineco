class Admin::ApplicationController < ApplicationController

  before_action :authenticate_admin_user!

  layout 'admin/layouts/application'

end
