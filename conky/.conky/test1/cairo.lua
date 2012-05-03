-- Conky Lua scripting example
--
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
            cairo_curve_to (cr, x0 ,y0, x0, y0, (x0 + x1)/2, y0)
            cairo_curve_to (cr, x1, y0, x1, y0, x1, y0 + r)
            cairo_line_to (cr, x1 , y1 - r)
            cairo_curve_to (cr, x1, y1, x1, y1, (x1 + x0)/2, y1)
            cairo_curve_to (cr, x0, y1, x0, y1, x0, y1- r)
        end
    else
        if h/2 < r then
            cairo_move_to  (cr, x0, (y0 + y1)/2)
            cairo_curve_to (cr, x0 , y0, x0 , y0, x0 + r, y0)
            cairo_line_to (cr, x1 - r, y0)
            cairo_curve_to (cr, x1, y0, x1, y0, x1, (y0 + y1)/2)
            cairo_curve_to (cr, x1, y1, x1, y1, x1 - r, y1)
            cairo_line_to (cr, x0 + r, y1)
            cairo_curve_to (cr, x0, y1, x0, y1, x0, (y0 + y1)/2)
        else
            cairo_move_to  (cr, x0, y0 + r)
            cairo_curve_to (cr, x0 , y0, x0 , y0, x0 + r, y0)
            cairo_line_to (cr, x1 - r, y0)
            cairo_curve_to (cr, x1, y0, x1, y0, x1, y0 + r)
            cairo_line_to (cr, x1 , y1 - r)
            cairo_curve_to (cr, x1, y1, x1, y1, x1 - r, y1)
            cairo_line_to (cr, x0 + r, y1)
            cairo_curve_to (cr, x0, y1, x0, y1, x0, y1- r)
        end
    end
    cairo_close_path (cr)
end

function conky_test_main()
--    if conky_window == nil then
--        return
--    end
--
--    local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
--    local display = cairo_create(cs)
--
--    cairo_surface_destroy(cs)
--    cairo_destroy(display)
end

--cs, cr = nil -- initialize our cairo surface and context to nil
--function conky_cairo_test()
--    if conky_window == nil then return end
--    if cs == nil or cairo_xlib_surface_get_width(cs) ~= conky_window.width or cairo_xlib_surface_get_height(cs) ~= conky_window.height then
--        if cs then cairo_surface_destroy(cs) end
--        cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
--    end
--    if cr then cairo_destroy(cr) end
--    cr = cairo_create(cs)
--
--    conky_round_rect(cr, 0.7825*w, 0.0675*h, 0.1*w, 0.1*h, 0.04*w)
--    local pat = cairo_pattern_create_linear (0.0, 0.065*h,
--    0.0, 0.165*h)
--    cairo_pattern_add_color_stop_rgba (pat, 0, 0, 0, 0, 1.0)
--    cairo_pattern_add_color_stop_rgba (pat, 1, 0.6, 0.6, 0.6, 0.5)
--    cairo_set_source (cr, pat)
--    cairo_fill_preserve (cr)
--    cairo_pattern_destroy (pat)
--    cairo_set_source_rgba (cr, 0.5, 0, 0, 0.5)
--    cairo_set_line_width (cr, 10.0)
--    cairo_stroke (cr)
--    cairo_destroy(cr)
--    cr = nil
--end
--
--function conky_cairo_cleanup()
--    cairo_surface_destroy(cs)
--    cs = nil
--end
