main :: () {
    InitWindow(800, 450, "raylib example");
    defer CloseWindow();

    showMessageBox := false;

    while !WindowShouldClose() {
        BeginDrawing();
        defer EndDrawing();

        ClearBackground(RAYWHITE);
        DrawText("raylib + jai", 190, 200, 20, LIGHTGRAY);

        if (GuiButton(Rectangle.{ 24, 24, 120, 30 }, "#191#Show Message")) showMessageBox = true;

        if (showMessageBox) {
            result := GuiMessageBox(Rectangle.{ 85, 70, 250, 100 },
                "#191#Message Box", "Hi! This is a message!", "Nice;Cool");

            if (result >= 0) showMessageBox = false;
        }
    }
}

#import "raylib";
