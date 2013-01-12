


///////////////////////////////////////////////////////////////////////////
/// Styles
///////////////////////////////////////////////////////////////////////////

// Control types
#define CT_STATIC           0
#define CT_BUTTON           1
#define CT_EDIT             2
#define CT_SLIDER           3
#define CT_COMBO            4
#define CT_LISTBOX          5
#define CT_TOOLBOX          6
#define CT_CHECKBOXES       7
#define CT_PROGRESS         8
#define CT_HTML             9
#define CT_STATIC_SKEW      10
#define CT_ACTIVETEXT       11
#define CT_TREE             12
#define CT_STRUCTURED_TEXT  13
#define CT_CONTEXT_MENU     14
#define CT_CONTROLS_GROUP   15
#define CT_SHORTCUTBUTTON   16
#define CT_XKEYDESC         40
#define CT_XBUTTON          41
#define CT_XLISTBOX         42
#define CT_XSLIDER          43
#define CT_XCOMBO           44
#define CT_ANIMATED_TEXTURE 45
#define CT_OBJECT           80
#define CT_OBJECT_ZOOM      81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK        98
#define CT_USER             99
#define CT_MAP              100
#define CT_MAP_MAIN         101
#define CT_LISTNBOX         102

// Static styles
#define ST_POS            0x0F
#define ST_HPOS           0x03
#define ST_VPOS           0x0C
#define ST_LEFT           0x00
#define ST_RIGHT          0x01
#define ST_CENTER         0x02
#define ST_DOWN           0x04
#define ST_UP             0x08
#define ST_VCENTER        0x0C

#define ST_TYPE           0xF0
#define ST_SINGLE         0x00
#define ST_MULTI          0x10
#define ST_TITLE_BAR      0x20
#define ST_PICTURE        0x30
#define ST_FRAME          0x40
#define ST_BACKGROUND     0x50
#define ST_GROUP_BOX      0x60
#define ST_GROUP_BOX2     0x70
#define ST_HUD_BACKGROUND 0x80
#define ST_TILE_PICTURE   0x90
#define ST_WITH_RECT      0xA0
#define ST_LINE           0xB0

#define ST_SHADOW         0x100
#define ST_NO_RECT        0x200
#define ST_KEEP_ASPECT_RATIO  0x800

#define ST_TITLE          ST_TITLE_BAR + ST_CENTER

// Slider styles
#define SL_DIR            0x400
#define SL_VERT           0
#define SL_HORZ           0x400

#define SL_TEXTURES       0x10

// progress bar 
#define ST_VERTICAL       0x01
#define ST_HORIZONTAL     0

// Listbox styles
#define LB_TEXTURES       0x10
#define LB_MULTI          0x20

// Tree styles
#define TR_SHOWROOT       1
#define TR_AUTOCOLLAPSE   2

// MessageBox styles
#define MB_BUTTON_OK      1
#define MB_BUTTON_CANCEL  2
#define MB_BUTTON_USER    4

#define GUI_GRID_X	(0)
#define GUI_GRID_Y	(0)
#define GUI_GRID_W	(0.03125)
#define GUI_GRID_H	(0.05)
#define GUI_GRID_WAbs	(1)
#define GUI_GRID_HAbs	(1)


