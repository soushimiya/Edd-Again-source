value = {30, 30, 10} -- bf, opponent, gf
function onStartCountdown()
    y = {getProperty('boyfriend.y'), getProperty('dad.y'), getProperty('gf.y')}
end

function onBeatHit()
    --debugPrint(y)
    setProperty('boyfriend.y', y[1] + value[1])
    doTweenY('BF Tween', 'boyfriend', y[1] - value[1], getPropertyFromClass('Conductor', 'bpm') / 180 / 2,'quartOut')
    setProperty('dad.y', y[2] + value[2])
    doTweenY('DAD Tween', 'dad', y[2] - value[2], getPropertyFromClass('Conductor', 'bpm') / 180 / 2,'quartOut')
    setProperty('gf.y', y[3] + value[2])
    doTweenY('GF Tween', 'gf', y[3] - value[2], getPropertyFromClass('Conductor', 'bpm') / 180 / 2,'quartOut')
end