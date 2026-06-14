main :: () {
    InitWindow(800, 450, "photo cool");
    defer CloseWindow();

    SetWindowState(.FLAG_WINDOW_RESIZABLE);

    image := LoadImage("photo.png");
    texture := LoadTextureFromImage(image);

    scale := 0.3;

    while !WindowShouldClose() {
        wheel := GetMouseWheelMove();
        scale += (wheel/10);
        if (scale < 0) scale = 0;

        BeginDrawing();
        defer EndDrawing();

        ClearBackground(RAYWHITE);

        wi := GetRenderWidth();
        hi := GetRenderHeight();

        pos := Vector2.{xx wi, xx hi} / 2;
        pos = pos - Vector2.{xx texture.width, xx texture.height} * scale / 2;

        DrawTextureEx(texture, pos, rotation=0, scale, WHITE);
    }
}

#import "raylib";
#import "Math";
#import "Basic";
