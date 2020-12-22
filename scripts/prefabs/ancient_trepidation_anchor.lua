require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/pitcher.zip"),

    Asset("ANIM", "anim/bee_box_hermitcrab.zip"),
    Asset("MINIMAP_IMAGE", "beebox_hermitcrab"),
}
local function Initialize(inst)
local pt = inst:GetPosition()
if #TheSim:FindEntities(pt.x,pt.y,pt.z,0,{"trepidationspawner"}) > 1 then
inst:Remove()
end
end

    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddMiniMapEntity()
        inst.entity:AddNetwork()


        inst.MiniMapEntity:SetIcon("pitcher.tex")

		--inst.AnimState:SetBank("pitcher")
		--inst.AnimState:SetBuild("pitcher")
		--inst.AnimState:PushAnimation("swinglong")
		--inst:AddTag("CLASSIFIED")


        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        ---------------------  

		inst:AddTag("trepidationspawner")
        -------------------
		
        inst:AddComponent("childspawner")
        inst.components.childspawner.childname = "ancient_trepidation"

        inst.components.childspawner:StartSpawning()
		
		inst.components.childspawner:SetMaxChildren(1)
		inst.components.childspawner:SetSpawnPeriod(TUNING.DRAGONFLY_SPAWN_TIME/4, 0)
	
		inst:DoTaskInTime(math.random(0.1,0.2),Initialize)
		MakeLargePropagator(inst)
		
        return inst
    end

return Prefab("ancient_trepidation_anchor", fn)

    