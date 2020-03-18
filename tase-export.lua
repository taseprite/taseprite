local sprite
local xml2lua

function loadTags()
    local tags = {}

    for i, t in ipairs(sprite.tags) do
        table.insert(
            tags,
            {
                from = t.fromFrame.frameNumber,
                to = t.toFrame.frameNumber,
                name = t.name,
                _attr = {
                    id = i
                }
            }
        )
    end

    return tags
end

function loadCels()
    local cels = {}

    for i, c in ipairs(sprite.cels) do
        table.insert(
            cels,
            {
                _attr = {
                    layer = c.layer.stackIndex,
                    frame = c.frameNumber,
                    opacity = c.opacity
                }
            }
        )
    end

    return cels
end

function init()
    sprite = app.activeSprite

    if not sprite then
        return app.alert("No active Sprite selected!")
    end

    xml2lua = dofile('xml2lua/xml2lua.lua')

    local tase = {
        cels = {
            {cel = loadCels()}
        }
    }

    local file = io.open('test.xml', 'w')

    file:write(xml2lua.toXml(tase, 'tase'))
end

init()
