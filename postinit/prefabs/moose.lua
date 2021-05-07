local env = env
GLOBAL.setfenv(1, GLOBAL)
-----------------------------------------------------------------
local PHASE2_HEALTH = .6

local function SuperHop(inst, data)
    if data.name == "SuperHop" then
        inst.superhop = true
    end
end

local function EnterPhase2TriggerMoose(inst)
	inst.sg:GoToState("taunt")
	
	for i = 1, 2 do
		if not inst.components.health:IsDead() then
            local target = inst.components.combat.target ~= nil and inst.components.combat.target or nil
			local upgradeburst = SpawnPrefab("mossling")
			upgradeburst.Transform:SetPosition(inst.Transform:GetWorldPosition())
			upgradeburst.components.herdmember.herdprefab = "lightning"
			upgradeburst.persists = false
			upgradeburst.mother_dead = true
			upgradeburst:AddComponent("follower")
			upgradeburst.components.follower:SetLeader(inst)
			upgradeburst.sg:GoToState("hatch")
			upgradeburst.components.combat:SuggestTarget(target)
			--[[if target ~= nil then
				upgradeburst.components.locomotor:GoToEntity(target)
				upgradeburst:DoTaskInTime(0, function(inst)
					upgradeburst.sg:GoToState("spin_pre")
				end)
			end]]
		end
	end
end

env.AddPrefabPostInit("moose", function(inst)

	if not TheWorld.ismastersim then
		return
	end
	
	if inst.components.combat ~= nil then
		local function isnotmossling(ent)
			if ent ~= nil and not ent:HasTag("mossling") and not ent:HasTag("moose")then -- fix to friendly AOE: refer for later AOE mobs -Axe
				return true
			end
		end
        inst.components.combat:SetAreaDamage(TUNING.DEERCLOPS_AOE_RANGE/2, TUNING.DEERCLOPS_AOE_SCALE, isnotmossling) -- you can edit these values to your liking -Axe
	end       

	if inst.components.combat ~= nil then
		inst.components.combat:SetRange(TUNING.MOOSE_ATTACK_RANGE * 1.1)
	end
	
    inst:AddComponent("groundpounder")
    inst.components.groundpounder.destroyer = false
    inst.components.groundpounder.damageRings = 3
    inst.components.groundpounder.destructionRings = 2
    inst.components.groundpounder.platformPushingRings = 2
    inst.components.groundpounder.numRings = 3
    inst.components.groundpounder.noTags = { "FX", "NOCLICK", "DECOR", "INLIMBO", "mossling", "moose" }
	
	inst:AddComponent("healthtrigger")
	inst.components.healthtrigger:AddTrigger(PHASE2_HEALTH, EnterPhase2TriggerMoose)
	
	inst.superhop = true
	
    inst:ListenForEvent("timerdone", SuperHop)
	
	inst:ListenForEvent("newstate", function(inst, data)
		if inst.stormtask == nil and not inst.components.health:IsDead() and inst.components.health:GetPercent() <= 0.3 and data.statename == "disarm" then
			inst.stormtask = inst:DoPeriodicTask(1, function(inst)
				if not inst.components.health:IsDead() then
					if not TheWorld.state.israining then
						TheWorld:PushEvent("ms_forceprecipitation", true)
					end
				
					if inst.stormtaskcounter ~= nil then
						inst.stormtaskcounter = inst.stormtaskcounter + 1
					else
						inst.stormtaskcounter = 1
					end
						
					if inst.stormtaskcounter > 20 then
						inst.stormtask:Cancel()
						inst.stormtask = nil
						inst.stormtaskcounter = 0
					else
						local target = inst.components.combat.target ~= nil and inst.components.combat.target or nil
						if target ~= nil and math.random() > 0.95 then
							local LightningStorm = SpawnPrefab("hound_lightning")
							LightningStorm.NoTags = { "INLIMBO", "shadow", "moose", "mossling" }
							LightningStorm.Transform:SetPosition(target.Transform:GetWorldPosition())
						else
							local x, y, z = inst.Transform:GetWorldPosition()      
							local x1 = x + math.random(-15, 15)
							local z1 = z + math.random(-15, 15)
							local LightningStorm = SpawnPrefab("hound_lightning")
							LightningStorm.NoTags = { "INLIMBO", "shadow", "moose", "mossling" }
							LightningStorm.Transform:SetPosition(x1, y, z1)
						end
					end
				end
			end)
		end
	end)
end)

