aliveai_storm={time=tonumber(minetest.setting_get("item_entity_ttl"))}

aliveai.create_bot({
		drop_dead_body=0,
		attack_players=1,
		name="storm",
		team="storm",
		texture="aliveai_storm.png",
		stealing=1,
		steal_chanse=2,
		attacking=1,
		talking=0,
		light=0,
		building=0,
		escape=0,
		type="monster",
		dmg=1,
		hp=40,
		name_color="",
		spawn_on={"group:sand","default:dirt_with_grass","default:stone"},
	on_step=function(self,dtime)
		if self.fight then
			if not self.power then
				self.timer3 = 0
				self.power=5
			end
			local pos=self.object:getpos()
			for i, ob in pairs(minetest.get_objects_inside_radius(pos, self.power)) do
				if not ob:get_attach() and aliveai.team(ob)~="storm" and aliveai.visiable(self,ob) and minetest.is_protected(pos,"")==false then
				local v=ob:getpos()
				aliveai_storm.tmp={ob1=self.object,ob2=ob}
				local m=minetest.add_entity(ob:getpos(), "aliveai_storm:power")
				if ob:get_luaentity() and ob:get_luaentity().age then ob:get_luaentity().age=0 end
				ob:set_attach(m, "", {x=0,y=0,z=0}, {x=0,y=0,z=0})
				end
			end
			self.arm=self.arm+self.power
			self.object:set_properties({
				visual_size={x=self.power/5,y=self.power/5},
				automatic_rotate=self.power*4
			})
			self.power=self.power+0.1
			if self.power>16 then self.fight=nil end
		elseif self.power then
			self.power=nil
			self.arm=2
			self.object:set_properties({
				visual_size={x=1,y=1},
				automatic_rotate=false
			})
		end
	end,
	on_punching=function(self,target)
		self.punc=1
		minetest.after(0.5, function(self)
			self.punc=nil
		end,self)
	end,
})

minetest.register_entity("aliveai_storm:power",{
	hp_max = 100,
	physical = false,
	visual = "sprite",
	visual_size = {x=1, y=1},
	textures = {"aliveai_air.png"},
	is_visible =true,
	timer = 0,
	timer2=0,
	team="storm",
	on_activate=function(self, staticdata)
		if not aliveai_storm.tmp then
			aliveai.punch(self,self.object,1000)
			return self
		end
		self.ob=aliveai_storm.tmp.ob1
		self.target=aliveai_storm.tmp.ob2

		aliveai_storm.tmp=nil

		self.d=aliveai.distance(self,self.ob:getpos())
		self.s=0.1
		self.a=0

		local pos=self.ob:getpos()
		local spos=self.object:getpos()
		local a=self.a * math.pi * self.s
  		local x, z =  pos.x+self.d*math.cos(a), pos.z+self.d*math.sin(a)
		local y=(pos.y - self.object:getpos().y)*(self.s*0.5)
		self.a=aliveai.distance(self,{x=x,y=spos.y+y,z=z})*(math.pi*1)
	end,
	on_step = function(self, dtime)
		self.timer=self.timer+dtime
		if self.timer<0.15 then return true end
		self.timer=0
		if not self.ob:get_luaentity() or self.kill then
			self.target:set_detach()
			self.target:setacceleration({x=0,y=-10,z=0})
			if self.target:get_luaentity() and
			self.target:get_luaentity().age then
				self.target:get_luaentity().age=aliveai_storm.time
			end
			aliveai.punch(self,self.object,1000)
			return self
		end
		if self.ob:get_luaentity().punc then
			self.d=1
		end
		if not self.pus and self.d<2 then
			local v=self.object:getvelocity()
			self.object:setvelocity({x=v.x,y=100,z=v.z})
			self.object:setacceleration({x=0,y=-10,z=0})
			self.pus=1
			self.object:set_properties({physical = true})
			return self
		elseif self.pus then
			if aliveai.distance(self,self.ob)>100 or self.object:getvelocity().y==0 then
				self.kill=1
				aliveai.punch(self,self.target,10)
				return self
			end
		end
		local pos=self.ob:getpos()
		local spos=self.object:getpos()
		local s=0
		local a=self.a * math.pi * self.s
  		local x, z =  pos.x+self.d*math.cos(a), pos.z+self.d*math.sin(a)
  		self.a=self.a+1
		self.d=self.d-0.1

		local y=(pos.y - self.object:getpos().y)*self.s
		if minetest.registered_nodes[minetest.get_node({x=x,y=spos.y+y,z=z}).name].walkable then
			if minetest.registered_nodes[minetest.get_node({x=x,y=spos.y+y+1,z=z}).name].walkable==false then
				y=y+1
			else
				self.d=self.d-0.5
				a=self.a * self.s
  				x=pos.x+self.d*math.cos(a)
				z =pos.z+self.d*math.sin(a)
				self.object:moveto({x=x,y=spos.y+y,z=z})
				return self
			end
		end
		self.object:moveto({x=x,y=spos.y+y,z=z})
		return self
	end,
})