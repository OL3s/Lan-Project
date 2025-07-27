global.service_attack = {
	
	create_struct_damage: function(damage, spec_damage) {
		return {damage: damage, spec_damage: spec_damage}
	},
	
	create_struct_armor: function(block, spec_block) {
		return {block: block, spec_block: spec_block}
	},
	
	create_struct_combat: function(health, armor_struct) {
		return {
			health: [health, health],
			armor: armor_struct
		};
	},
	
	apply_damage: function(combat_struct, damage_struct, armor_struct) {
		combat_struct.health[0] -= self.calc_damage(
									damage_struct.damage, 
									damage_struct.spec_damage, 
									armor_struct.block, 
									armor_struct.spec_block);
		return combat_struct.health[0] <= 0;
	},

	calc_damage: function(damage, spec_damage, armor, spec_armor) {
		var k = 2; // scaling factor

		var final_normal = damage / (1 + (armor / k));
		var final_special = spec_damage / (1 + (spec_armor / k));

		return ceil(final_normal + final_special);
	}
};
