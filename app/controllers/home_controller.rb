# frozen_string_literal: true

# controller class
class HomeController < ApplicationController
  def input; end

  def result
    @home = HomeResult.new(home_params)
  end

  private

  def home_params
    params.permit(:arr, :num)
  end
end
