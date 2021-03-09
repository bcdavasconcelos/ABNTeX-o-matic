--[[
dedicatoria-to-meta – move an "dedicatoria" section into document metadata

Copyright: © 2017–2021 Albert Krewinkel
License:   MIT – see LICENSE file for details
]]
local dedicatoria = {}

--- Extract dedicatoria from a list of blocks.
function dedicatoria_from_blocklist (blocks)
  local body_blocks = {}
  local looking_at_dedicatoria = false

  for _, block in ipairs(blocks) do
    if block.t == 'Header' and block.level == 1 then
      if block.identifier == 'dedicatoria' then
        looking_at_dedicatoria = true
      else
        looking_at_dedicatoria = false
        body_blocks[#body_blocks + 1] = block
      end
    elseif looking_at_dedicatoria then
      if block.t == 'HorizontalRule' then
        looking_at_dedicatoria = false
      else
        dedicatoria[#dedicatoria + 1] = block
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
      Blocks = dedicatoria_from_blocklist,
      Meta = function (meta)
        if not meta.dedicatoria and #dedicatoria > 0 then
          meta.dedicatoria = pandoc.MetaBlocks(dedicatoria)
        end
        return meta
      end
  }}
else
  -- otherwise, just check the top-level block-list
  return {{
      Pandoc = function (doc)
        local meta = doc.meta
        local other_blocks = dedicatoria_from_blocklist(doc.blocks)
        if not meta.dedicatoria and #dedicatoria > 0 then
          meta.dedicatoria = pandoc.MetaBlocks(dedicatoria)
        end
        return pandoc.Pandoc(other_blocks, meta)
      end,
  }}
end
