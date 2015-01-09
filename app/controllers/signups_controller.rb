class SignupsController < ApplicationController

  # GET /signups/new
  def new
    @signup = Signup.new
  end

  # POST /signups
  # POST /signups.json
  def create
    @signup = Signup.new(options)

    if @signup.save
      redirect_to @signup.user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

private

  def options
    params[:signup]
      .merge(remote_ip: request.remote_ip)
      .merge(s: cookies[:s], ca: cookies[:ca], t: cookies[:t])
  end
end
