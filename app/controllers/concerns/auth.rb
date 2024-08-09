require 'active_support/concern'

module Auth
  extend ActiveSupport::Concern

  included do
    # before_action :authenticate_user!
  end

  private

  def after_sign_in_path_for(resource)
    if resource.role == 'candidate'
      edit_candidate_path(resource.candidate)
    elsif resource.role == 'employer'
      edit_employer_path(resource.employer)
    else
      stored_location_for(resource) || root_path
    end
  end
end
