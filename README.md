# taseprite

## XML Structure

```XML
<?xml version="1.0" encoding="UTF-8"?>
<tase version="1.0.0" aseprite-version="1.2.17" width="32" height="32" filename="test.ase">
    <colors>
        <color id="1" hex-value="#00ff00ff" />
        <color id="2" hex-value="#0012eeff" />
    </colors>
    <palette>
        <color-ref id="1" color-id="2" />
    </palette>
    <tags>
        <tag from="1" to="3" name="Idle" color="#ff0000ff" />
    </tags>
    <layers>
        <layer id="1" is-group="true" opacity="255" blend-mode="NORMAL" />
        <layer id="2" parent="1" opacity="255" blend-mode="NORMAL" />
    </layers>
    <frames>
        <frame id="1" duration="100" />
    </frames>
    <images>
        <image id="1" width="5" height="3" color-mode="RGB">
            1,0,0,0,2
            0,0,1,1,1
            0,0,2,0,0
        </image>
    </images>
    <cels>
        <cel layer="1" frame="2" image="1" opacity="255" />
    </cels>
</tase>
```

## Additional Credits

This project utilises functionality of the `xml2lua` package, published under
the MIT-License (see `xml2lua/LICENSE`)
