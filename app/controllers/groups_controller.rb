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
    @notes = @group.notes
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

    respond_to do |format|
      if @group.save
        @group.users << current_user
        process_add_member unless group_params[:"add_member"].empty?
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
    process_add_member unless group_params[:"add_member"].empty?
    process_remove_member unless group_params[:"remove_member"].nil? || group_params[:"remove_member"].empty?

    respond_to do |format|
      if @group.update(group_params.slice!(:"add_member",:"remove_member"))
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

    def process_add_member
      add_member = User.find_by(email: group_params[:"add_member"])
      if add_member
        @group.users << add_member
        flash[:add_member] =  group_params[:"add_member"] + ' was added to group.'
      else
        flash[:add_member_fail] = group_params[:"add_member"] + ' was not added to group.'
      end
    end

    def process_remove_member
      remove_member = User.find_by(email: group_params[:"remove_member"])
      if remove_member
        @group.users.delete(remove_member)
        flash[:remove_member] =  group_params[:"remove_member"]+' was removed from group.'
      else
        # shouldn't get here....
      end
    end
end
