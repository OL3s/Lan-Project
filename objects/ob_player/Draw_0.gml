var serv_mob = global.service_mob;
var animate_offset = serv_mob.get_animate_movement(animate.timer);
global.service_mob.draw_shadow(self);

draw_sprite_ext(sprite_index, image_index, x, y - animate_offset.offset_jump - global.service_projectile.get_linear_height(animate.timer, 60, 6), image_xscale * animate.xscale, image_yscale * animate.yscale, animate_offset.offset_angle + animate.angle, image_blend, image_alpha);
global.service_mob.draw_healthbarr(x, y - 12, 8, combat.health, combat.stamina, combat.mana)
