local onGF = false; --ayo

function onEvent(n,v1)
    if n == 'plr3PlayAnim' then
        runHaxeCode([[
            dad2.playAnim(']]..v1..[[', true);
        ]]);
    end  
end