--[[
abbreviations-to-meta – move an "abbreviations" section into document metadata

Copyright: © 2017–2021 Albert Krewinkel
License:   MIT – see LICENSE file for details
]]
local abbreviations = {}

--- Extract abbreviations from a list of blocks.
function abbreviations_from_blocklist (blocks)
  local body_blocks = {}
  local looking_at_abbreviations = false

  for _, block in ipairs(blocks) do
    if block.t == 'Header' and block.level == 1 then
      if block.identifier == 'abbreviations' then
        looking_at_abbreviations = true
      else
        looking_at_abbreviations = false
        body_blocks[#body_blocks + 1] = block
      end
    elseif looking_at_abbreviations then
      if block.t == 'HorizontalRule' then
        looking_at_abbreviations = false
      else
        abbreviations[#abbreviations + 1] = block
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
      Blocks = abbreviations_from_blocklist,
      Meta = function (meta)
        if not meta.abbreviations and #abbreviations > 0 then
          meta.abbreviations = pandoc.MetaBlocks(abbreviations)
        end
        return meta
      end
  }}
else
  -- otherwise, just check the top-level block-list
  return {{
      Pandoc = function (doc)
        local meta = doc.meta
        local other_blocks = abbreviations_from_blocklist(doc.blocks)
        if not meta.abbreviations and #abbreviations > 0 then
          meta.abbreviations = pandoc.MetaBlocks(abbreviations)
        end
        return pandoc.Pandoc(other_blocks, meta)
      end,
  }}
end
