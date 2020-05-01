local sprite
local xml2lua

function dumpFrames()
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

function dumpLayers(parent, offset, parentId)
    local layers = {}
    local cels = {}

    parent = parent or sprite
    offset = offset or 0

    for i, layer in ipairs(parent.layers) do
        local id = i + offset

        local layerTable = {
            _attr = {
                id = id,
                name = layer.name,
                stackIndex = layer.stackIndex
            }
        }

        if parentId then
            layerTable._attr.parent = parentId
        end

        local c

        if layer.isGroup then
            layerTable._attr.isGroup = 'true'

            local children, childCels = dumpLayers(layer, offset + #parent.layers, id)

            for i, child in ipairs(children) do
                table.insert(layers, child)
            end

            c = childCels
        else
            if #layer.cels then
                c = dumpCels(layer, id)
            end
        end

        for i, cel in ipairs(c) do
            table.insert(cels, cel)
        end

        table.insert(layers, layerTable)
    end

    return layers, cels
end

function dumpTags()
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

function dumpCels(layer, layerId)
    local cels = {}

    if layer == nil then
        return {}
    end

    layerId = layerId or 0

    for i, c in ipairs(layer.cels) do
        table.insert(
            cels,
            {
                _attr = {
                    layer = layerId,
                    frame = c.frameNumber,
                    opacity = c.opacity
                }
            }
        )
    end

    return cels
end

function dumpPalette()
    local colors = {}
    local palette = {}

    local p = sprite.palettes[1]

    local nextId = 0

    local cel = sprite.cels[1]
    local img = cel.image

    for i = 0, #p - 1 do
        local pixel = p:getColor(i).rgbaPixel

        colors[pixel] = i

        table.insert(
            palette,
            {
                _attr = {
                    id = i,
                    value = pixel
                }
            }
        )
    end

    return colors, palette
end

function init()
    sprite = app.activeSprite

    if not sprite then
        return app.alert("No active Sprite selected!")
    end

    xml2lua = dofile('xml2lua/xml2lua.lua')

    local l, c = dumpLayers()
    local colors, p = dumpPalette()

    local tase = {
        palette = {
            {color = p}
        },
        tags = {
            {tag = dumpTags()}
        },
        frames = {
            {frame = dumpFrames()}
        },
        layers = {
            {layer = l}
        },
        cels = {
            {cel = c}
        }
    }

    local fullPath = app.fs.filePathAndTitle(sprite.filename) .. '.xml'

    local file = io.open(fullPath, 'w')

    file:write(xml2lua.toXml(tase, 'tase'))
end

init()
