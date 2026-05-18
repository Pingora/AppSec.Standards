local function has_scheme(target)
  return target:match("^[A-Za-z][A-Za-z0-9+.-]*:") ~= nil
end

local function split_suffix(target)
  local start_index = target:find("[#?]")
  if start_index == nil then
    return target, ""
  end

  return target:sub(1, start_index - 1), target:sub(start_index)
end

function Link(link)
  if has_scheme(link.target) or link.target:sub(1, 1) == "#" then
    return nil
  end

  local path, suffix = split_suffix(link.target)
  if path:lower():match("%.md$") then
    link.target = path:sub(1, -4) .. ".pdf" .. suffix
    return link
  end

  return nil
end
