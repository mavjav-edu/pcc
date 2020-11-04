
TRY IT YOURSELF
---------------

<a id="#ch14exe1"></a>**14-1. Press P to Play:** Because Alien Invasion uses
keyboard input to control the ship, it's best to start the game with a
keypress. Add code that lets the player press P to start. It may help to
move some code from `check_play_button()` to a
`start_game()` function that can be called from both
`check_play_button()` and `check_keydown_events()`.

<a id="#ch14exe2"></a>**14-2. Target Practice:** Create a rectangle at the right
edge of the screen that moves up and down at a steady rate. Then have a
ship appear on the left side of the screen that the player can move up
and down while firing bullets at the moving, rectangular target. Add a
Play button that starts the game, and when the player misses the target
three times, end the game and make the Play button reappear. Let the
player restart the game with this Play button.
