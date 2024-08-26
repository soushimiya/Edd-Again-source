speed = 2.2
function onCreate()
makeLuaSprite('bg1', 'scrollbg', -400, startY)
addLuaSprite('bg1', false)
makeLuaSprite('bg2', 'scrollbg', -400 + 2974, startY)
addLuaSprite('bg2', false)
doTweenX('bg1move','bg1', -400 - 2974, speed)
doTweenX('bg2move','bg2', -400, speed)
end



function onTweenCompleted(tag)
    if tag == ('bg2move') then
        doTweenX('bg1move2','bg1', -400, 0.001)
        doTweenX('bg2move2','bg2', -400 + 2974, 0.001)
    end
    if tag == 'bg2move2' then
        doTweenX('bg1move','bg1', -400 - 2974, speed)
        doTweenX('bg2move','bg2', -400, speed)
    end
end