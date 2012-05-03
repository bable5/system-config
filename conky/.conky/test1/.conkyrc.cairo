ckground yes 
update_interval 1

cpu_avg_samples 2
net_avg_samples 2
temperature_unit celsius

double_buffer yes 
no_buffers yes 
text_buffer_size 2048

gap_x 500 
gap_y 10
minimum_size 250 130 
maximum_width 250 
own_window yes 
own_window_type override
own_window_transparent yes 
own_window_hints undecorate,sticky,skip_taskbar,skip_pager
border_inner_margin 0
border_outer_margin 0
alignment br

draw_shades no
draw_outline no
draw_borders no
draw_graph_borders no

override_utf8_locale yes 
use_xft yes 
xftfont caviar dreams:size=8
xftalpha 0.5 
uppercase no

default_color FFFFFF
#color1 00FFBB
color1 b87333

lua_load /home/sean/.conky/test/cairo.lua
#lua_draw_hook_post cairo_test
lua_draw_hook_pre test_main
TEXT
#${color orange}SYSTEM ${hr 2}$color
#$nodename $sysname $kernel on $machine


#${alignc}${color red}${time %a %d %b}
#${alignc}${time %H:%M}
