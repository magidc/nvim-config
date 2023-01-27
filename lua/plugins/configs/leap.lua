local ok, leap = pcall(require, "leap")

if not ok then
    return
end

-- Overriding "S" mappings with <a-s> to avoid loosing S default functionality (insert in the correct line indentation)
local function set_default_keymaps(force_3f)
  for _, _4_ in ipairs({{"n", "s", "<Plug>(leap-forward)"}, {"n", "<a-s>", "<Plug>(leap-backward)"}, {"x", "s", "<Plug>(leap-forward)"}, {"x", "<a-s>", "<Plug>(leap-backward)"}, {"o", "z", "<Plug>(leap-forward)"}, {"o", "Z", "<Plug>(leap-backward)"}, {"o", "x", "<Plug>(leap-forward-x)"}, {"o", "X", "<Plug>(leap-backward-x)"}, {"n", "gs", "<Plug>(leap-cross-window)"}, {"x", "gs", "<Plug>(leap-cross-window)"}, {"o", "gs", "<Plug>(leap-cross-window)"}}) do
    local _each_5_ = _4_
    local mode = _each_5_[1]
    local lhs = _each_5_[2]
    local rhs = _each_5_[3]
    if (force_3f or ((vim.fn.mapcheck(lhs, mode) == "") and (vim.fn.hasmapto(rhs, mode) == 0))) then
      vim.keymap.set(mode, lhs, rhs, {silent = true})
    else
    end
  end
  return nil
end


set_default_keymaps()
