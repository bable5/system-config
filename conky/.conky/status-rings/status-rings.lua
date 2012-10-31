--[[
Clock Rings by londonali1010 (2009) Edited by jpope

This script draws percentage meters as rings, and also draws clock hands if you want! It is fully customisable; all options are described in the script. This script is based off a combination of my clock.lua script and my rings.lua script.

IMPORTANT: if you are using the 'cpu' function, it will cause a segmentation fault if it tries to draw a ring straight away. The if statement on line 145 uses a delay to make sure that this doesn't happen. It calculates the length of the delay by the number of updates since Conky started. Generally, a value of 5s is long enough, so if you update Conky every 1s, use update_num>5 in that if statement (the default). If you only update Conky every 2s, you should change it to update_num>3; conversely if you update Conky every 0.5s, you should use update_num>10. ALSO, if you change your Conky, is it best to use "killall conky; conky" to update it, otherwise the update_num will not be reset and you will get an error.

To call this script in Conky, use the following (assuming that you save this script to ~/scripts/rings.lua):
	lua_load ~/scripts/clock_rings.lua
	lua_draw_hook_pre clock_rings
	
Changelog:
+ v1.0 -- Original release (30.09.2009)
   v1.1p -- jpope edit (05.10.2009)
   v1.2p -- jpope edit (06.10.2009)
   v1.3p -- jpope edit (10.10.2009)
]]

-- Use these settings to define the origin and extent of your clock.

clock_r=100

-- "clock_x" and "clock_y" are the coordinates of the centre of the clock, in pixels, from the top left of the Conky window.

clock_x=200
clock_y=150


bgc=0xa1100c
fgc=0xb87333
bga=0.7
fga=1.0
radius=30
ring_t=5

cpu_x=75
cpu_y=135

used_radius = 25
used_x=cpu_x+radius+2*used_radius + 20
used_y=cpu_y

show_seconds=true

require 'cairo'

settings_table = {
    {
		name='cpu',
		arg='cpu0',
		max=100,
		bg_colour=bgc,
		bg_alpha=bga,
		fg_colour=fgc,
		fg_alpha=fga,
		x=cpu_x, y=cpu_y,
		radius=radius,
		thickness=ring_t,
		start_angle=0,
		end_angle=90
	},
	{
		name='cpu',
		arg='cpu1',
		max=100,
		bg_colour=bgc,
		bg_alpha=bga,
		fg_colour=fgc,
		fg_alpha=fga,
		x=cpu_x, y=cpu_y,
		radius=radius+ring_t+1,
		thickness=ring_t,
		start_angle=45,
		end_angle=135
	},
	{
		name='cpu',
		arg='cpu2',
		max=100,
		bg_colour=bgc,
		bg_alpha=bga,
		fg_colour=fgc,
		fg_alpha=fga,
		x=cpu_x, y=cpu_y,
		radius=radius + 2*(ring_t + 1),
		thickness=ring_t,
		start_angle=90,
		end_angle=180
	},
    {
        name='cpu',
		arg='cpu3',
		max=100,
		bg_colour=bgc,
		bg_alpha=bga,
		fg_colour=fgc,
		fg_alpha=fga,
		x=cpu_x, y=cpu_y,
		radius=radius + 3*(ring_t + 1),
		thickness=ring_t,
		start_angle=135,
		end_angle=225
	},

	{
		name='memperc',
		arg='',
		max=100,
		bg_colour=bgc,
		bg_alpha=bga,
		fg_colour=fgc,
		fg_alpha=fga,
		x=used_x, y=used_y,
		radius=used_radius,
		thickness=5,
		start_angle=0,
		end_angle=180,
        caption='mem',
        caption_weight=1,              caption_size=8.0,
        caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.8,
	    caption_xoff = 15, caption_yoff = -(used_radius),
    },
	{
		name='swapperc',
		arg='',
		max=100,
		bg_colour=bgc,
		bg_alpha=bga,
		fg_colour=fgc,
		fg_alpha=fga,
		x=used_x, y=used_y+used_radius,
		radius=used_radius,
		thickness=4,
		start_angle=-180,
		end_angle=0,
        caption='swap',
        caption_weight=1,              caption_size=8.0,
        caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.8,
	    caption_xoff = -40, caption_yoff = -(used_radius),
	},
	{
		name='fs_used_perc',
		arg='/',
		max=100,
		bg_colour=bgc,
		bg_alpha=bga,
		fg_colour=fgc,
		fg_alpha=fga,
		x=used_x, y=used_y + 2*used_radius,
		radius=used_radius,
		thickness=4,
		start_angle=0,
		end_angle=180,
        caption='/',
        caption_weight=1,              caption_size=8.0,
        caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.8,
	    caption_xoff = 15, caption_yoff = -(used_radius),
	},
	{
		name='fs_used_perc',
		arg='/home',
		max=100,
		bg_colour=bgc,
		bg_alpha=bga,
		fg_colour=fgc,
		fg_alpha=fga,
		x=used_x, y=used_y+3*used_radius,
		radius=used_radius,
		thickness=4,
		start_angle=-180,
		end_angle=0,
        caption='/home',
        caption_weight=1,              caption_size=8.0,
        caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.8,
	    caption_xoff = -50, caption_yoff = -(used_radius),
	},
--    {
--		name='upspeedf',
--		arg='eth0',
--		max=100,
--		bg_colour=0x3399cc,
--		bg_alpha=0.2,
--		fg_colour=0x3399cc,
--		fg_alpha=0.3,
--		x=540, y=40,
--		radius=15,
--		thickness=4,
--		start_angle=-90,
--		end_angle=180
--	},
--		{
--		name='downspeedf',
--		arg='eth0',
--		max=100,
--		bg_colour=0x3399cc,
--		bg_alpha=0.2,
--		fg_colour=0x3399cc,
--		fg_alpha=0.3,
--		x=540, y=40,
--		radius=20,
--		thickness=4,
--		start_angle=-90,
--		end_angle=180
--	},
}

