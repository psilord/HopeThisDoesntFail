# HopeThisDoesntFail

An STG with both classic elements and new ideas.

A *Common Lisp* game.

## Planning

 - No magic girls, military only.
 - One Big, Long Level where the player goes high for aerial battle and low for
   ground battle/strafing.
 - 30 minutes of game play (possibly not counting bosses)
 - Around 20 total enemies with new ones revealed after certain regions are passed.
 - Bosses with 2 phases (changing firing patterns and body shape per phase)
 - Glorious klaxon and banner warning the player before a boss. (diagonal scrolling or go home)
 - Simple movement paths for enemies and a way to layer the paths side
   by side for squadron attacks. Easy mirroring of paths and varying left and right with timer.
 - Player movement offered as square gate or octagon gate.
 - Player weapon fires fast enough to move with player (no 45 degree nonsense while moving, unless special weapon)
 - There are two modes to the game: "Practice Mode" and "Arcade Mode".
   Practice mode has infinite lives and allows you to play the whole of the
   game and it keeps track of the number of lives used. However, true
   unlockables can only be unlocked in Arcade Mode. These have to be visually
   marked so the player knows they are only unlockable in arcade mode.
 - No need for continue system since they can have all the practice they want.
 - Game screen is effective 240x320 (vertical orientation) with 16x16 tiles.
 - If we need enemies that appear to be made with with larger tiles
   we'll compose them out of the smaller ones.

One property I like is the big level sort of becomes an endurance test. Like, 
we can record pausings (and amount of time that was spent in pause)
of the game and such as part of your score. No pauses might elicit
a large bonus modifier, etc.

The single level is split into Zones where the user seamlessly crosses
from one to the other as opposed to individual levels with a defined
beginning and ending.

| Zone | Visual Theme Summary |
|---|---|
|0  | Coastline  | 
|1  | Swamps |
|2  | Forests & lakes  |
|3  | Scrubland & rocky out croppings |
|4  | Mountains & Glaciers |
|5  | Large (like minutes to cross) crashed alien ship in mountains  |

## Story


## The Idea Bin
Clown shot bullets used tastefully. (Bullets split and fork, zig zag,
circle back then resume, sine wave)

## Unresolved Items
