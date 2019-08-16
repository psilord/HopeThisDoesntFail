# HopeThisDoesntFail

An STG with both classic elements and new ideas.

A *Common Lisp* game.

## Planning

 - No magic girls, military only.

 - One Big, Long Level where the player goes high for aerial battle and low for
   ground battle/strafing.
 - Game screen is effective 240x320 (vertical orientation) with 16x16 tiles.
   This means 20 vertical tiles and 15 horizontal tiles on the screen at once.
 - 30 minutes of game play (possibly not counting bosses).
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
 - If we need enemies that appear to be made with with larger tiles
   we'll compose them out of the smaller ones.

### Plan Comments
One property I like is the big level sort of becomes an endurance test. Like, 
we can record pausings (and amount of time that was spent in pause)
of the game and such as part of your score. No pauses might elicit
a large bonus modifier, etc.

The single level is split into Zones where the user seamlessly crosses
from one to the other as opposed to individual levels with a defined
beginning and ending. However, when you cross from one zone to another
you're told this is happening so you know where you are.

I checked Raiden II for reference and it took ten seconds for
something entering the top of the screen to when it left on the
bottom. If we use 240x320, we could go a whole screen per 10 seconds
which equals 20 tiles per 10 seconds which reduces to 2 tiles per
second. Of course, we can make that rate easily adjustable or even
dynamically changeable depending on what's being fought.

So a 30 minute game at 240x320 at 2 tiles a second:

30 * 60 * 2 = 3600 tiles in the vertical dimension of the game board. And
of course 15 tiles wide. For a grand total of 54,000 tiles comprising the
entire level. 

### Breakdown of Zones
Now, suppose we split the game into 50 Zones, then each zone is 3600
/ 50 = 72 tiles long which takes 36 seconds to complete (at a rate
of 2 tiles a second).  ~30 seconds seems a pretty good to get a new
"progress" marker. (But, supposing we wanted 1 minute per zone, we'd have
144 vertical tiles per zone and would have to redo the zone layout below.)

| Zone | Visual Theme Summary |
|---|---|
|0-9  | Islands & Coastline  | 
|10-19  | Swamps |
|20-29  | Forests & lakes  |
|30-39  | Scrubland & rocky out croppings |
|40-49  | Mountains & Glaciers |
|50  | Large (36sec to cross) crashed alien ship in mountains & boss|

### Breakdown of EACH zone

TODO

## Story (15 minutes into the future)

### Summary

An alien ship has crashed into the mountains and two human political
factions are fighting each other to get to the wreckage. However, alien
ships start pouring out of the wreckage and decimate both groups causing
them to join together and defeat the overwhelming threat.

## The Idea Bin
Clown shot bullets used tastefully. (Bullets split and fork, zig zag,
circle back then resume, sine wave)

## Unresolved Items
