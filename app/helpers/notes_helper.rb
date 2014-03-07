module NotesHelper
  def note_color note
    if note.my_note?
      "rgb(255,255,136)"
    else
      note.group.color || "#ADC1D6"
    end
  end

  def font_size note
    if note.content.length < 25
      return "font-size:40px;line-height:45px"
    elsif note.content.length < 55
      return "font-size:32px;line-height:35px"
    elsif note.content.length < 75
      return "font-size:24px;line-height:30px"
    elsif note.content.length < 105
      return "font-size:22px;line-height:25px"
    end
      "font-size:18px;line-height:20px"
  end
end
