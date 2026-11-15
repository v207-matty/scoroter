package scoroter;

import flixel.group.FlxSpriteContainer;
import flixel.math.FlxMath;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var endless:Bool = true;

	var player:FlxSprite;

	var playerSpeedMultiplier = 0.25;

	var enemies:FlxSpriteContainer;

	var enemyChance = 10;
	var maxEnemies = 5;
	var enemySpeedMultiplier = 0.5;
	var enemyTickModulo = 5;

	var healthBar:FlxBar;

	var health = 0;
	var healthLerp = 0.0;
	var maxHealth = 3;

	var tick = 0;

	override function create()
	{
		super.create();

		health = maxHealth;

		add(player = new FlxSprite().makeGraphic(16, 16, FlxColor.BLUE));
		player.screenCenter(Y);
		player.x = player.width;

		add(enemies = new FlxSpriteContainer());

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

		if (FlxG.random.bool(enemyChance) && tick % enemyTickModulo == 0 && enemies.members.length < maxEnemies)
			enemies.add(new FlxSprite(FlxG.width + 32, player.y).makeGraphic(16, 16, FlxColor.RED));

		for (enemy in enemies)
			enemyUpdate(enemy);

		tick++;
	}

	function move(multiplier:Float)
	{
		player.y += (player.height * playerSpeedMultiplier) * multiplier;

		final padding = player.height * 2;

		if (player.y < padding)
			player.y = padding;
		if (player.y > FlxG.height - padding)
			player.y = FlxG.height - padding;
	}

	function enemyUpdate(enemy:FlxSprite)
	{
		enemy.x -= enemy.width * enemySpeedMultiplier;

		final touchingPlayer = enemy.overlaps(player);
		final outOfBounds = enemy.x < -(enemy.width * 2);

		if (!touchingPlayer && !outOfBounds)
			return;

		enemies.members.remove(enemy);

		if (touchingPlayer)
		{
			health--;

			if (health <= 0)
				FlxG.switchState(() -> new GameOverState());
		}

		enemy.destroy();
		enemy = null;
	}
}
