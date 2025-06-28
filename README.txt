# AutoGroup GUI for MacroQuest

A lightweight, intuitive graphical interface for managing the [MQ2AutoGroup](https://www.redguides.com/community/resources/mq2autogroup.2671/) plugin in EverQuest.

This GUI allows you to control group creation, player management, role assignments, and startup commands — all from a clean ImGui window, with helpful tooltips and color-coded buttons.

## ✨ Features

- Create and delete AutoGroup sessions
- Add or remove players, mercs, and broadcast clients (EQBC / DanNet)
- Assign key group roles (Main Tank, Puller, Master Looter, etc.)
- Set optional startup commands (e.g., auto-start macros)
- Toggle mercenary auto-handling on/off
- Clean GUI layout with centered buttons and tooltips
- **Hidden debug mode** for development or advanced users

## 🔧 Usage

1. **Install the `MQ2AutoGroup` plugin** via RedGuides or your preferred plugin manager.
2. Place `autogroupgui.lua` into your `MacroQuest/lua` directory.
      will need to rename 'init.lua' to 'autogrougui.lua', alternatly you can download full zip and rename the folder
      'autogroupgui-main' to 'AutogrouGui'
3. In-game or in your MQ2 window, run:
   ```
   /lua run autogroupgui
   ```
4. Toggle the GUI with:
   ```
   /autogroupgui
   ```

> ℹ️ The GUI requires the `MQ2AutoGroup` plugin to be loaded.

## 🧪 Optional: Debug Mode

Advanced users can toggle a hidden debug print mode:
```
/autogroupdebuggui
```
This will display additional information when using certain features (like setting startup commands).

## ❌ Exit the GUI

Click the `Exit Script` button in the GUI or use:
```
/lua stop autogroupgui
```

## ✅ Compatibility

- Compatible with **VanillaMQ** and other modern builds of MacroQuest.
- Designed for **first-release stability** — no dependencies beyond `mq` and `ImGui`.

## 📷 Preview

![AutoGroup GUI Preview](autogroupgui_preview.png)

---

© 2025 - Released for public use under the MIT License (or your license of choice).
