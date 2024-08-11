class CandidatesController < ApplicationController
  before_action :set_candidate, only: %i[ show edit update ]

  def show
    fetch_experience
    fetch_education
  end

  def edit
  end

  def update
    ActiveRecord::Base.transaction do
      @candidate.update!(candidate_params)
      @user.update!(user_params)
    end

    redirect_to candidate_path(@candidate), notice: 'Profile was successfully updated.'
    rescue ActiveRecord::RecordInvalid => e
    redirect_to edit_candidate_path(@candidate), inertia: { errors: e.record.errors.full_messages }
  end

  private

  def set_candidate
    @candidate = Candidate.find(params[:id])
    @user = @candidate.user
  end

  def fetch_experience
    @experiences = Experience.where(candidate: @candidate).order(end_date: :desc)
  end

  def fetch_education
    @educations = Education.where(candidate: @candidate).order(end_date: :desc)
  end

  def candidate_params
    params.require(:candidate).permit(:first_name, :last_name, :resume, :date_of_birth, languages: [])
  end

  def user_params
    params.require(:user).permit(:phone, :address, :city, :state, :zip_code, :country, :bio)
  end
end
