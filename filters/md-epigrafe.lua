--[[
epígrafe-to-meta – move an "epígrafe" section into document metadata

Copyright: © 2017–2021 Albert Krewinkel
License:   MIT – see LICENSE file for details
]]
local epígrafe = {}

--- Extract epígrafe from a list of blocks.
function epígrafe_from_blocklist (blocks)
  local body_blocks = {}
  local looking_at_epígrafe = false

  for _, block in ipairs(blocks) do
    if block.t == 'Header' and block.level == 1 then
      if block.identifier == 'epígrafe' then
        looking_at_epígrafe = true
      else
        looking_at_epígrafe = false
        body_blocks[#body_blocks + 1] = block
      end
    elseif looking_at_epígrafe then
      if block.t == 'HorizontalRule' then
        looking_at_epígrafe = false
      else
        epígrafe[#epígrafe + 1] = block
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
      Blocks = epígrafe_from_blocklist,
      Meta = function (meta)
        if not meta.epígrafe and #epígrafe > 0 then
          meta.epígrafe = pandoc.MetaBlocks(epígrafe)
        end
        return meta
      end
  }}
else
  -- otherwise, just check the top-level block-list
  return {{
      Pandoc = function (doc)
        local meta = doc.meta
        local other_blocks = epígrafe_from_blocklist(doc.blocks)
        if not meta.epígrafe and #epígrafe > 0 then
          meta.epígrafe = pandoc.MetaBlocks(epígrafe)
        end
        return pandoc.Pandoc(other_blocks, meta)
      end,
  }}
end
