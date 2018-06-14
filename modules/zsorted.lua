local getZSortedItems = {}

local bump2d   = require 'modules.bump.bump'
local tsort    = require 'modules.tsort'

local world2d = bump2d.newWorld()

function getZSortedItems:call(world)
  -- Add or update draw positions of all visible items.
  for _, item in ipairs(world:getItems()) do
    if item.invisible ~= true then
      local x,y,z,w,h,d = world:getCube(item)
      if world2d:hasItem(item) then
        world2d:update(item, x, y + z)
      else
        world2d:add(item, x, y + z, w, h + d)
      end
    end
  end

  local graph = tsort.new()
  local noOverlap = {}

  -- Iterate through all visible items, and calculate ordering of all pairs
  -- of overlapping items.
  -- TODO: Each pair is calculated twice currently. Maybe this is slow?
  for _, itemA in ipairs(world2d:getItems()) do repeat
    local x, y, w, h = world2d:getRect(itemA)
    local otherItemsFilter = function(other) return other ~= itemA end
    local overlapping, len = world2d:queryRect(x, y, w, h, otherItemsFilter)

    if len == 0 then
      table.insert(noOverlap, itemA)

      break
    end

    local _, aY, aZ, _, aH, aD = world:getCube(itemA)
    for _, itemB in ipairs(overlapping) do
      local _, bY, bZ, _, bH, bD = world:getCube(itemB)
      if aZ + aD <= bZ then
        -- item A is completely above item B
        graph:add(itemB, itemA)
      elseif bZ + bD <= aZ then
        -- item B is completely above item A
        graph:add(itemA, itemB)
      elseif aY + aH <= bY then
        -- item A is completely behind item B
        graph:add(itemA, itemB)
      elseif bY + bH <= aY then
        -- item B is completely behind item A
        graph:add(itemB, itemA)
      elseif aY + aZ + aH + aD >= bY + bZ + bH + bD then
        -- item A's forward-most point is in front of item B's forward-most point
        graph:add(itemB, itemA)
      else
        -- item B's forward-most point is in front of item A's forward-most point
        graph:add(itemA, itemB)
      end
    end
  until true end

  local sorted, err = graph:sort()
  if err then
    error(err)
  end
  for _, item in ipairs(noOverlap) do
    table.insert(sorted, item)
  end

  return sorted
end

return getZSortedItems
