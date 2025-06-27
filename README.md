# AutoGroup GUI for MacroQuest

A lightweight, intuitive graphical interface that provides convenient buttons for issuing commands to the [MQ2AutoGroup](https://www.redguides.com/community/resources/mq2autogroup.2671/) plugin in EverQuest.

**Important:** This GUI is simply a command interface - it sends pre-defined commands to the MQ2AutoGroup plugin. The actual group management functionality comes from the MQ2AutoGroup plugin itself, not this GUI.

## ✨ What This GUI Does

- Provides clickable buttons for common MQ2AutoGroup commands
- Creates and deletes AutoGroup sessions via `/autogroup create` and `/autogroup delete`
- Adds/removes players, mercs, and broadcast clients with pre-set commands
- Assigns group roles (Main Tank, Puller, etc.) through command buttons
- Includes a text input field for custom startup commands
- Displays helpful tooltips showing the exact command each button executes
- **All buttons execute static commands except the startup command field which accepts user input**

## 🔧 Installation & Usage

### Prerequisites
- **MQ2AutoGroup plugin must be installed and loaded** - this GUI only sends commands to that plugin

### Installation
1. Create a folder named `autogroupgui` in your `MacroQuest/lua` directory
2. Place the `init.lua` file inside the `autogroupgui` folder
3. Your folder structure should look like: `MacroQuest/lua/autogroupgui/init.lua`

### Running the GUI
In-game or in your MQ2 console:
```
/lua run autogroupgui
```

Toggle the GUI window with:
```
/autogroupgui
```

> ⚠️ **Note:** The GUI requires the MQ2AutoGroup plugin to be loaded to function properly.

## 🎮 How It Works

This GUI is essentially a collection of buttons that execute specific MQ2AutoGroup commands:

- **Green buttons** typically execute "add" or "create" commands
- **Red buttons** execute "remove" or "delete" commands  
- **Blue buttons** execute "status" or informational commands
- **Role buttons** execute `/autogroup set [role]` commands
- **Startup command field** allows you to input custom commands like `/mac kissassist`

When you click a button, the GUI sends the corresponding command to MQ2AutoGroup - it doesn't perform any group management itself.

## 🧪 Debug Mode (Optional)

For troubleshooting or development:
```
/autogroupdebuggui
```
This displays additional information when using certain features.

## ❌ Exiting

- Click the `Exit Script` button in the GUI, or
- Use: `/lua stop autogroupgui`

## ✅ Compatibility

- Compatible with **VanillaMQ** and other modern MacroQuest builds
- Requires only `mq` and `ImGui` libraries (standard with MacroQuest)
- Designed for stability with minimal dependencies

## 📝 Command Reference

The GUI buttons execute these commands:
- Group creation: `/autogroup create`, `/autogroup delete`
- Player management: `/autogroup add/remove player/merc/dannet/eqbc`
- Role assignment: `/autogroup set maintank/mainassist/puller/etc`
- Mercenary handling: `/autogroup handlemerc on/off`
- Startup commands: `/autogroup startcommand "your command here"`

---

© 2025 - Released for public use under the MIT License.
