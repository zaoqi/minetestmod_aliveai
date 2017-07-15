aliveai_aliens={atra={}}

dofile(minetest.get_modpath("aliveai_aliens") .. "/items.lua")

aliveai.savedata.aliens=function(self)
	if self.aliens then
		return {acolor=self.acolor}
	end
end

aliveai.loaddata.aliens=function(self,r)
	if r.acolor then
		self.acolor=r.acolor
	end
	return self
end

aliveai_aliens.set_color=function(self)
	if not self.acolor then return end
	local tx=self.object:get_properties().textures[1]
	self.object:set_properties({
		textures = {tx .. "^[colorize:#" .. self.acolor},
	})
end

aliveai_aliens.gen_color=function(self)
	local c=""
	local n=0
	local t="0123456789ABCDEF"
  	for i=1,6,1 do
        		n=math.random(1,16)
       		c=c .. string.sub(t,n,n)
	end
	self.acolor=c .. "55"
	aliveai_aliens.set_color(self)

	local p=self.object:getpos()
	p={x=p.x,y=p.y+math.random(15,30),p.z}
	local fn = minetest.registered_nodes[minetest.get_node(p).name]
	if fn and fn.buildable_to and minetest.is_protected(p,"")==false then
		minetest.set_node(p,{name="aliveai_aliens:asteroid"})
	end

end

aliveai_aliens.re_color=function(self,pos)
	local name=self.object:get_luaentity().name .."_dead"
	for i, ob in pairs(minetest.get_objects_inside_radius(pos, 1)) do
		if ob:get_luaentity() and ob:get_luaentity().name==name then
			ob:get_luaentity().acolor=self.acolor
			aliveai_aliens.set_color(ob:get_luaentity())
			return
		end
	end
end

aliveai.create_bot({
		name="alien1",
		texture="aliveai_alien1.png",
		hp=50,
		light=0,
		stealing=1,
		talking=0,
		annoyed_by_staring=0,
		type="monster",
		dmg=4,
		building=0,
		attacking=1,
		name_color="",
		team="alien",
		attack_players=1,
		start_with_items={["aliveai_aliens:vexcazer"]=1,["aliveai_aliens:alien_food"]=10},
		spawn_on={"group:sand","default:dirt_with_grass","default:dirt_with_dry_grass","default:gravel","default:stone"},
	on_spawn=function(self)
		aliveai_aliens.gen_color(self)
	end,
	on_load=function(self)
		aliveai_aliens.set_color(self)
	end,
	on_death=function(self,puncher,pos)
		aliveai_aliens.re_color(self,pos)
	end,
})
aliveai.create_bot({
		name="alien2",
		texture="aliveai_alien2.png",
		hp=50,
		light=0,
		stealing=1,
		talking=0,
		annoyed_by_staring=0,
		type="monster",
		dmg=4,
		building=0,
		attacking=1,
		name_color="",
		team="alien",
		attack_players=1,
		start_with_items={["aliveai_aliens:alien_rifle"]=1,["aliveai_aliens:alien_food"]=10},
		spawn_on={"group:sand","default:dirt_with_grass","default:dirt_with_dry_grass","default:gravel","default:stone"},
	on_spawn=function(self)
		aliveai_aliens.gen_color(self)
	end,
	on_load=function(self)
		aliveai_aliens.set_color(self)
	end,
	on_death=function(self,puncher,pos)
		aliveai_aliens.re_color(self,pos)
	end,
})
aliveai.create_bot({
		name="alien3",
		texture="aliveai_alien3.png",
		hp=50,
		light=0,
		stealing=1,
		talking=0,
		annoyed_by_staring=0,
		type="monster",
		dmg=4,
		building=0,
		attacking=1,
		name_color="",
		team="alien",
		attack_players=1,
		start_with_items={["aliveai_aliens:alien_homing_rifle"]=1,["aliveai_aliens:alien_food"]=10},
		spawn_on={"group:sand","default:dirt_with_grass","default:dirt_with_dry_grass","default:gravel","default:stone"},
	on_spawn=function(self)
		aliveai_aliens.gen_color(self)
	end,
	on_load=function(self)
		aliveai_aliens.set_color(self)
	end,
	on_death=function(self,puncher,pos)
		aliveai_aliens.re_color(self,pos)
	end,
})
aliveai.create_bot({
		name="alien4",
		texture="aliveai_alien4.png",
		hp=25,
		work_helper=1,
		light=0,
		stealing=1,
		talking=0,
		smartfight=0,
		annoyed_by_staring=0,
		type="monster",
		dmg=4,
		building=0,
		attacking=1,
		name_color="",
		team="alien",
		attack_players=1,
		visual_size={x=0.8,y=0.8},
		collisionbox={-0.3,-0.8,-0.3,0.3,0.65,0.3},
		start_with_items={["aliveai_aliens:ozer_sword"]=1,["aliveai_aliens:alien_food"]=10},
		spawn_on={"group:sand","default:dirt_with_grass","default:dirt_with_dry_grass","default:gravel","default:stone"},
	on_spawn=function(self)
		aliveai_aliens.gen_color(self)
	end,
	on_load=function(self)
		aliveai_aliens.set_color(self)
	end,
	on_death=function(self,puncher,pos)
		aliveai_aliens.re_color(self,pos)
	end,
})

