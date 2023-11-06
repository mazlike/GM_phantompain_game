global.pause		= true
global.view_width	= camera_get_view_width(view_camera[0])
global.view_height	= camera_get_view_height(view_camera[0])

display_set_gui_size(global.view_width,global.view_height)
draw_set_font(fnt_battleMenu)


enum menu_page
{
	main,
	settings,
	load,
	audio,
	graphics,
	controls,
	height
}

enum menu_element_type
{
	script_runner,
	page_transfer,
	slider,
	shift,
	toggle,
	input
}

// create menu pages
ds_menu_start = create_menu_page(
	["NEW GAME",	menu_element_type.script_runner,	new_game],
	["CONTINUE",	menu_element_type.script_runner,	continue_game],
	["LOAD",		menu_element_type.page_transfer,	menu_page.load],
	["SETTINGS",	menu_element_type.page_transfer,	menu_page.settings],
	["EXIT",		menu_element_type.script_runner,	exit_game],
)

ds_menu_main = create_menu_page(
	["RESUME",		menu_element_type.script_runner,	resume_game],
	["SETTINGS",	menu_element_type.page_transfer,	menu_page.settings],
	["EXIT",		menu_element_type.script_runner,	exit_game],
)

ds_settings = create_menu_page(
	["AUDIO",		menu_element_type.page_transfer,	menu_page.audio],
	["GRAPHICS",	menu_element_type.page_transfer,	menu_page.graphics],
	["CONTROLS",	menu_element_type.page_transfer,	menu_page.controls],
	["BACK",		menu_element_type.page_transfer,	menu_page.main],
)

ds_menu_load = create_menu_page(
	["EMPTY",	menu_element_type.script_runner,	load_game],
	["EMPTY",	menu_element_type.script_runner,	load_game],
	["EMPTY",	menu_element_type.script_runner,	load_game],
	["BACK",	menu_element_type.page_transfer,	menu_page.main],
)

ds_menu_audio = create_menu_page(
	["MASTER",		menu_element_type.slider,			change_volume,			1,		[0,1]],
	["SOUNDS",		menu_element_type.slider,			change_volume,			1,		[0,1]],
	["MUSIC",		menu_element_type.slider,			change_volume,			1,		[0,1]],
	["BACK",		menu_element_type.page_transfer,	menu_page.settings],
)

ds_menu_graphics = create_menu_page(
	["RESOLUTION",	menu_element_type.shift,			change_resolution,		0,		["1280 x 720", "1920 x 1080", "2560 x 1440" ]],
	["WINDOW MODE",	menu_element_type.toggle,			change_window_mode,		1,		["FULLSCREEN","WINDOWED MODE"]],
	["BACK",		menu_element_type.page_transfer,	menu_page.settings],
)

//ds_menu_controls = create_menu_page(
//	["UP",			menu_element_type.input,			],
//	["LEFT",		menu_element_type.input,			],
//	["RIGHT",		menu_element_type.input,			],
//	["DOWN",		menu_element_type.input,			],
//	["BACK",		menu_element_type.page_transfer,	menu_page.settings],
//)

page = 0
if room == rMainMenu
{
	menu_pages = [ds_menu_start, ds_settings, ds_menu_load, ds_menu_audio, ds_menu_graphics]
}
else
{
	menu_pages = [ds_menu_main, ds_settings, ds_menu_audio, ds_menu_graphics]
}

var i = 0, array_len = array_length_1d(menu_pages)
repeat (array_len)
{
	menu_option[i] = 0
	i++
}

inputting = false

audio_group_load(audiogroup_music)
audio_group_load(audiogroup_soundeffects)