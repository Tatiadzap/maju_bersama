class CandidateDisabilitiesController < ApplicationController
  before_action :set_candidate
  before_action :set_candidate_disability, only: [:update]

  def create
    @candidate_disability = @candidate.candidate_disabilities.new(candidate_disability_params)
    if @candidate_disability.save
      render json: @candidate_disability.as_json(include: :disability), status: :created
    else
      # Log the parameters and validation errors
      Rails.logger.debug "Failed to create CandidateDisability"
      Rails.logger.debug "Parameters: #{candidate_disability_params.inspect}"
      Rails.logger.debug "Validation errors: #{@candidate_disability.errors.full_messages}"

      render json: @candidate_disability.errors, status: :unprocessable_entity
    end
  end

  def update
    if @candidate_disability.update(candidate_disability_params)
      render json: @candidate_disability.as_json(include: :disability), status: :ok
    else
      # Log the parameters and validation errors
      Rails.logger.debug "Failed to update CandidateDisability"
      Rails.logger.debug "Parameters: #{candidate_disability_params.inspect}"
      Rails.logger.debug "Validation errors: #{@candidate_disability.errors.full_messages}"

      render json: @candidate_disability.errors, status: :unprocessable_entity
    end
  end

  private

  def set_candidate
    @candidate = Candidate.find(params[:candidate_id])
  end

  def set_candidate_disability
    @candidate_disability = CandidateDisability.find(params[:id])
  end

  def candidate_disability_params
    params.require(:candidate_disability).permit(:disability_id, :details)
  end
end
