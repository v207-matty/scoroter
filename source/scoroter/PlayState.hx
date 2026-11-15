package scoroter;

import flixel.math.FlxMath;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var endless:Bool = true;

	var player:FlxSprite;

	var healthBar:FlxBar;

	var health = 0;
	var healthLerp = 0.0;
	var maxHealth = 3;

	override function create()
	{
		super.create();

		health = maxHealth;

		add(player = new FlxSprite().makeGraphic(16, 16, FlxColor.BLUE));
		player.screenCenter(Y);
		player.x = player.width;

		add(healthBar = new FlxBar(0, 0, LEFT_TO_RIGHT, FlxG.width, 16, this, 'health', 0, maxHealth));
		healthBar.createFilledBar(FlxColor.RED, FlxColor.LIME);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.anyPressed([W, UP]))
			move(-1);

		if (FlxG.keys.anyPressed([S, DOWN]))
			move(1);
	}

	function move(multiplier:Float)
	{
		player.y += player.height * multiplier;

		final padding = player.height * 2;

		if (player.y < padding)
			player.y = padding;
		if (player.y > FlxG.height - padding)
			player.y = FlxG.height - padding;
	}
}
