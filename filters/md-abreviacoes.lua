--[[
abreviacoes-to-meta – move an "abreviacoes" section into document metadata

Copyright: © 2017–2021 Albert Krewinkel
License:   MIT – see LICENSE file for details
]]
local abreviacoes = {}

--- Extract abreviacoes from a list of blocks.
function abreviacoes_from_blocklist (blocks)
  local body_blocks = {}
  local looking_at_abreviacoes = false

  for _, block in ipairs(blocks) do
    if block.t == 'Header' and block.level == 1 then
      if block.identifier == 'abreviacoes' then
        looking_at_abreviacoes = true
      else
        looking_at_abreviacoes = false
        body_blocks[#body_blocks + 1] = block
      end
    elseif looking_at_abreviacoes then
      if block.t == 'HorizontalRule' then
        looking_at_abreviacoes = false
      else
        abreviacoes[#abreviacoes + 1] = block
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
      Blocks = abreviacoes_from_blocklist,
      Meta = function (meta)
        if not meta.abreviacoes and #abreviacoes > 0 then
          meta.abreviacoes = pandoc.MetaBlocks(abreviacoes)
        end
        return meta
      end
  }}
else
  -- otherwise, just check the top-level block-list
  return {{
      Pandoc = function (doc)
        local meta = doc.meta
        local other_blocks = abreviacoes_from_blocklist(doc.blocks)
        if not meta.abreviacoes and #abreviacoes > 0 then
          meta.abreviacoes = pandoc.MetaBlocks(abreviacoes)
        end
        return pandoc.Pandoc(other_blocks, meta)
      end,
  }}
end
