local colors = {}

colors.image = "{{ image }}"

<* for name, value in colors *>
colors.{{ name | camel_case }} =  "rgba({{ value.default.hex_alpha_stripped }})"
<* endfor *>

return colors
