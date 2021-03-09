--[[
contracapa-to-meta – move an "contracapa" section into document metadata

Copyright: © 2017–2021 Albert Krewinkel
License:   MIT – see LICENSE file for details
]]
local contracapa = {}

--- Extract contracapa from a list of blocks.
function contracapa_from_blocklist (blocks)
  local body_blocks = {}
  local looking_at_contracapa = false

  for _, block in ipairs(blocks) do
    if block.t == 'Header' and block.level == 1 then
      if block.identifier == 'contracapa' then
        looking_at_contracapa = true
      else
        looking_at_contracapa = false
        body_blocks[#body_blocks + 1] = block
      end
    elseif looking_at_contracapa then
      if block.t == 'HorizontalRule' then
        looking_at_contracapa = false
      else
        contracapa[#contracapa + 1] = block
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
      Blocks = contracapa_from_blocklist,
      Meta = function (meta)
        if not meta.contracapa and #contracapa > 0 then
          meta.contracapa = pandoc.MetaBlocks(contracapa)
        end
        return meta
      end
  }}
else
  -- otherwise, just check the top-level block-list
  return {{
      Pandoc = function (doc)
        local meta = doc.meta
        local other_blocks = contracapa_from_blocklist(doc.blocks)
        if not meta.contracapa and #contracapa > 0 then
          meta.contracapa = pandoc.MetaBlocks(contracapa)
        end
        return pandoc.Pandoc(other_blocks, meta)
      end,
  }}
end
