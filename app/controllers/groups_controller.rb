class GroupsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  skip_load_resource only: [:create]
  before_action :no_default_access, only: [:show, :edit, :update, :destroy]
  before_action :get_slice_params, only: [:create, :update]
  respond_to :html, :json

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.where(default_group: false).includes(:users).where("users.id" => current_user.id)
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
  end

  # GET /groups/new
  def new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(@group_params)
    @group.default_group = false

    if @group.save
      @group.users << current_user
      process_add_member unless @member_to_add.blank?
      respond_to do |format|
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render action: 'show', status: :created, location: @group }
      end
    else
      respond_to do |format|
        format.html { render action: 'new' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    process_add_member unless @member_to_add.blank?
    process_remove_member unless @member_to_remove.blank?

    if @group.update(@group_params)
      respond_to do |format|
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { render action: 'edit' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy unless @group.default_group
    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :color, :member_to_add, :member_to_remove)
    end

    def get_slice_params
      @group_params = group_params.slice!(:member_to_add, :member_to_remove)
      @member_to_add = group_params[:member_to_add]
      @member_to_remove = group_params[:member_to_remove]
    end

    def no_default_access
      if @group.default_group?
        redirect_to groups_path
      end
    end

    def process_add_member
      if @group.add_member(@member_to_add)
        flash[:add_member] = @member_to_add + ' was added to group.'
      else
        flash[:add_member_fail] = @member_to_add + ' was not added to group.'
      end
    end

    def process_remove_member
      if @group.remove_member(@member_to_remove)
        flash[:remove_member] = @member_to_remove + ' was removed from group.'
      end
    end
end
