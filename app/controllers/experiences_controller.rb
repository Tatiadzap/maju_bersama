class ExperiencesController < ApplicationController
  before_action :set_candidate, only: [:create]
  before_action :set_experience, only: [:update]

  def create
    @experience = @candidate.experiences.new(experience_params)
    if @experience.save
      render json: @experience, status: :created
    else
      render json: @experience.errors, status: :unprocessable_entity
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
