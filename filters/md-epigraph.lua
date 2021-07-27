--[[
epigraph-to-meta – move an "epigraph" section into document metadata

Copyright: © 2017–2021 Albert Krewinkel
License:   MIT – see LICENSE file for details
]]
local epigraph = {}

--- Extract epigraph from a list of blocks.
function epigraph_from_blocklist (blocks)
  local body_blocks = {}
  local looking_at_epigraph = false

  for _, block in ipairs(blocks) do
    if block.t == 'Header' and block.level == 1 then
      if block.identifier == 'epigraph' then
        looking_at_epigraph = true
      else
        looking_at_epigraph = false
        body_blocks[#body_blocks + 1] = block
      end
    elseif looking_at_epigraph then
      if block.t == 'HorizontalRule' then
        looking_at_epigraph = false
      else
        epigraph[#epigraph + 1] = block
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
      Blocks = epigraph_from_blocklist,
      Meta = function (meta)
        if not meta.epigraph and #epigraph > 0 then
          meta.epigraph = pandoc.MetaBlocks(epigraph)
        end
        return meta
      end
  }}
else
  -- otherwise, just check the top-level block-list
  return {{
      Pandoc = function (doc)
        local meta = doc.meta
        local other_blocks = epigraph_from_blocklist(doc.blocks)
        if not meta.epigraph and #epigraph > 0 then
          meta.epigraph = pandoc.MetaBlocks(epigraph)
        end
        return pandoc.Pandoc(other_blocks, meta)
      end,
  }}
end
