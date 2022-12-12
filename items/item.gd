class_name Item
extends Resource

enum CanUseOn { SELF, ONE, ALL, ONE_FRIEND, ALL_FRIENDS, ONE_FOE, ALL_FOES }

@export var name := "Groove Potion"
@export var description := "Give 10 Vibe to an ally."

# items appear in the inventory,
# except the currently equipped instrument, who is in the play menu.
@export var is_instrument := false
@export var can_use_on: CanUseOn = CanUseOn.ONE_FRIEND
@export var effect: Callable = test_effect


func test_effect(ally: Character):
	ally.vibe += 10
