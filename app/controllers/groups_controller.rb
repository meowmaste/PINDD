class GroupsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  skip_load_resource only: [:create]
  before_action :no_default_access, only: [:show, :edit, :update, :destroy]

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.where(default_group: false).includes(:users).where("users.id"=>current_user.id)
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
    @group = Group.new(group_params.slice!(:"add_member",:"remove_member"))
    @group.default_group = false

    add_member = User.find_by(email: group_params[:"add_member"])

    respond_to do |format|
      if @group.save
        @group.users << current_user
        @group.users << add_member unless add_member.nil?
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render action: 'show', status: :created, location: @group }
      else
        format.html { render action: 'new' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    add_member = User.find_by(email: group_params[:"add_member"])
    remove_member = User.find_by(email: group_params[:"remove_member"])

    respond_to do |format|
      if @group.update(group_params.slice!(:"add_member",:"remove_member"))
        @group.users << add_member unless add_member.nil?
        @group.users.delete(remove_member) unless remove_member.nil?
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
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
      params.require(:group).permit(:name, :color, :add_member, :remove_member)
    end

    def no_default_access
      if @group.default_group
        redirect_to groups_path
      end
    end
end
