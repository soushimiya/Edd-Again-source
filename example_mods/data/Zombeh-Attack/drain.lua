dodrain = false
gfdrain = false
characterName = 'Zombeh Tord'

function opponentNoteHit()
    if dodrain and getProperty('health') > 0.1 then
        setProperty('health', getProperty('health') - 0.01)
    end
end

function onEvent(name, value1, value2)
    if name == 'Change Character' and value2 == characterName then
        dodrain = (value1 == 'dad' or value1 == '1') or (gfdrain and (value1 == 'gf' or value1 == '2'))
    end
end