function rgb_to_r_g_b(colour,alpha)
	return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function draw_ring(cr,t,pt)
	local w,h=conky_window.width,conky_window.height
	
	local xc,yc,ring_r,ring_w,sa,ea=pt['x'],pt['y'],pt['radius'],pt['thickness'],pt['start_angle'],pt['end_angle']
	local bgc, bga, fgc, fga=pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'], pt['fg_alpha']

	local angle_0=sa*(2*math.pi/360)-math.pi/2
	local angle_f=ea*(2*math.pi/360)-math.pi/2
	local t_arc=t*(angle_f-angle_0)

	-- Draw background ring

	cairo_arc(cr,xc,yc,ring_r,angle_0,angle_f)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
	cairo_set_line_width(cr,ring_w)
	cairo_stroke(cr)
	
	-- Draw indicator ring

	cairo_arc(cr,xc,yc,ring_r,angle_0,angle_0+t_arc)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
	cairo_stroke(cr)		

    local caption = pt['caption']
   
    if caption==nil then return
    else
        local xadj = pt['caption_xoff']
        if xadj == nil then xadj = -15 end
        local yadj = pt['caption_yoff']
        if yadj == nil then yadj = -15 end
        
        local cap_size=pt['caption_size']
        local cap_fgc=pt['caption_fg_colour']
        local cap_fga=pt['caption_fg_alpha']
        local cap_weight=pt['caption_weight']
        draw_caption(cr, xc + xadj, yc + yadj, caption, cap_fgc, cap_fga, cap_size, cap_weight) 
    end
end

function draw_caption(cr, xc, yc, txt, txt_fg_colour, txt_fg_alpha, txt_size, txt_weight)
    cairo_select_font_face (cr, "ubuntu", CAIRO_FONT_SLANT_NORMAL, txt_weight);
    cairo_set_font_size (cr, txt_size)
    cairo_set_source_rgba (cr, rgb_to_r_g_b(txt_fg_colour, txt_fg_alpha))
    cairo_move_to(cr, xc, yc)
    cairo_show_text(cr, txt)
    cairo_stroke(cr)
end

