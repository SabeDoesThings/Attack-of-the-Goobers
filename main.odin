package src;

import fmt "core:fmt";
import math "core:math/linalg/hlsl";
import linalg "core:math/linalg";
import rl "vendor:raylib";
import go "./gameObjects";
import rand "core:math/rand";

player: go.Player;
player_radius: i32 = 16;

bg: go.Background;

alien: go.Alien;
alien_radius: i32 = 16;

score := 0;

window_dim := math.int2{800, 600};

main :: proc() {
	rl.InitWindow(window_dim.x, window_dim.y, "AsteroidAvoider");
	rl.SetTargetFPS(150);

	bg.pos = {f32(window_dim.x), f32(window_dim.y)};
	player.pos = {f32(window_dim.x / 2), f32(window_dim.y / 2)};
	alien.pos = {rand.float32_range(0, 600), 0};

	is_running := true;

	load();

	for is_running && !rl.WindowShouldClose() {
		update();

		draw();
	}
}

load :: proc() {
	go.load_bg(&bg);
	go.load_player(&player);
	go.load_alien(&alien);
}

update :: proc() {
	go.update_player(&player);
	go.update_alien(&alien);

	respawn_alien();
	player_alien_collision();
	if rl.IsKeyDown(rl.KeyboardKey.SPACE) {
        reset_game();
    }
}

draw :: proc() {
	rl.BeginDrawing();
		rl.ClearBackground(rl.GRAY);
		go.draw_bg(&bg);
		go.draw_player(&player);
		go.draw_alien(&alien);
		rl.DrawText(
            fmt.caprintf("Score: %i", score), 
            window_dim.x / 2, 
            window_dim.y / 5, 
            20, 
            rl.WHITE
        );
	rl.EndDrawing();
}

player_alien_collision :: proc() {
	distance := linalg.length(player.pos - alien.pos)

	if distance < f32(player_radius) + f32(alien_radius) {
    	player.alive = false;
		alien.alive = false;
	}
}

respawn_alien :: proc() {
	if alien.alive == false {
		return;
	}

	if alien.pos.y > f32(window_dim.y) {
		alien.alive = false;
	}

	if alien.pos.y > f32(window_dim.y) {
		alien.alive = true;

		alien.pos.y = 0;
		alien.pos.x = rand.float32_range(100, 500);

		score += 1;
	}
}

reset_game :: proc() {
	go.reset_player(&player);
	go.reset_alien(&alien);
	score = 0;
}