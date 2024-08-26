package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;
import shader.ImageLoopShader;
import flixel.util.FlxTimer;

using StringTools;

class EddMainMenuAgain extends MusicBeatState
{
    var bgImage:FlxSprite;
    var bgGraphic:FlxSprite;
    var bgColors:FlxSprite;
    var mainLogo:FlxSprite;

    var menuItems:FlxTypedGroup<FlxSprite>;

    var menuArray:Array<String> = [
        'storyMode',
        'freePlay',
        //'awards',
        'credits',
        'options',
    ];

    //var bgShader:ImageLoopShader = new ImageLoopShader();

    override function create() {
        
        bgImage = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
        bgImage.antialiasing = ClientPrefs.globalAntialiasing;
        add(bgImage);

        bgColors = new FlxSprite().loadGraphic(Paths.image('eddmainmenu/bgImage'));
        add(bgColors);
        bgColors.alpha = 0.95;

        bgGraphic = new FlxSprite().loadGraphic(Paths.image('eddmainmenu/bgGraphic'));
        bgGraphic.antialiasing = ClientPrefs.globalAntialiasing;
        FlxTween.tween(bgGraphic, {x: 350 - bgGraphic.width / 2}, 70, {type: FlxTween.LOOPING});
		FlxTween.tween(bgGraphic, {y: 350 - bgGraphic.height / 2}, 70, {type: FlxTween.LOOPING});
        //bgGraphic.shader = bgShader.shader;
        add(bgGraphic);

        mainLogo = new FlxSprite().loadGraphic(Paths.image('eddmainmenu/logo'));
        add(mainLogo);
        mainLogo.screenCenter(X);
        mainLogo.y = -1500;
        mainLogo.scale.x = 0.6;
        mainLogo.scale.y = 0.6;

        FlxTween.tween(mainLogo, {y: -200}, 1.6, {ease: FlxEase.quartOut});

        menuItems = new FlxTypedGroup<FlxSprite>();
        add(menuItems);

        for (i in 0 ... menuArray.length) {
            makeMenuItem(i);
        }

        FlxG.mouse.useSystemCursor = true;

        super.create();
    }

    function makeMenuItem(value:Int) {
        var item:FlxSprite = new FlxSprite(230, 0).loadGraphic(Paths.image('eddmainmenu/' + menuArray[value]));
        item.antialiasing = ClientPrefs.globalAntialiasing;
        menuItems.add(item);
        item.y = 1300;
        new FlxTimer().start(0.1 * value, function (timer:FlxTimer){
            FlxTween.tween(item, {y: (menuItems.members[0].height / 2) - (item.height / 2) + 3 + FlxG.height - 150}, 0.8, {ease: FlxEase.quartOut});
        });

        if (value == 0) return;
        item.x = menuItems.members[value - 1].x + menuItems.members[value - 1].width + 50;

    }

    function checkMenuItem() {
        var mousePosition:Array<Float> = [
            FlxG.mouse.screenX,
            FlxG.mouse.screenY
        ];

        for (i in 0 ... menuArray.length) {
            if (mousePosition[0] >= menuItems.members[i].x && mousePosition[0] <= menuItems.members[i].width + menuItems.members[i].x  &&  mousePosition[1] >= menuItems.members[i].y && mousePosition[1] <= menuItems.members[i].height + menuItems.members[i].y) {
                menuItems.members[i].loadGraphic(Paths.image('eddmainmenu/' + menuArray[i] + 'SELECT'));

                if (FlxG.mouse.justPressed) {
                    confirmMenu(i);
                }
            }
            else {
                menuItems.members[i].loadGraphic(Paths.image('eddmainmenu/' + menuArray[i]));
            }
        }
    }

    function confirmMenu(value:Int) {
        FlxG.sound.play(Paths.sound('confirmMenu'));

        FlxFlicker.flicker(menuItems.members[value], 1, 0.06, false, false, function(flick:FlxFlicker)
        {
            switch (menuArray[value])
            {
                case 'storyMode':
                    MusicBeatState.switchState(new StoryMenuState());
                case 'freePlay':
                    MusicBeatState.switchState(new FreeplayState());
                case 'credits':
                    MusicBeatState.switchState(new CreditsState());
                case 'options':
                    LoadingState.loadAndSwitchState(new options.OptionsState());
            }
        });
    }

    override function update(elapsed:Float) {
        //bgShader.iTime = Sys.cpuTime();

        checkMenuItem();

        if (FlxG.keys.justPressed.F2) {
            trace(FlxG.mouse.screenX + ' | ' + FlxG.mouse.screenY);
        }
        if (controls.BACK)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new TitleState());
		}

        super.update(elapsed);
    }
}