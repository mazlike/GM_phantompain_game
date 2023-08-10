// disable player movement
global.moveble = false

textbox_x = x + 170
textbox_y = y + 250
//textbox_x = x + camera_get_view_width(view_camera[0])/2
//textbox_y = y + camera_get_view_height(view_camera[0])-50
textbox_height = 100
textbox_width = 300

text_x_offset = 20
text_y_offset = 25
heading_y_offset = 8

clr_heading = #fcdd76

page = 0
maxpage = array_length(speakLine)
text_line_length = textbox_width - text_x_offset*2
lineSpacing = floor(font_get_size(fnt_battleMenu) * 1.40)

textPauseTimer = 0
textPauseTime = 16

drawchar = 0
messageSpeed = 0.5