aliveai.create_bot({
		name="alien5",
		texture="aliveai_alien5.png",
		hp=50,
		light=0,
		stealing=1,
		talking=0,
		annoyed_by_staring=0,
		type="monster",
		dmg=4,
		building=0,
		attacking=1,
		name_color="",
		team="alien",
		attack_players=1,
		start_with_items={["aliveai_aliens:alien_rifle"]=1,["aliveai_aliens:alien_food"]=10},
		spawn_on={"group:sand","default:dirt_with_grass","default:dirt_with_dry_grass","default:gravel","default:stone"},
		annoyed_by_staring=0,
	on_spawn=function(self)
		aliveai_aliens.gen_color(self)
	end,
	on_load=function(self)
		aliveai_aliens.set_color(self)
	end,
	on_death=function(self,puncher,pos)
		aliveai_aliens.re_color(self,pos)
	end,
})
aliveai.create_bot({
		name="alien6",
		texture="aliveai_alien6.png",
		hp=50,
		light=0,
		stealing=1,
		talking=0,
		annoyed_by_staring=0,
		type="monster",
		dmg=4,
		building=0,
		attacking=1,
		name_color="",
		team="alien",
		attack_players=1,
		start_with_items={["aliveai_aliens:alien_homing_rifle"]=1,["aliveai_aliens:alien_food"]=10},
		spawn_on={"group:sand","default:dirt_with_grass","default:dirt_with_dry_grass","default:gravel","default:stone"},
	on_spawn=function(self)
		aliveai_aliens.gen_color(self)
	end,
	on_load=function(self)
		aliveai_aliens.set_color(self)
	end,
	on_death=function(self,puncher,pos)
		aliveai_aliens.re_color(self,pos)
	end,
})
aliveai.create_bot({
		name="alien7",
		texture="aliveai_alien7.png",
		floating=1,
		hp=50,
		light=0,
		stealing=1,
		talking=0,
		annoyed_by_staring=0,
		type="monster",
		dmg=4,
		building=0,
		attacking=1,
		name_color="",
		team="alien",
		attack_players=1,
		start_with_items={["aliveai_aliens:alien_nrifle"]=1,["aliveai_aliens:alien_food"]=10},
		spawn_on={"group:sand","default:dirt_with_grass","default:dirt_with_dry_grass","default:gravel","default:stone"},
	on_spawn=function(self)
		aliveai_aliens.gen_color(self)
	end,
	on_load=function(self)
		aliveai_aliens.set_color(self)
	end,
	on_death=function(self,puncher,pos)
		aliveai_aliens.re_color(self,pos)
	end,
})

