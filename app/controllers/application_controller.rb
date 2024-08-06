class ApplicationController < ActionController::Base
  use_inertia_instance_props
  include InertiaCsrf

  inertia_share auth: -> {
    if user_signed_in?
      {
        user: {
          id: current_user.id,
          email: current_user.email,
          role: current_user.role,
          candidate: current_user.role == 'candidate' ? Candidate.find_by(user: current_user) : nil,
          employer: current_user.role == 'employer' ? Employer.find_by(user: current_user) : nil
        }
      }
    else
      {
        user: nil
      }
    end
  }
end