function draw_clock_hands(cr,xc,yc)
	local secs,mins,hours,secs_arc,mins_arc,hours_arc
	local xh,yh,xm,ym,xs,ys
	
	secs=os.date("%S")	
	mins=os.date("%M")
	hours=os.date("%I")
		
	secs_arc=(2*math.pi/60)*secs
	mins_arc=(2*math.pi/60)*mins+secs_arc/60
	hours_arc=(2*math.pi/12)*hours+mins_arc/12
		
	-- Glassy border
	
	cairo_arc(cr,xc,yc,clock_r*1.25,0,2*math.pi)
	cairo_set_source_rgba(cr,0.5,0.5,0.5,0.2)
	cairo_set_line_width(cr,1)
	cairo_stroke(cr)
	
	local border_pat=cairo_pattern_create_linear(xc,yc-clock_r*1.25,xc,yc+clock_r*1.25)
	
	cairo_pattern_add_color_stop_rgba(border_pat,0,1,1,1,0.7)
	cairo_pattern_add_color_stop_rgba(border_pat,0.3,1,1,1,0)
	cairo_pattern_add_color_stop_rgba(border_pat,0.5,1,1,1,0)
	cairo_pattern_add_color_stop_rgba(border_pat,0.7,1,1,1,0)
	cairo_pattern_add_color_stop_rgba(border_pat,1,1,1,1,0.7)
	cairo_set_source(cr,border_pat)
	cairo_arc(cr,xc,yc,clock_r*1.125,0,2*math.pi)
	cairo_close_path(cr)
	cairo_set_line_width(cr,clock_r*0.25)
	cairo_stroke(cr)

    
	-- Set clock face
	
	cairo_arc(cr,xc,yc,clock_r,0,2*math.pi)
	cairo_close_path(cr)
	
	local face_pat=cairo_pattern_create_radial(xc,yc-clock_r*0.75,0,xc,yc,clock_r)
	
	cairo_pattern_add_color_stop_rgba(face_pat,0,1,0.5,0.5,0.9)
	cairo_pattern_add_color_stop_rgba(face_pat,0.5,1,0.5,0.7,0.9)
	cairo_pattern_add_color_stop_rgba(face_pat,1,1,0.8,0.3,0.9)
	cairo_set_source(cr,face_pat)
	cairo_fill_preserve(cr)
	cairo_set_source_rgba(cr,0.5,0.5,0.5,0.2)
	cairo_set_line_width(cr, 1)
	cairo_stroke (cr)

	-- Draw hour hand
	
	xh=xc+0.7*clock_r*math.sin(hours_arc)
	yh=yc-0.7*clock_r*math.cos(hours_arc)
	cairo_move_to(cr,xc,yc)
	cairo_line_to(cr,xh,yh)
	
	cairo_set_line_cap(cr,CAIRO_LINE_CAP_ROUND)
	cairo_set_line_width(cr,5)
	cairo_set_source_rgba(cr,0.2,0.6,1,0.4)
	cairo_stroke(cr)
	
	-- Draw minute hand
	
	xm=xc+clock_r*math.sin(mins_arc)
	ym=yc-clock_r*math.cos(mins_arc)
	cairo_move_to(cr,xc,yc)
	cairo_line_to(cr,xm,ym)
	
	cairo_set_line_width(cr,3)
	cairo_stroke(cr)
	
	-- Draw seconds hand
	
	if show_seconds then
		xs=xc+clock_r*math.sin(secs_arc)
		ys=yc-clock_r*math.cos(secs_arc)
		cairo_move_to(cr,xc,yc)
		cairo_line_to(cr,xs,ys)
	
		cairo_set_line_width(cr,1)
		cairo_stroke(cr)
	end
end

function conky_clock_hands()
    if conky_window==nil then return end
	local cs=cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, conky_window.width,conky_window.height)
	
	local cr=cairo_create(cs)	
    draw_clock_hands(cr, 200, 150)
end

function conky_clock_rings()
	local function setup_rings(cr,pt)
		local str=''
		local value=0
	
		str=string.format('${%s %s}',pt['name'],pt['arg'])
		str=conky_parse(str)
		
		value=tonumber(str)
		pct=value/pt['max']
		
		draw_ring(cr,pct,pt)
	end
	
	-- Check that Conky has been running for at least 5s

	if conky_window==nil then return end
	local cs=cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, conky_window.width,conky_window.height)
	
	local cr=cairo_create(cs)	

    draw_bg(cr)
	
	local updates=conky_parse('${updates}')
	update_num=tonumber(updates)
	
	--draw_clock_hands(cr,clock_x,clock_y)

	if update_num>5 then
		for i in pairs(settings_table) do
			setup_rings(cr,settings_table[i])
		end
	end

    cairo_destroy(cr)
    cairo_surface_destroy(cs)
end

--[[
Background by londonali1010 (2009)

This script draws a background to the Conky window. It covers the whole of the Conky window, but you can specify rounded corners, if you wish.

To call this script in Conky, use (assuming you have saved this script to ~/scripts/):
	lua_load ~/scripts/draw_bg.lua
	lua_draw_hook_pre draw_bg

Changelog:
+ v1.0 -- Original release (07.10.2009)
]]

-- Change these settings to affect your background.
-- "corner_r" is the radius, in pixels, of the rounded corners. If you don't want rounded corners, use 0.

corner_r=15

-- Set the colour and transparency (alpha) of your background.

bg_colour=0xffffff
bg_alpha=0.1

function draw_bg(cr)
	if conky_window==nil then return end
	local w=conky_window.width
	local h=conky_window.height
	
	cairo_move_to(cr,corner_r,0)
	cairo_line_to(cr,w-corner_r,0)
	cairo_curve_to(cr,w,0,w,0,w,corner_r)
	cairo_line_to(cr,w,h-corner_r)
	cairo_curve_to(cr,w,h,w,h,w-corner_r,h)
	cairo_line_to(cr,corner_r,h)
	cairo_curve_to(cr,0,h,0,h,0,h-corner_r)
	cairo_line_to(cr,0,corner_r)
	cairo_curve_to(cr,0,0,0,0,corner_r,0)
	cairo_close_path(cr)
	
	cairo_set_source_rgba(cr,rgb_to_r_g_b(bg_colour,bg_alpha))
	cairo_fill(cr)
end
