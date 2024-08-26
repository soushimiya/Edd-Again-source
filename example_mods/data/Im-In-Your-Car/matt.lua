-- script by ItsCapp don't steal, it's dumb
-- https://gamebanana.com/tools/8427


idleOffsets = {'0', '0'}

idle_xml_name = 'Matt Zom idle'

x_position = 1580
y_position = 260

xScale = 1.2
yScale = 1.2

name_of_character_xml = 'Matt Zom'
name_of_character = 'matt'
charNote = 'matt'

playableCharacter = true      -- change to 'true' if you want to the character on teamDad
flipX = false       -- most likely change to 'true' if using a BF sided character
useIdle = true      -- Use idle code or Dance code (EG: Skid&Pump, GF)
invisible = false   -- invisible character (if you want to use the change character event, you need to make the second character invisible first)
teamplay = false     -- Should character simply sing all notes on their side
layer = 12           --[[ Usable values:
0 : Behind stage
1 : Behind all
2 : In front of GF, behind Opponent and Player
3 : In front of GF and Opponent, behind Player
4 : In front of All
5+: Free Real Estate                      --]]

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

doIdle = true;
seriouslyDontIdle = false;      -- if you want to play a longer animation you can use this when necessary to temporarily override doIdle.

function onCreate()
    makeAnimatedLuaSprite(name_of_character, 'characters/' .. name_of_character_xml, x_position, y_position);

    addAnimationByPrefix(name_of_character, 'idle', idle_xml_name, 24, true);
    --addAnimationByIndices(name_of_character, 'danceLeft', idle_xml_name, '8,10,12,14' , 12);
    --addAnimationByIndices(name_of_character, 'danceRight', idle_xml_name, '0,2,4,6', 12);
    addAnimationByPrefix(name_of_character, 'singLEFT', left_xml_name, 24, false);
    addAnimationByPrefix(name_of_character, 'singDOWN', down_xml_name, 24, false);
    addAnimationByPrefix(name_of_character, 'singUP', up_xml_name, 24, false);
    addAnimationByPrefix(name_of_character, 'singRIGHT', right_xml_name, 24, false);

    addAnimationByPrefix(name_of_character, 'singLEFTmiss', left_miss_xml_name, 24, false);
    addAnimationByPrefix(name_of_character, 'singDOWNmiss', down_miss_xml_name, 24, false);
    addAnimationByPrefix(name_of_character, 'singUPmiss', up_miss_xml_name, 24, false);
    addAnimationByPrefix(name_of_character, 'singRIGHTmiss', right_miss_xml_name, 24, false);

    addAnimationByPrefix(name_of_character, 'singLEFT-alt', left_alt_xml_name, 24, false);
    addAnimationByPrefix(name_of_character, 'singDOWN-alt', down_alt_xml_name, 24, false);
    addAnimationByPrefix(name_of_character, 'singUP-alt', up_alt_xml_name, 24, false);
    addAnimationByPrefix(name_of_character, 'singRIGHT-alt', right_alt_xml_name, 24, false);

    setPropertyLuaSprite(name_of_character, 'flipX', flipX);
    setPropertyLuaSprite(name_of_character, 'alpha', not invisible);
    scaleObject(name_of_character, xScale, yScale);
    setObjectOrder(name_of_character, layer, false);
end

function onCountdownTick(counter)
    idleDance(counter);
end

function onEvent(name, value1, value2)
    if name == "CharacterPlayAnimation" then
        doIdle = false;
        seriouslyDontIdle = true;
        addAnimationByPrefix(value2, value1, value1, 24, false);
        objectPlayAnimation(value2, value1, true);
    elseif name == "ToggleTeamplay" then
        local case = {["true"] = true, ["1"] = true, ["false"] = false, ["0"] = false, [""] = not teamplay};
        if name_of_character == value1 then
            teamplay = case[string.lower(value2)];
        end
    end
end

