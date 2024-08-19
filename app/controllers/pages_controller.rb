class PagesController < ApplicationController
  before_action :ignoreLayout

  def home
  end

  def playground
  end

  private

  def ignoreLayout
    render inertia: "pages/#{action_name}", props: { ignoreStyles: true }
  end
end
