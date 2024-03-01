
# DayZ Standalone Types Editor

Lightweight Types.xml editor written in PowerShell.

Everything is configurable trough included CSV files.

## Features:
- Change every item of a category to specified Nominal/Min modifier
- Change Lifetime per item, for stuff you always need to change after updating your types, for example your "TerritoryFlag" Lifetime
- Change Nominal/Min per item or multiple items for stuff you want to change after you have updated your types, maybe you don't want to have "CableReel" at "x2" after changing your category tools to "x2"

## Howto:
- Download the script and the CSV's and place them next to each other, wherever you want to.
- In the file "categoryModifier.csv" edit your modifiers for the categories. Example:
```csv
clothes,0.8
container,1.75
```
- In the file "itemLifeTime.csv" edit/insert the types you always need to change. Example: 
```csv
TerritoryFlag,604800
SmallGuts,1800
WildboarPelt,3600
```
- In the file "itemTypes.csv" edit/insert item Nominal/Min that you always need to change back after updating your types. Example:
```csv
Chemlight_White,30,15
Chemlight_Yellow,30,15
CableReel,80,55
```
Just remove stuff from the sample CSV's you don't need, but do never remove the head-line :)

- Place your "types.xml" next to the other files
- Right-click on "DZSA-Types-Editor.ps1" and choose "Run with PowerShell" or inspect and learn from it in a text editor / PowerShell-ISE
