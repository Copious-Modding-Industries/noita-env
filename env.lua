--- Fake environment for unit tests to use
local entities = {
    {
        name = "Player",
        alive = true,
        transform = {
            x = 10,
            y = 10,
            rotation = 12,
            scale_x = 1,
            scale_y = 1
        },
        filepath = "data/x/y/player.xml",
        parent = nil,
        children = {},
        tags = "taga, tagb, tagc",
        components = { 1 }
    }
}

local components = { {
    _type = "VariableStorageComponent",
    _enabled = true,
    _tags = "",
    value_int = 10
} }

function EntityGetTransform(id)
    local e = entities[id].transform
    return e.x, e.y, e.rotation, e.scale_x, e.scale_y
end

function EntityGetComponentIncludingDisabled(entity, type)
    local c = {}
    for _, value in ipairs(entities[entity].components) do
        table.insert(c, value)
    end
    return c
end

function EntityKill(_)
    entities[_].alive = false
end

function EntitySetTransform(id, x, y, r, sx, sy)
    entities[id].transform = {
        x = x or entities[id].transform.x,
        y = y or entities[id].transform.y,
        rotation = r or entities[id].transform.rotation,
        scale_x = sx or entities[id].transform.scale_x,
        scale_y = sy or entities[id].transform.scale_y
    }
end

function EntityGetFirstComponentIncludingDisabled(entity, type)
    return EntityGetComponentIncludingDisabled(entity, type)[1]
end
function EntityGetName(id)
    return entities[id].name
end

function EntitySetName(id, name)
    entities[id].name = name
end

function EntityGetTags(id)
    return entities[id].tags
end

function EntityGetWithTag(id)
    return id
end

function EntityGetFilename(id)
    return entities[id].filepath
end

function EntityGetParent(id)
    return entities[id].parent
end

function EntityGetAllChildren(id)
    return entities[id].children
end

function EntityGetIsAlive(e)
    return entities[e].alive
end
function EntityGetWithName(name)
    for index, value in ipairs(entities) do
        if value.name == name then return index end
    end
end

function GetUpdatedEntityID()
    return math.random(1, #entities)
end

function EntityLoad(p, x, y)
    table.insert(entities, {
        name = tostring(#entities),
        transform = {
            x = x,
            y = y,
            rotation = 0,
            scale_x = 1,
            scale_y = 1
        },
        filepath = p,
        parent = nil,
        children = nil,
        tags = "",
        components = {}
    })
    return #entities
end

function EntityCreateNew(name)
    table.insert(entities, {
        name = name,
        transform = {
            x = 0,
            y = 0,
            rotation = 0,
            scale_x = 1,
            scale_y = 1
        },
        filepath = "",
        parent = nil,
        children = nil,
        tags = "",
        components = {},
    })
    return #entities
end

function EntityInflictDamage(_, amount, type, desc, rag_fx, imp_x, imp_y, entity_responsible, pos_x, pos_y,
                             knockback_force)

end

function EntityIngestMaterial(_, material, amount)

end

function EntityAddChild(p, c)
    table.insert(entities[p].children, c)
    entities[c].parent = p
end

function EntityRemoveFromParent(c)
    local parent = entities[entities[c].parent]
    entities[c].parent = nil
    local n = {}
    for _, value in ipairs(parent.children) do
        if value ~= c then table.insert(n, value) end
    end
end

function EntityAddComponent2(ent, type, comp)
    local obj = comp
    obj._type = type
    obj._tags = obj._tags or ""
    obj._enabled = obj._enabled or true
    table.insert(components, obj)
    table.insert(entities[ent].components, #components)
    return #components
end

function EntitySetComponentIsEnabled(_, comp, t)
    components[comp]._enabled = t
end

function EntityRemoveComponent(e, c)
    local nc = {}
    for _, value in ipairs(entities[e].components) do
        if value ~= c then table.insert(nc, value) end
    end
end

function EntityGetFirstComponent(ent, type, tags)
    for index, value in ipairs(components) do
        if value._type == type and value._tags:find(tags) then return index end
    end
end

function CellFactory_GetType(_)
    return 1
end

function ComponentGetIsEnabled(c)
    return components[c]._enabled
end

function ComponentGetValue2(c, k)
    return components[c][k]
end

function ComponentSetValue2(c, k, v)
    components[c][k] = v
end


-- EntityGetInRadius and EntityGetClosest return predefined entity ids

function EntityGetInRadius(_, _, _)
    return {10002, 10003, 10004}
end

function EntityGetInRadiusWithTag(_, _, _, _)
    return {10005, 10006, 10007}
end
function EntityGetClosest(_, _)
    return 10001
end

function EntityGetClosestWithTag(_, _, _)
    return 10001
end

function LoadGameEffectEntityTo(_, _)
    return nil
end

function Debug_GetEntityTable()
    return entities
end

function Debug_GetComponentTable()
    return components
end
