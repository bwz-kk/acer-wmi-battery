# Fork notes

This is a fork of [frederik-h/acer-wmi-battery](https://github.com/frederik-h/acer-wmi-battery)
(upstream commit `9f90d75`), maintained for use by
[NitroControl](https://github.com/bwz-kk/NitroControl) as an optional,
detect-only runtime dependency (M6 — battery charge limit).

## Why this fork exists

1. **Bug fix**: `get_battery_health_control_status()` and
   `set_battery_health_control()` both dereferenced `obj->buffer.pointer`
   before validating `obj->buffer.length` matched the expected struct
   size — an out-of-bounds heap read if the WMI method ever returned a
   shorter buffer than expected. Fixed by reordering the length check
   before the dereference. Not yet reported/merged upstream — will be
   submitted there; this fork exists so NitroControl isn't blocked on
   that review cycle.
2. **DKMS packaging** (`dkms.conf`) — upstream doesn't ship one; needed
   for NitroControl's optional-setup install path to survive kernel
   upgrades without a manual rebuild.

## Relationship to upstream

Tracked as git remote `upstream`. Rebased on upstream periodically. Once
Jelle van der Waa's in-tree `platform/x86` submission
([LWN #1055804](https://lwn.net/Articles/1055804/)) merges into
mainline, or the heap-read fix lands upstream here, NitroControl's
`docs/optional-setup.md` will point there instead and this fork will be
archived.

## License

GPL-2.0-or-later, unchanged from upstream. Original author: Frederik
Harwath.
