-------------------------------------------------------------------------------
-- 1. Main size.
-------------------------------------------------------------------------------
hs.hotkey.bind(preKeys, "1", function()
  if hs.window.focusedWindow() then
    local window = hs.window.focusedWindow()
    local frame = window:frame()
    local screen = window:screen():frame()

    frame.x = 0
    frame.y = 0
    frame.w = 1319
    frame.h = screen.h

    hs.alert.show(" Size 1", 1)
    window:setFrame(frame)
  else
    hs.alert.show(" No Active Window")
  end
end)

-------------------------------------------------------------------------------
-- 2. Alternative main size.
-------------------------------------------------------------------------------
hs.hotkey.bind(preKeys, "2", function()
  if hs.window.focusedWindow() then
    local window = hs.window.focusedWindow()
    local frame = window:frame()
    local screen = window:screen():frame()

    frame.x = 0
    frame.y = 0
    frame.w = 1160
    frame.h = screen.h

    hs.alert.show(" Size 2", 1)
    window:setFrame(frame)
  else
    hs.alert.show(" No Active Window")
  end
end)

-------------------------------------------------------------------------------
-- 3. Finder.
-------------------------------------------------------------------------------
hs.hotkey.bind(preKeys, "3", function()
  if hs.window.focusedWindow() then
    local window = hs.window.focusedWindow()
    local frame = window:frame()
    local screen = window:screen():frame()

    frame.x = 104
    frame.y = 0
    frame.w = 1160 - frame.x
    frame.h = screen.h

    hs.alert.show(" Size 3", 1)
    window:setFrame(frame)
  else
    hs.alert.show(" No Active Window")
  end
end)

-------------------------------------------------------------------------------
-- 4. Messages.
-------------------------------------------------------------------------------
hs.hotkey.bind(preKeys, "4", function()
  if hs.window.focusedWindow() then
    local window = hs.window.focusedWindow()
    local frame = window:frame()
    local screen = window:screen():frame()
    local margin = 279

    frame.x = screen.x + margin
    frame.y = 109
    frame.w = screen.w - (margin * 2) - 1
    frame.h = 600

    hs.alert.show(" Size 4", 1)
    window:setFrame(frame)
  else
    hs.alert.show(" No Active Window")
  end
end)

-------------------------------------------------------------------------------
-- 5. Transmission.
-------------------------------------------------------------------------------
hs.hotkey.bind(preKeys, "5", function()
  if hs.window.focusedWindow() then
    local window = hs.window.focusedWindow()
    local frame = window:frame()
    local screen = window:screen():frame()
    local margin = 468

    frame.x = screen.x + margin
    frame.y = 94
    frame.w = screen.w - (margin * 2) - 1
    frame.h = 660

    hs.alert.show(" Size 5", 1)
    window:setFrame(frame)
  else
    hs.alert.show(" No Active Window")
  end
end)

-------------------------------------------------------------------------------
-- 6. Maximize window (and revert).
-------------------------------------------------------------------------------
hs.hotkey.bind(preKeys, "6", function()
  if hs.window.focusedWindow() then
    hs.alert.show(" Maximize", 1)
    hs.window.focusedWindow():maximize()
  else
    hs.alert.show(" No Active Window")
  end
end)

-------------------------------------------------------------------------------
-- 7. Move window to center.
-------------------------------------------------------------------------------
hs.hotkey.bind(preKeys, "7", function()
  if hs.window.focusedWindow() then
    local window = hs.window.focusedWindow()
    local frame = window:frame()
    local screen = window:screen():frame()

    frame.x = (screen.w / 2) - (frame.w / 2)
    frame.y = (screen.h / 2) - (frame.h / 2)

    hs.alert.show(" Center", 1)
    window:setFrame(frame)
  else
    hs.alert.show(" No Active Window")
  end
end)

-------------------------------------------------------------------------------
-- 8. Move and resize window 50% left (and revert).
-------------------------------------------------------------------------------
local frameLeftCache = {}

hs.hotkey.bind(preKeys, "8", function()
  if hs.window.focusedWindow() then
    local window = hs.window.focusedWindow()

    if frameLeftCache[window:id()] then
      hs.alert.show(" Revert", 1)
      window:setFrame(frameLeftCache[window:id()])
      frameLeftCache[window:id()] = nil
    else
      hs.alert.show(" 50% Left", 1)
      frameLeftCache[window:id()] = window:frame()
      window:focusedWindow():moveToUnit(hs.layout.left50)
    end
  else
    hs.alert.show(" No Active Window")
  end
end)

-------------------------------------------------------------------------------
-- 9. Move and resize window 50% right (and revert).
-------------------------------------------------------------------------------
local frameRightCache = {}

hs.hotkey.bind(preKeys, "9", function()
  if hs.window.focusedWindow() then
    local window = hs.window.focusedWindow()

    if frameRightCache[window:id()] then
      hs.alert.show(" Revert", 1)
      window:setFrame(frameRightCache[window:id()])
      frameRightCache[window:id()] = nil
    else
      hs.alert.show(" 50% Right", 1)
      frameRightCache[window:id()] = window:frame()
      window:focusedWindow():moveToUnit(hs.layout.right50)
    end
  else
    hs.alert.show(" No Active Window")
  end
end)

-------------------------------------------------------------------------------
-- 0. Move window to the top left.
-------------------------------------------------------------------------------
hs.hotkey.bind(preKeys, "0", function()
  if hs.window.focusedWindow() then
    hs.alert.show(" Top Left", 1)
    hs.window.focusedWindow():setTopLeft(0,0)
  else
    hs.alert.show(" No Active Window")
  end
end)
