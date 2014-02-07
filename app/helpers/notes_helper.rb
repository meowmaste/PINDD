module NotesHelper
	def note_color note
		if note.my_note?
			"rgb(255,255,136)"
		else
			note.group.color || "#ADC1D6"
		end
	end

  def font_size note
    if note.content.length < 20
      return "font-size:50px;line-height:55px"
    elsif note.content.length < 50
      return "font-size:40px;line-height:45px"
    elsif note.content.length < 100
      return "font-size:30px;line-height:35px"
    end
    "font-size:20px;line-height:22px"
  end
end
