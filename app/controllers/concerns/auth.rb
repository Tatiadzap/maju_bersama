require 'active_support/concern'

module Auth
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!, unless: :skip_authentication?
  end

  private

  # Define which actions or controllers should skip authentication
  def skip_authentication?
    # Skip authentication for the PagesController
    controller_name == 'pages'
  end

  def after_sign_in_path_for(resource)
    case resource.role
    when 'candidate'
      edit_candidate_path(resource.candidate)
    when 'employer'
      edit_employer_path(resource.employer)
    else
      stored_location_for(resource) || root_path
    end
  end
end
