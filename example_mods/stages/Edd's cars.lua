function onCreate()
 makeLuaSprite('car', 'car', -250, -100);
 scaleObject('car', 1, 1);

 makeLuaSprite('ccar', 'ccar', -250, -100);
 scaleObject('ccar', 1, 1);

 makeLuaSprite('cccar', 'cccar', -250, -100);
 scaleObject('cccar', 1, 1);

 makeLuaSprite('ccccar', 'ccccar', -250, -100);
 scaleObject('ccccar', 1, 1);

 makeLuaSprite('front', 'front', -250, -100);
 scaleObject('front', 1, 1);


 addLuaSprite('car', false);
 addLuaSprite('ccar', false);
 addLuaSprite('cccar', false);
 addLuaSprite('ccccar', true);
 addLuaSprite('front', true);

end