local function EnterPhase2TriggerMother(inst)
	inst.sg:GoToState("taunt")

	for i = 1, 2 do
		if not inst.components.health:IsDead() then
			local target = inst.components.combat.target ~= nil and inst.components.combat.target or nil
			local upgradeburst = SpawnPrefab("mothermossling")
			upgradeburst.Transform:SetPosition(inst.Transform:GetWorldPosition())
			upgradeburst.components.herdmember.herdprefab = "lightning"
			upgradeburst.persists = false
			upgradeburst.mother_dead = true
			upgradeburst:AddComponent("follower")
			upgradeburst.components.follower:SetLeader(inst)
			upgradeburst.sg:GoToState("hatch")
			upgradeburst.components.combat:SuggestTarget(target)
			--[[if target ~= nil then
				upgradeburst.components.locomotor:GoToEntity(target)
				upgradeburst:DoTaskInTime(0, function(inst)
					upgradeburst.sg:GoToState("spin_pre")
				end)
			end]]
		end
	end
	
	if not inst.components.timer:TimerExists("TornadoAttack") then
		inst.components.timer:StartTimer("TornadoAttack", 10)
	end
		
	inst.enraged = true
end

env.AddPrefabPostInit("mothergoose", function(inst)

	if not TheWorld.ismastersim then
		return
	end
	
	if inst.components.combat ~= nil then
		local function isnotmossling(ent)
			if ent ~= nil and not ent:HasTag("mossling") and not ent:HasTag("moose")then -- fix to friendly AOE: refer for later AOE mobs -Axe
				return true
			end
		end
        inst.components.combat:SetAreaDamage(TUNING.DEERCLOPS_AOE_RANGE/2, TUNING.DEERCLOPS_AOE_SCALE, isnotmossling) -- you can edit these values to your liking -Axe
	end       

	if inst.components.combat ~= nil then
		inst.components.combat:SetRange(TUNING.MOOSE_ATTACK_RANGE * 1.1)
	end
	
    inst:AddComponent("groundpounder")
    inst.components.groundpounder.destroyer = false
    inst.components.groundpounder.damageRings = 0
    inst.components.groundpounder.destructionRings = 2
    inst.components.groundpounder.platformPushingRings = 2
    inst.components.groundpounder.numRings = 3
    inst.components.groundpounder.noTags = { "FX", "NOCLICK", "DECOR", "INLIMBO", "mossling", "moose" }
	
	inst:AddComponent("healthtrigger")
	inst.components.healthtrigger:AddTrigger(PHASE2_HEALTH, EnterPhase2TriggerMother)
	
	inst.superhop = true
	
    inst:ListenForEvent("timerdone", SuperHop)
	
	inst:ListenForEvent("newstate", function(inst, data)
		if inst.stormtask == nil and not inst.components.health:IsDead() and inst.components.health:GetPercent() <= 0.3 and data.statename == "disarm" then
			inst.stormtask = inst:DoPeriodicTask(1, function(inst)
				if not inst.components.health:IsDead() then
					if not TheWorld.state.israining then
						TheWorld:PushEvent("ms_forceprecipitation", true)
					end
				
					if inst.stormtaskcounter ~= nil then
						inst.stormtaskcounter = inst.stormtaskcounter + 1
					else
						inst.stormtaskcounter = 1
					end
						
					if inst.stormtaskcounter > 20 then
						inst.stormtask:Cancel()
						inst.stormtask = nil
						inst.stormtaskcounter = 0
					else
						local target = inst.components.combat.target ~= nil and inst.components.combat.target or nil
						if target ~= nil and math.random() > 0.95 then
							local LightningStorm = SpawnPrefab("hound_lightning")
							LightningStorm.NoTags = { "INLIMBO", "shadow", "moose", "mossling" }
							LightningStorm.Transform:SetPosition(target.Transform:GetWorldPosition())
						else
							local x, y, z = inst.Transform:GetWorldPosition()      
							local x1 = x + math.random(-15, 15)
							local z1 = z + math.random(-15, 15)
							local LightningStorm = SpawnPrefab("hound_lightning")
							LightningStorm.NoTags = { "INLIMBO", "shadow", "moose", "mossling" }
							LightningStorm.Transform:SetPosition(x1, y, z1)
						end
					end
				end
			end)
		end
	end)
end)