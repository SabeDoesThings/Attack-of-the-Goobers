package gameObjects;

import fmt "core:fmt";
import math "core:math/linalg/hlsl";
import rl "vendor:raylib";

Background :: struct {
    pos: math.float2,
}

bg: Background;

bg_spr: rl.Texture2D;

load_bg :: proc(bg: ^Background) {
    bg_spr = rl.LoadTexture("./res/bg/space_bg.png");
    bg_spr.width *= 7;
	bg_spr.height *= 10;
}

draw_bg :: proc(bg: ^Background) {
    rl.DrawTexture(bg_spr, i32(bg.pos.x) - bg_spr.width, i32(bg.pos.y) - bg_spr.height, rl.WHITE);
}