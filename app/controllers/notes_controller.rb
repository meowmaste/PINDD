class NotesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  skip_load_resource only: [:create]

  # GET /notes
  # GET /notes.json
  def index
    if params[:groups]
      groups = current_user.groups.where(id: params[:groups])
      @notes = Note.where(group_id: groups)
    end
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)

    # respond_to do |format|
      if @note.save
        redirect_to notes_url, notice: 'Note was successfully created.'
        # format.html { redirect_to notes_url, notice: 'Note was successfully created.' }
        # format.json { render action: 'show', status: :created, location: @note }
      else
        render action: "new"
      #   format.html { render action: 'new' }
      #   format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    # end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    # respond_to do |format|
      if @note.update(note_params)
        sync_update @note
        redirect_to notes_url, notice: 'Note was successfully updated.' 
        # format.html { redirect_to notes_url, notice: 'Note was successfully updated.' }
        # format.json { head :no_content }
      else
        render action: 'edit'
        # format.html { render action: 'edit' }
        # format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    # end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    redirect_to notes_url 
    # respond_to do |format|
    #   format.html { redirect_to notes_url }
    #   format.json { head :no_content }
    # end
  end

  # PUT /notes/1/toggle
  def toggle
    @note = Note.find(params[:id])
    if @note.update_attributes(:check => params[:check])
      @note.send_complete_note_text(current_user)
      sync_update @note
      render 'toggle'
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:content, :check, :group_id)
    end
end
