local sprite
local xml2lua

function loadFrames()
    local frames = {}

    for i, f in ipairs(sprite.frames) do
        table.insert(
            frames,
            {
                _attr = {
                    id = f.frameNumber,
                    duration = f.duration
                }
            }
        )
    end

    return frames
end

function loadTags()
    local tags = {}

    for i, t in ipairs(sprite.tags) do
        table.insert(
            tags,
            {
                _attr = {
                    id = i,
                    from = t.fromFrame.frameNumber,
                    to = t.toFrame.frameNumber,
                    name = t.name
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
        },
        tags = {
            {tag = loadTags()}
        }
    }

    local fullPath = app.fs.filePathAndTitle(sprite.filename) .. '.xml'

    local file = io.open(fullPath, 'w')

    file:write(xml2lua.toXml(tase, 'tase'))
end

init()
