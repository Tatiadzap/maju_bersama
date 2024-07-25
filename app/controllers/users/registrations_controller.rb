class Users::RegistrationsController < Devise::RegistrationsController
  # GET /sign_up
  def new
    render inertia: 'Auth/Register', props: {}
  end

  # POST /sign_up
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      create_associated_profile(resource) # Create Candidate or Employer profile
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_in_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end

  def create_associated_profile(user)
    if user.role == 'candidate'
      Candidate.create(user: user, first_name: params[:user][:first_name], last_name: params[:user][:last_name])
      puts "candidate created"
    elsif user.role == 'employer'
      Employer.create(user: user)
      puts "employer created"
    end
  end
end
