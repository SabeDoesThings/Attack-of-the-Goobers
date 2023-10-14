package gameObjects;

import fmt "core:fmt";
import math "core:math/linalg/hlsl";
import rl "vendor:raylib";

Player :: struct {
    pos: math.float2,
    alive: bool,
}

player: Player;

player_spr: rl.Texture2D;

window_dim := math.int2{800, 600};

load_player :: proc(player: ^Player) {
    player.alive = true;

    player_spr = rl.LoadTexture("./res/player/player_ship.png");
	player_spr.width *= 3;
	player_spr.height *= 3;
}

draw_player :: proc(player: ^Player) {
    if player.alive == true {
        rl.DrawTexture(
            player_spr, 
            i32(player.pos.x) - player_spr.width / 2, 
            i32(player.pos.y) - player_spr.height / 2, 
            rl.WHITE
        );

        // rl.DrawRectangleLines(
        //     i32(player.pos.x) - player_spr.width / 2, 
        //     i32(player.pos.y) - player_spr.height / 2, 
        //     player_spr.width, 
        //     player_spr.height, 
        //     rl.RED
        // );
    }

    if player.alive == false {
        rl.DrawText(
            "Press 'SPACE' to Reset", 
            window_dim.x / 3, 
            window_dim.y / 2, 
            20, 
            rl.WHITE
        );
    }
}

update_player :: proc(player: ^Player) {
    speed: f32 = 250;

    dt := rl.GetFrameTime();

    //movement
    if rl.IsKeyDown(rl.KeyboardKey.D) {
        player.pos.x += speed * dt;
    }
    if rl.IsKeyDown(rl.KeyboardKey.A) {
        player.pos.x -= speed * dt;
    }
    if rl.IsKeyDown(rl.KeyboardKey.W) {
        player.pos.y -= speed * dt;
    }
    if rl.IsKeyDown(rl.KeyboardKey.S) {
        player.pos.y += speed * dt;
    }

    //out of bounds
    if player.pos.x > f32(window_dim.x) {
        player.pos.x = 0;
    }
    if player.pos.y > f32(window_dim.x) {
        player.pos.y = 0;
    }
    if player.pos.x < 0 {
        player.pos.x = f32(window_dim.x);
    }
    if player.pos.y < 0 {
        player.pos.y = f32(window_dim.y);
    }
}

reset_player :: proc(player: ^Player) {
    if rl.IsKeyDown(rl.KeyboardKey.SPACE) {
        player.alive = true;

        player.pos = {f32(window_dim.x / 2), f32(window_dim.y / 2)};
    }
}