local singAnims = {"singLEFT", "singDOWN", "singUP", "singRIGHT"};
local singOffsets = {leftOffsets, downOffsets, upOffsets, rightOffsets};
local altAnims = {"singLEFT-alt", "singDOWN-alt", "singUP-alt", "singRIGHT-alt"};
local altOffsets = {leftAltOffsets, downAltOffsets, upAltOffsets, rightAltOffsets};
local missAnims = {"singLEFTmiss", "singDOWNmiss", "singUPmiss", "singRIGHTmiss"};
local missOffsets = {leftMissOffsets, downMissOffsets, upMissOffsets, rightMissOffsets};


-- I know this is messy, but it's the only way I know to make it work on both sides.
-- Don't worry bro I cleaned it up -Scarab

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if not playableCharacter then
        if noteType == charNote or noteType == charNote2 then
            doIdle = false;
            objectPlayAnimation(name_of_character, singAnims[direction + 1], true);
            setProperty(name_of_character .. '.offset.x', singOffsets[direction + 1][1]);
            setProperty(name_of_character .. '.offset.y', singOffsets[direction + 1][2]);
        elseif noteType == altCharNote or noteType == altCharNote2 then
            doIdle = false;
            objectPlayAnimation(name_of_character, altAnims[direction + 1], true);
            setProperty(name_of_character .. '.offset.x', altOffsets[direction + 1][1]);
            setProperty(name_of_character .. '.offset.y', altOffsets[direction + 1][2]);
        elseif teamplay then
            doIdle = false;
            objectPlayAnimation(name_of_character, singAnims[direction + 1], true);
            setProperty(name_of_character .. '.offset.x', singOffsets[direction + 1][1]);
            setProperty(name_of_character .. '.offset.y', singOffsets[direction + 1][2]);
        end
    end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
    if playableCharacter then
        if noteType == charNote or noteType == charNote2 then
            doIdle = false;
            objectPlayAnimation(name_of_character, singAnims[direction + 1], true);
            setProperty(name_of_character .. '.offset.x', singOffsets[direction + 1][1]);
            setProperty(name_of_character .. '.offset.y', singOffsets[direction + 1][2]);
        elseif noteType == altCharNote or noteType == altCharNote2 then
            doIdle = false;
            objectPlayAnimation(name_of_character, altAnims[direction + 1], true);
            setProperty(name_of_character .. '.offset.x', altOffsets[direction + 1][1]);
            setProperty(name_of_character .. '.offset.y', altOffsets[direction + 1][2]);
        elseif teamplay then
            doIdle = false;
            objectPlayAnimation(name_of_character, singAnims[direction + 1], true);
            setProperty(name_of_character .. '.offset.x', singOffsets[direction + 1][1]);
            setProperty(name_of_character .. '.offset.y', singOffsets[direction + 1][2]);
        end
    end
end

function noteMiss(id, direction, noteType, isSustainNote)
    if playableCharacter then
        if getPropertyFromGroup(noteType, i, 'mustPress') then
            doIdle = false;
            objectPlayAnimation(name_of_character, missAnims[direction + 1], true);
            setProperty(name_of_character .. '.offset.x', missOffsets[direction + 1][1]);
            setProperty(name_of_character .. '.offset.y', missOffsets[direction + 1][2]);
        end
    end
end

function onBeatHit()
    if doIdle then
        idleDance(curBeat);
    end
    if seriouslyDontIdle then
        if getProperty(name_of_character .. '.animation.curAnim.finished') then
            doIdle = true;
            seriouslyDontIdle = false;
        end
    else
        doIdle = true;
    end
end

function idleDance(beat)
    if useIdle then
        if beat % 2 == 0 then
            objectPlayAnimation(name_of_character, 'idle', false);
            setProperty(name_of_character .. '.offset.x', idleOffsets[1]);
            setProperty(name_of_character .. '.offset.y', idleOffsets[2]);
        end
    else
        if beat % 2 == 0 then
            objectPlayAnimation(name_of_character, 'danceLeft', false);
            setProperty(name_of_character .. '.offset.x', idleOffsets[1]);
            setProperty(name_of_character .. '.offset.y', idleOffsets[2]);
        else
            objectPlayAnimation(name_of_character, 'danceRight', false);
            setProperty(name_of_character .. '.offset.x', idleOffsets[1]);
            setProperty(name_of_character .. '.offset.y', idleOffsets[2]);
        end
    end
end

steveBanned = true