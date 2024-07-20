using Godot;
using System;

public partial class Player : CharacterBody2D
{
<<<<<<< HEAD
		[Signal]
	public delegate void PotionThrowEventHandler(Vector2 Pos, Vector2 Dir, float Speed);
	

	float PlayerSpeed = 5000f;
=======
	float PlayerSpeed = 50000f;
>>>>>>> 71faee58549e88e48402fe296b381a53545e17f2
	bool IsWalking = false;

	bool CanThrow = true;
	float ThrowSpeed = 10000f;



	//Node references
	Timer ThrowCooldown;

	

	public override void _Ready()
	{
		ThrowCooldown = GetNode<Timer>("ThrowCooldown");
	}

    public override void _Process(double delta)
    {
        Vector2 inputDir = Input.GetVector("move_left", "move_right", "move_up", "move_down").Normalized();
		
		if (inputDir == Vector2.Zero)
		{
			IsWalking = false;
		}
		else
		{
			IsWalking = true;
		}
		Velocity = inputDir*PlayerSpeed*(float)delta;
		MoveAndSlide();

		if (CanThrow & Input.IsActionPressed("throw_potion"))
		{
			ThrowPotion();
		}
    }

	public void ThrowPotion()
	{
		CanThrow = false;
		GD.Print("Throw");
		ThrowCooldown.Start();
	}

	public void OnThrowCooldownTimeout()
	{
		CanThrow = true;
		GD.Print("Can Throw");
	}

}

