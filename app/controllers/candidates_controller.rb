class CandidatesController < ApplicationController
  # include Auth
  before_action :set_candidate, only: %i[ show ]

  # def index
  #   @candidates = Candidate.all.order(:id)
  # end

  def show
    fetch_experience
    fetch_education
  end

  # def edit
  # end

  # def update
  #   if @candidate.update(candidate_params)
  #     redirect_to candidates_path, notice: 'Candidate was successfully updated.'
  #   else
  #     redirect_to edit_candidate_path(@candidate), inertia: { errors: @candidate.errors }
  #   end
  # end

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

  # def candidate_params
  #   params.fetch(:candidate, {}).permit(:first_name, :last_name)
  # end
end
