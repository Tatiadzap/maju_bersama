class EmployersController < ApplicationController
  before_action :set_employer

  def show
  end

  private
  def set_employer
    @employer = Employer.find(params[:id])
    @user = @employer.user
  end
end
