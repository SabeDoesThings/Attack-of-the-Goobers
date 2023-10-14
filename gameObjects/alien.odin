package gameObjects;

import fmt "core:fmt";
import math "core:math/linalg/hlsl";
import rl "vendor:raylib";
import rand "core:math/rand";

Alien :: struct {
    pos: math.float2,
    alive: bool,
}

alien: Alien;

alien_spr: rl.Texture2D;

load_alien :: proc(alien: ^Alien) {
    alien.alive = true;
    alien_spr = rl.LoadTexture("./res/alan/alan.png");
    alien_spr.width *= 3;
    alien_spr.height *= 3;
}

draw_alien :: proc(alien: ^Alien) {
    if alien.alive == true {
        rl.DrawTexture(
            alien_spr,
            i32(alien.pos.x) - alien_spr.width / 2,
            i32(alien.pos.y) - alien_spr.height / 2,
            rl.WHITE
        );

        // rl.DrawRectangleLines(
        //     i32(alien.pos.x) - alien_spr.width / 2,
        //     i32(alien.pos.y) - alien_spr.height / 2, 
        //     player_spr.width, 
        //     player_spr.height, 
        //     rl.RED
        // );
    }
}

update_alien :: proc(alien: ^Alien) {
    speed: f32 = 500;

    dt := rl.GetFrameTime();

    alien.pos.y += speed * dt;
}

reset_alien :: proc(alien: ^Alien) {
    if rl.IsKeyDown(rl.KeyboardKey.SPACE) {
        alien.alive = true;

        alien.pos = alien.pos;
    }
}