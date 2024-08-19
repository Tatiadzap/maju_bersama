class EmployersController < ApplicationController
  before_action :set_employer

  def show
  end

  def edit
  end

  def update
    ActiveRecord::Base.transaction do
      @employer.update!(employer_params)
      @user.update!(user_params)
    end

    redirect_to employer_path(@employer), notice: 'Profile was successfully updated.'
  rescue ActiveRecord::RecordInvalid => e
    redirect_to edit_employer_path(@employer), inertia: { errors: e.record.errors.full_messages }
  end

  private

  def set_employer
    @employer = Employer.find(params[:id])
    @user = @employer.user
  end

  def employer_params
    params.require(:employer).permit(:company_name, :industry, :website, :company_description)
  end

  def user_params
    params.require(:user).permit(:phone, :address, :city, :state, :zip_code, :country)
  end
end
