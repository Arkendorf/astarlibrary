
function findPath(start, final)
  -- adds start to open list
  open = {{start[1], start[2], 0, getH(start, final)}}
  close = {}
  while true do
    -- find lowest F cost
    current, currentPos = getCurrent(open)
    -- switch it to closed list
    table.remove(open, currentPos)

    close[#close + 1] = current
    parent = #close

    -- check adjacent squares
    checkSquare(current[1] + 1, current[2], 10 + current[3], parent, final)
    checkSquare(current[1] + 1, current[2] + 1, 14 + current[3], parent, final)
    checkSquare(current[1], current[2] + 1, 10 + current[3], parent, final)
    checkSquare(current[1] - 1, current[2] + 1, 14 + current[3], parent, final)
    checkSquare(current[1] - 1, current[2], 10 + current[3], parent, final)
    checkSquare(current[1] - 1, current[2] - 1, 14 + current[3], parent, final)
    checkSquare(current[1], current[2] - 1, 10 + current[3], parent, final)
    checkSquare(current[1] + 1, current[2] - 1, 14 + current[3], parent, final)

    -- Check if path is found, or if there is no path
    result, position = closed(final)
    if result == true then
      return tracePath(position)
    elseif #open == 0 then
      return {}
    end
  end
end

function tracePath(position)
  -- finds path backwards based on parent
  i = position
  path = {}
  while i ~= nil do
    path[#path + 1] = {close[i][1], close[i][2]}
    i = close[i][5]
  end
  return path
end



function getH(current, final)
  --gets estimated distance to end
  xD = math.abs(current[1] - final[1])
  yD = math.abs(current[2] - final[2])
  if xD > yD then
    return 14 * yD + 10 * (xD - yD)
  else
    return 14 * xD + 10 * (yD - xD)
  end
end

function getCurrent(open)
  -- finds square with lowest F
  current = 1
  for i = 1, #open do
    if open[i][4] < open[current][4] then
      current = i
    end
  end
  return open[current], current
end

function checkSquare(x, y, g, parent, final)
  -- check if square exists
  if x > 0 and x <= #map[1] and y > 0 and y <= #map then

    -- adjusts closed and open lists with new square
    if map[y][x] == walkable and closed({x, y}) == false then
      result, position = opened({x, y})
      if result == false then
        open[#open + 1] = {x, y, g, g + getH({x, y}, final), parent}
      elseif open[position][3] > g then
        open[position] = {x, y, g, g + getH({x, y}, final), parent}
      end
    end

  end
end

function opened(square)
  --check if square is in open list
  for i = 1, #open do
    if open[i][1] == square[1] and open[i][2] == square[2] then
      return true, i
    end
  end
  return false
end

function closed(square)
  -- check if square is in closed list
  for i = 1, #close do
    if close[i][1] == square[1] and close[i][2] == square[2] then
      return true, i
    end
  end
  return false
end

function setWalkable(num)
  walkable = 1
end

function setMap(table)
  map = table
end
