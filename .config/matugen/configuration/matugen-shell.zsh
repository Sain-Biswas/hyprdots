export FZF_DEFAULT_OPTS=" \
    --style full \
    --color=fg:{{ colors.on_surface_variant.default.hex }},bg:-1,hl:{{ colors.primary.default.hex }} \
    --color=fg+:{{ colors.on_surface.default.hex }},bg+:{{ colors.surface_container_highest.default.hex }},hl+:{{ colors.on_primary_container.default.hex }} \
    --color=spinner:{{ colors.secondary.default.hex }},header:{{ colors.error.default.hex }},info:{{ colors.tertiary.default.hex }} \
    --color=pointer:{{ colors.tertiary.default.hex }},marker:{{ colors.error.default.hex }},prompt:{{ colors.secondary.default.hex }} \
    --color=selected-bg:{{ colors.surface_bright.default.hex }} \
    --color=border:{{ colors.outline.default.hex }},label:{{ colors.primary.default.hex }},gutter:{{ colors.surface.default.hex }} \
    --multi"

