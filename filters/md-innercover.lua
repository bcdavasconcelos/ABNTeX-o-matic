--[[
innercover-to-meta – move an "innercover" section into document metadata

Copyright: © 2017–2021 Albert Krewinkel
License:   MIT – see LICENSE file for details
]]
local innercover = {}

--- Extract innercover from a list of blocks.
function innercover_from_blocklist (blocks)
  local body_blocks = {}
  local looking_at_innercover = false

  for _, block in ipairs(blocks) do
    if block.t == 'Header' and block.level == 1 then
      if block.identifier == 'innercover' then
        looking_at_innercover = true
      else
        looking_at_innercover = false
        body_blocks[#body_blocks + 1] = block
      end
    elseif looking_at_innercover then
      if block.t == 'HorizontalRule' then
        looking_at_innercover = false
      else
        innercover[#innercover + 1] = block
      end
    else
      body_blocks[#body_blocks + 1] = block
    end
  end

  return body_blocks
end

if PANDOC_VERSION >= {2,9,2} then
  -- Check all block lists with pandoc 2.9.2 or later
  return {{
      Blocks = innercover_from_blocklist,
      Meta = function (meta)
        if not meta.innercover and #innercover > 0 then
          meta.innercover = pandoc.MetaBlocks(innercover)
        end
        return meta
      end
  }}
else
  -- otherwise, just check the top-level block-list
  return {{
      Pandoc = function (doc)
        local meta = doc.meta
        local other_blocks = innercover_from_blocklist(doc.blocks)
        if not meta.innercover and #innercover > 0 then
          meta.innercover = pandoc.MetaBlocks(innercover)
        end
        return pandoc.Pandoc(other_blocks, meta)
      end,
  }}
end
