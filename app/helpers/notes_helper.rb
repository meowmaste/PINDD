module NotesHelper
	def note_color note
		if note.my_note?
			"rgb(255,255,136)"
		else
			note.group.color || "#ADC1D6"
		end 
	end
end
