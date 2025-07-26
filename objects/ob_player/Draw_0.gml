var animate_offset = global.service_mob.get_animate_movement(timer)
global.service_mob.draw_shadow(self)
if hspeed != 0 xscale = sign(hspeed)
draw_sprite_ext(sprite_index, image_index, x, y - animate_offset.offset_jump, image_xscale * xscale, image_yscale, animate_offset.offset_angle, image_blend, image_alpha);
