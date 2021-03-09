--[[
resumo-to-meta – move an "resumo" section into document metadata

Copyright: © 2017–2021 Albert Krewinkel
License:   MIT – see LICENSE file for details
]]
local resumo = {}

--- Extract resumo from a list of blocks.
function resumo_from_blocklist (blocks)
  local body_blocks = {}
  local looking_at_resumo = false

  for _, block in ipairs(blocks) do
    if block.t == 'Header' and block.level == 1 then
      if block.identifier == 'resumo' then
        looking_at_resumo = true
      else
        looking_at_resumo = false
        body_blocks[#body_blocks + 1] = block
      end
    elseif looking_at_resumo then
      if block.t == 'HorizontalRule' then
        looking_at_resumo = false
      else
        resumo[#resumo + 1] = block
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
      Blocks = resumo_from_blocklist,
      Meta = function (meta)
        if not meta.resumo and #resumo > 0 then
          meta.resumo = pandoc.MetaBlocks(resumo)
        end
        return meta
      end
  }}
else
  -- otherwise, just check the top-level block-list
  return {{
      Pandoc = function (doc)
        local meta = doc.meta
        local other_blocks = resumo_from_blocklist(doc.blocks)
        if not meta.resumo and #resumo > 0 then
          meta.resumo = pandoc.MetaBlocks(resumo)
        end
        return pandoc.Pandoc(other_blocks, meta)
      end,
  }}
end
