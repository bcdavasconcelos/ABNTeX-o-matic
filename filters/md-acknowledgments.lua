--[[
acknowledgments-to-meta – move an "acknowledgments" section into document metadata

Copyright: © 2017–2021 Albert Krewinkel
License:   MIT – see LICENSE file for details
]]
local acknowledgments = {}

--- Extract acknowledgments from a list of blocks.
function acknowledgments_from_blocklist (blocks)
  local body_blocks = {}
  local looking_at_acknowledgments = false

  for _, block in ipairs(blocks) do
    if block.t == 'Header' and block.level == 1 then
      if block.identifier == 'acknowledgments' then
        looking_at_acknowledgments = true
      else
        looking_at_acknowledgments = false
        body_blocks[#body_blocks + 1] = block
      end
    elseif looking_at_acknowledgments then
      if block.t == 'HorizontalRule' then
        looking_at_acknowledgments = false
      else
        acknowledgments[#acknowledgments + 1] = block
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
      Blocks = acknowledgments_from_blocklist,
      Meta = function (meta)
        if not meta.acknowledgments and #acknowledgments > 0 then
          meta.acknowledgments = pandoc.MetaBlocks(acknowledgments)
        end
        return meta
      end
  }}
else
  -- otherwise, just check the top-level block-list
  return {{
      Pandoc = function (doc)
        local meta = doc.meta
        local other_blocks = acknowledgments_from_blocklist(doc.blocks)
        if not meta.acknowledgments and #acknowledgments > 0 then
          meta.acknowledgments = pandoc.MetaBlocks(acknowledgments)
        end
        return pandoc.Pandoc(other_blocks, meta)
      end,
  }}
end
