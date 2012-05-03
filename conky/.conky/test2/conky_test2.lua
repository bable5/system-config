--==============================================================================
--                              conky_HUD.lua
--
--  author  : SLK
--  version : v2011062101
--  license : Distributed under the terms of GNU GPL version 2 or later
--
--==============================================================================

require 'cairo'


function conky_round_rect(cr, x0, y0, w, h, r)
    if (w == 0) or (h == 0) then return end

    local x1 = x0 + w
    local y1 = y0 + h

    if w/2 < r then
        if h/2 < r then
            cairo_move_to  (cr, x0, (y0 + y1)/2)
            cairo_curve_to (cr, x0 ,y0, x0, y0, (x0 + x1)/2, y0)
            cairo_curve_to (cr, x1, y0, x1, y0, x1, (y0 + y1)/2)
            cairo_curve_to (cr, x1, y1, x1, y1, (x1 + x0)/2, y1)
            cairo_curve_to (cr, x0, y1, x0, y1, x0, (y0 + y1)/2)
        else
            cairo_move_to  (cr, x0, y0 + r)
--            cairo_curve_to (cr, x0 ,y0, x0, y0, (x0 + x1)/2, y0)
--            cairo_curve_to (cr, x1, y0, x1, y0, x1, y0 + r)
--            cairo_line_to (cr, x1 , y1 - r)
--            cairo_curve_to (cr, x1, y1, x1, y1, (x1 + x0)/2, y1)
--            cairo_curve_to (cr, x0, y1, x0, y1, x0, y1- r)
        end
    else
        if h/2 < r then
--            cairo_move_to  (cr, x0, (y0 + y1)/2)
--            cairo_curve_to (cr, x0 , y0, x0 , y0, x0 + r, y0)
--            cairo_line_to (cr, x1 - r, y0)
--            cairo_curve_to (cr, x1, y0, x1, y0, x1, (y0 + y1)/2)
--            cairo_curve_to (cr, x1, y1, x1, y1, x1 - r, y1)
--            cairo_line_to (cr, x0 + r, y1)
--            cairo_curve_to (cr, x0, y1, x0, y1, x0, (y0 + y1)/2)
        else
--            cairo_move_to  (cr, x0, y0 + r)
--            cairo_curve_to (cr, x0 , y0, x0 , y0, x0 + r, y0)
--            cairo_line_to (cr, x1 - r, y0)
--            cairo_curve_to (cr, x1, y0, x1, y0, x1, y0 + r)
--            cairo_line_to (cr, x1 , y1 - r)
--            cairo_curve_to (cr, x1, y1, x1, y1, x1 - r, y1)
--            cairo_line_to (cr, x0 + r, y1)
--            cairo_curve_to (cr, x0, y1, x0, y1, x0, y1- r)
        end
    end

--    cairo_close_path(cr)
end

function draw_simple(display)
    cairo_set_source_rgba(display, 0.5, 0, 0, 0.5)
    cairo_set_line_width(display, 5)
    cairo_move_to(display, 50, 50)
    cairo_line_to(display, 100, 100)
    cairo_stroke(display)
end

-------------------------------------------------------------------------------
--                                                                         MAIN
function conky_main()
    if conky_window == nil then 
        return
    end

    local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
    local display = cairo_create(cs)
    
    local updates = conky_parse('${updates}')
    update_num = tonumber(updates)
   
    local w = conky_window.width
    local h = conky_window.height

    draw_simple(display)

    conky_round_rect(cr, 0.7825*w, 0.0675*h, 0.1*w, 0.04*h, 0.04*w)   
 
    local pat = cairo_pattern_create_linear (0.0, 0.065*h,
    0.0, 0.165*h)
    cairo_pattern_add_color_stop_rgba (pat, 0, 0, 0, 0, 1.0)
    cairo_pattern_add_color_stop_rgba (pat, 1, 0.6, 0.6, 0.6, 0.5)
    cairo_set_source (display, pat)
    cairo_fill_preserve (display)
    cairo_pattern_destroy (pat)
    cairo_set_source_rgba (display, 0.5, 0, 0, 0.5)
    cairo_set_line_width (display, 10.0)
    cairo_stroke (display)

    cairo_surface_destroy(cs)
    cairo_destroy(display)
end

