class UsersController < ApplicationController

  PAGINATION_LIMIT = 5

  layout 'users'

  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.order(:name)
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    @user.build_address
  end

  # GET /users/1/edit
  def edit
    @address = @user.address
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    @user.build_address(user_params[:address_attribute])
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: "User #{@user.name} was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, notice: "User #{@user.name} was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User #{@user.name} successfully destroyed." }
      format.json { head :no_content }
    end
  end

  rescue_from 'User::Error' do |exception|
    redirect_to users_url, notice: exception.message
  end

  def orders
    @order = current_user.orders
  end

  def line_Items
    @page_number = params[:page] ? params[:page].to_i : 1
    @total_pages = (current_user.line_items.count / PAGINATION_LIMIT).ceil
    @line_Item = current_user.line_items.limit(PAGINATION_LIMIT).offset(PAGINATION_LIMIT * (@page_number - 1))
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, address_attributes: [:city, :state, :country, :pincode])
    end
end
