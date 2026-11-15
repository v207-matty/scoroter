package scoroter;

import flixel.text.FlxText;

class GameOverState extends FlxState
{
	override function create()
	{
		super.create();

		var mocking = new FlxText(0, 0, 0, 'You have died!\n\nPress ANY to try again!', 16);
		add(mocking);

		mocking.alignment = CENTER;
		mocking.screenCenter();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justReleased.ANY)
			FlxG.switchState(() -> new PlayState());
	}
}