///////////////////////////////////////////////////////////////////////////
/// Base Classes
///////////////////////////////////////////////////////////////////////////
class RscText
{
	access = 0;
	type = 0;
	idc = -1;
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	text = "";
	fixedWidth = 0;
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	style = 0;
	shadow = 1;
	colorShadow[] = {0,0,0,0.5};
	font = "FontNormal";
	SizeEx = "(			(			(1 / 1.2) / 20) * 0.7)";
	linespacing = 1;
};
class RscStructuredText
{
	access = 0;
	type = 13;
	idc = -1;
	style = 0;
	colorText[] = {1,1,1,1};
	class Attributes
	{
		font = "FontNormal";
		color = "#ffffff";
		align = "left";
		shadow = 1;
	};
	x = 0;
	y = 0;
	h = 0.035;
	w = 0.1;
	text = "";
	size = "(			(			(1 / 1.2) / 20) * 0.7)";
	shadow = 1;
};
class RscPicture
{
	access = 0;
	type = 0;
	idc = -1;
	style = 48;
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	font = "TahomaB";
	sizeEx = 0;
	lineSpacing = 0;
	text = "";
	fixedWidth = 0;
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.2;
	h = 0.15;
};
class RscEdit
{
	access = 0;
	type = 2;
	x = 0;
	y = 0;
	h = 0.04;
	w = 0.2;
	colorBackground[] = {0,0,0,1};
	colorText[] = {0.95,0.95,0.95,1};
	colorSelection[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",1};
	autocomplete = "";
	text = "";
	size = 0.2;
	style = "0x00 + 0x40";
	font = "FontNormal";
	shadow = 2;
	sizeEx = "(			(			(1 / 1.2) / 20) * 0.7)";
};
class RscCombo
{
	access = 0;
	type = 4;
	style = 0;
	colorSelect[] = {0,0,0,1};
	colorText[] = {0,0,0,1};
	colorBackground[] = {0.95,0.95,0.95,1};
	colorScrollbar[] = {0,0,0,1};
	soundSelect[] = {"",0.1,1};
	soundExpand[] = {"",0.1,1};
	soundCollapse[] = {"",0.1,1};
	maxHistoryDelay = 1;
	class ScrollBar
	{
		color[] = {1,1,1,0.6};
		colorActive[] = {1,1,1,1};
		colorDisabled[] = {1,1,1,0.3};
		shadow = 0;
		thumb = "\HSim\UI_H\data\ui_scrollbar_thumb_ca.paa";
		arrowFull = "\HSim\UI_H\data\ui_arrow_top_active_ca.paa";
		arrowEmpty = "\HSim\UI_H\data\ui_arrow_top_ca.paa";
		border = "\HSim\UI_H\data\ui_border_scroll_ca.paa";
	};
	x = 0;
	y = 0;
	w = 0.12;
	h = 0.035;
	shadow = 0;
	colorSelectBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",0.5};
	arrowEmpty = "\HSim\UI_H\data\ui_arrow_combo_ca.paa";
	arrowFull = "\HSim\UI_H\data\ui_arrow_combo_active_ca.paa";
	wholeHeight = 0.45;
	color[] = {0,0,0,0.6};
	colorActive[] = {0,0,0,1};
	colorDisabled[] = {0,0,0,0.3};
	font = "FontNormal";
	sizeEx = "(			(			(1 / 1.2) / 20) * 0.7)";
};
class RscListBox
{
	access = 0;
	type = 5;
	w = 0.4;
	h = 0.4;
	rowHeight = 0;
	colorText[] = {1,1,1,1};
	colorScrollbar[] = {0.95,0.95,0.95,1};
	colorSelect[] = {1,1,1,1};
	colorSelect2[] = {1,1,1,1};
	colorSelectBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",0.5};
	colorSelectBackground2[] = {"(1 - (profilenamespace getvariable 'GUI_BCG_RGB_R'))","(1-(profilenamespace getvariable 'GUI_BCG_RGB_G'))","(1 -(profilenamespace getvariable 'GUI_BCG_RGB_B'))",0.5};
	colorBackground[] = {0,0,0,1};
	soundSelect[] = {"",0.1,1};
	arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
	arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
	class ScrollBar
	{
		color[] = {1,1,1,0.6};
		colorActive[] = {1,1,1,1};
		colorDisabled[] = {1,1,1,0.3};
		shadow = 0;
		thumb = "\HSim\UI_H\data\ui_scrollbar_thumb_ca.paa";
		arrowFull = "\HSim\UI_H\data\ui_arrow_top_active_ca.paa";
		arrowEmpty = "\HSim\UI_H\data\ui_arrow_top_ca.paa";
		border = "\HSim\UI_H\data\ui_border_scroll_ca.paa";
	};
	style = 0x10;
	font = "FontNormal";
	sizeEx = "(			(			(1 / 1.2) / 20) * 0.7)";
	shadow = 1;
	colorShadow[] = {0,0,0,0.5};
	color[] = {1,1,1,1};
	period = 1.2;
	maxHistoryDelay = 1;
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
};
class RscButton
{
	access = 0;
	type = 1;
	text = "";
	colorText[] = {1,1,1,1};
	colorDisabled[] = {0.4,0.4,0.4,1};
	colorBackground[] = {"(profilenamespace getvariable 'GUI_BCG_RGB_R')*0.7","(profilenamespace getvariable 'GUI_BCG_RGB_G')*0.7","(profilenamespace getvariable 'GUI_BCG_RGB_B')*0.7",1};
	colorBackgroundDisabled[] = {0.95,0.95,0.95,1};
	colorBackgroundActive[] = {"(1 - 			(profilenamespace getvariable 'GUI_BCG_RGB_R'))","(1 - 			(profilenamespace getvariable 'GUI_BCG_RGB_G'))","(1 - 			(profilenamespace getvariable 'GUI_BCG_RGB_B'))",1};
	colorFocused[] = {"(1 - 			(profilenamespace getvariable 'GUI_BCG_RGB_R'))","(1 - 			(profilenamespace getvariable 'GUI_BCG_RGB_G'))","(1 - 			(profilenamespace getvariable 'GUI_BCG_RGB_B'))",1};
	colorShadow[] = {0,0,0,1};
	colorBorder[] = {0,0,0,1};
	soundEnter[] = {"\HSim\UI_H\data\sound\onover",0.09,1};
	soundPush[] = {"\HSim\UI_H\data\sound\new1",0,0};
	soundClick[] = {"\HSim\UI_H\data\sound\onclick",0.07,1};
	soundEscape[] = {"\HSim\UI_H\data\sound\onescape",0.09,1};
	style = 2;
	x = 0;
	y = 0;
	w = 0.095589;
	h = 0.039216;
	shadow = 2;
	font = "FontNormal";
	sizeEx = "(			(			(1 / 1.2) / 20) * 0.7)";
	offsetX = 0.003;
	offsetY = 0.003;
	offsetPressedX = 0.002;
	offsetPressedY = 0.002;
	borderSize = 0;
};
class RscShortcutButton
{
	type = 16;
	x = 0.1;
	y = 0.1;
	class HitZone
	{
		left = 0;
		top = 0;
		right = 0;
		bottom = 0;
	};
	class ShortcutPos
	{
		left = 0;
		top = "(			(			(1 / 1.2) / 20) - 		(			(			(1 / 1.2) / 20) * 0.7)) / 2";
		w = "(			(			(1 / 1.2) / 20) * 0.7) * (3/4)";
		h = "(			(			(1 / 1.2) / 20) * 0.7)";
	};
	class TextPos
	{
		left = "(			(			(1 / 1.2) / 20) * 0.7) * (3/4)";
		top = "(			(			(1 / 1.2) / 20) - 		(			(			(1 / 1.2) / 20) * 0.7)) / 2";
		right = 0.005;
		bottom = 0;
	};
	shortcuts[] = {};
	textureNoShortcut = "#(argb,8,8,3)color(0,0,0,0)";
	color[] = {1,1,1,1};
	color2[] = {0.95,0.95,0.95,1};
	colorDisabled[] = {1,1,1,0.25};
	colorBackground[] = {"(profilenamespace getvariable 'GUI_BCG_RGB_R')*0.7","(profilenamespace getvariable 'GUI_BCG_RGB_G')*0.7","(profilenamespace getvariable 'GUI_BCG_RGB_B')*0.7",1};
	colorBackground2[] = {"(1 - 			(profilenamespace getvariable 'GUI_BCG_RGB_R'))","(1 - 			(profilenamespace getvariable 'GUI_BCG_RGB_G'))","(1 - 			(profilenamespace getvariable 'GUI_BCG_RGB_B'))",1};
	class Attributes
	{
		font = "FontNormal";
		color = "#E5E5E5";
		align = "left";
		shadow = "true";
	};
	idc = -1;
	style = 0;
	default = 0;
	shadow = 1;
	w = 0.183825;
	h = "(			(1 / 1.2) / 20)";
	animTextureDefault = "\HSim\UI_H\data\ui_button_shortcut_normal_ca.paa";
	animTextureNormal = "\HSim\UI_H\data\ui_button_shortcut_normal_ca.paa";
	animTextureDisabled = "\HSim\UI_H\data\ui_button_shortcut_normal_ca.paa";
	animTextureOver = "\HSim\UI_H\data\ui_button_shortcut_over_ca.paa";
	animTextureFocused = "\HSim\UI_H\data\ui_button_shortcut_focus_ca.paa";
	animTexturePressed = "\HSim\UI_H\data\ui_button_shortcut_down_ca.paa";
	periodFocus = 1.2;
	periodOver = 0.8;
	period = 0.4;
	font = "FontNormal";
	size = "(			(			(1 / 1.2) / 20) * 0.7)";
	sizeEx = "(			(			(1 / 1.2) / 20) * 0.7)";
	text = "";
	soundEnter[] = {"\HSim\UI_H\data\sound\onover",0.09,1};
	soundPush[] = {"\HSim\UI_H\data\sound\new1",0,0};
	soundClick[] = {"\HSim\UI_H\data\sound\onclick",0.07,1};
	soundEscape[] = {"\HSim\UI_H\data\sound\onescape",0.09,1};
	action = "";
	class AttributesImage
	{
		font = "FontNormal";
		color = "#E5E5E5";
		align = "left";
	};
};
class RscShortcutButtonMain
{
	idc = -1;
	style = 0;
	default = 0;
	w = 0.313726;
	h = 0.104575;
	color[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.25};
	colorBackground2[] = {"(profilenamespace getvariable 'GUI_BCG_RGB_R')*0.7","(profilenamespace getvariable 'GUI_BCG_RGB_G')*0.7","(profilenamespace getvariable 'GUI_BCG_RGB_B')*0.7",1};
	class HitZone
	{
		left = 0;
		top = 0;
		right = 0;
		bottom = 0;
	};
	class ShortcutPos
	{
		left = 0.0145;
		top = "(			(			(1 / 1.2) / 20) - 		(			(			(1 / 1.2) / 20) * 0.9)) / 2";
		w = "(			(			(1 / 1.2) / 20) * 0.9) * (3/4)";
		h = "(			(			(1 / 1.2) / 20) * 0.9)";
	};
	class TextPos
	{
		left = "(			(1) / 32) * 1.5";
		top = "(			(			(1 / 1.2) / 20)*2 - 		(			(			(1 / 1.2) / 20) * 0.9)) / 2";
		right = 0.005;
		bottom = 0;
	};
	animTextureNormal = "\HSim\UI_H\data\ui_button_main_normal_ca.paa";
	animTextureDisabled = "\HSim\UI_H\data\ui_button_main_disabled_ca.paa";
	animTextureOver = "\HSim\UI_H\data\ui_button_main_over_ca.paa";
	animTextureFocused = "\HSim\UI_H\data\ui_button_main_focus_ca.paa";
	animTexturePressed = "\HSim\UI_H\data\ui_button_main_down_ca.paa";
	animTextureDefault = "\HSim\UI_H\data\ui_button_main_normal_ca.paa";
	period = 0.5;
	font = "FontNormal";
	size = "(			(			(1 / 1.2) / 20) * 0.9)";
	sizeEx = "(			(			(1 / 1.2) / 20) * 0.9)";
	text = "";
	soundEnter[] = {"\HSim\UI_H\data\sound\onover",0.09,1};
	soundPush[] = {"\HSim\UI_H\data\sound\new1",0,0};
	soundClick[] = {"\HSim\UI_H\data\sound\onclick",0.07,1};
	soundEscape[] = {"\HSim\UI_H\data\sound\onescape",0.09,1};
	action = "";
	class Attributes
	{
		font = "FontNormal";
		color = "#E5E5E5";
		align = "left";
		shadow = "false";
	};
	class AttributesImage
	{
		font = "FontNormal";
		color = "#E5E5E5";
		align = "false";
	};
};
class RscFrame
{
	type = 0;
	idc = -1;
	style = 64;
	shadow = 1;
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	font = "FontNormal";
	sizeEx = 0.02;
	text = "";
};
class RscSlider
{
	access = 0;
	type = 3;
	style = 1024;
	w = 0.3;
	color[] = {1,1,1,0.8};
	colorActive[] = {1,1,1,1};
	shadow = 0;
	h = 0.025;
};
class IGUIBack
{
	type = 0;
	idc = 124;
	style = 128;
	text = "";
	colorText[] = {0,0,0,0};
	font = "FontNormal";
	sizeEx = 0;
	shadow = 0;
	x = 0.1;
	y = 0.1;
	w = 0.1;
	h = 0.1;
	colorbackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
};
class RscControlsGroup
{
	class VScrollbar
	{
		color[] = {1,1,1,1};
		width = 0.021;
		autoScrollSpeed = -1;
		autoScrollDelay = 5;
		autoScrollRewind = 0;
		shadow = 0;
	};
	class HScrollbar
	{
		color[] = {1,1,1,1};
		height = 0.028;
		shadow = 0;
	};
	class ScrollBar
	{
		color[] = {1,1,1,0.6};
		colorActive[] = {1,1,1,1};
		colorDisabled[] = {1,1,1,0.3};
		shadow = 0;
		thumb = "\HSim\UI_H\data\ui_scrollbar_thumb_ca.paa";
		arrowFull = "\HSim\UI_H\data\ui_arrow_top_active_ca.paa";
		arrowEmpty = "\HSim\UI_H\data\ui_arrow_top_ca.paa";
		border = "\HSim\UI_H\data\ui_border_scroll_ca.paa";
	};
	class Controls
	{
	};
	type = 15;
	idc = -1;
	x = 0;
	y = 0;
	w = 1;
	h = 1;
	shadow = 0;
	style = 16;
};

