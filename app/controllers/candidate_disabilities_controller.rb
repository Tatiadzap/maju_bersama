class CandidateDisabilitiesController < ApplicationController
  before_action :set_candidate, only: %i[ create]
  before_action :set_candidate_disability, only: %i[ edit update destroy]

  def create

  end

  private

  def set_candidate
    @candidate = Candidate.find(params[:candidate_id])
  end

  def set_candidate_disability
    @candidate_disability = CandidateDisability.find(params[:id])
  end

  def candidate_disabilities_params
    params.require(:candidate_disability).permit(:candidate_id, :disability_id, :details)
  end
end
