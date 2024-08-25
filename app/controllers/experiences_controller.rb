class ExperiencesController < ApplicationController
  before_action :set_candidate, only: [:create]
  before_action :set_experience, only: [:update]

  def create
    @candidate_disability = @candidate.candidate_disabilities.new(candidate_disability_params)
    if @candidate_disability.save
      render json: @candidate_disability.as_json(include: :disability), status: :created
    else
      Rails.logger.debug "Failed to create CandidateDisability: #{candidate_disability_params.inspect}"
      Rails.logger.debug "Validation errors: #{@candidate_disability.errors.full_messages}"
      render json: @candidate_disability.errors, status: :unprocessable_entity
    end
  end

  def update
    if @experience.update(experience_params)
      render json: @experience, status: :ok
    else
      render json: @experience.errors, status: :unprocessable_entity
    end
  end

  private

  def set_candidate
    @candidate = Candidate.find(params[:candidate_id])
  end

  def set_experience
    @experience = Experience.find(params[:id])
  end

  def experience_params
    params.require(:experience).permit(:job_title, :company_name, :start_date, :end_date, :description)
  end
end
