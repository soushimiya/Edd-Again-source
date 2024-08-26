charactername = 'Tom-2004'
function onCreatePost()
    
    runHaxeCode([[
        game.dadGroup.y += 40;

        dad2 = new Character(game.dadGroup.x + 175, game.dadGroup.y, ']]..charactername..[[');
		dad2.scrollFactor.set(0.97, 0.97);
		dad2.y += dad2.positionArray[1] - 0;
		game.addBehindDad(dad2);
    ]])
end

function onCountdownTick(counter)
	runHaxeCode([[
		if (]]..counter..[[ % dad2.danceEveryNumBeats == 0 && dad2.animation.curAnim != null && !StringTools.startsWith(dad2.animation.curAnim.name, 'sing') && !dad2.stunned)
		{
			dad2.dance();
		}
	]]);
end

function onBeatHit()
	runHaxeCode([[
		if (]]..curBeat..[[ % dad2.danceEveryNumBeats == 0 && dad2.animation.curAnim != null && !StringTools.startsWith(dad2.animation.curAnim.name, 'sing') && !dad2.stunned)
		{
			dad2.dance();
		}
	]]);
end

function onUpdate(elapsed)
	runHaxeCode([[
		if (game.startedCountdown && game.generatedMusic)
		{
			if (!dad2.stunned && dad2.holdTimer > Conductor.stepCrochet * 0.0011 * dad2.singDuration && StringTools.startsWith(dad2.animation.curAnim.name, 'sing') && !StringTools.endsWith(dad2.animation.curAnim.name, 'miss'))
			{
				dad2.dance();
			}
		}
	]]);
end

function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if noteType == 'Player3 Sing' then
        runHaxeCode([[
            dad2.playAnim(game.singAnimations[]]..noteData..[[], true);
            dad2.holdTimer = 0;
        ]]);
    end
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if noteType == 'Player3 Sing' then
        runHaxeCode([[
            dad2.playAnim(game.singAnimations[]]..noteData..[[], true);
            dad2.holdTimer = 0;
        ]]);
    end
end