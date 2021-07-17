//gimme your guts
/obj/item/clothing/suit/space/repo
	name = "leather overcoat"
	desc = "Dark and mysterious..."
	icon_state = "repo"
	item_state = "repo"
	icon = 'icons/obj/clothing/overcoats/item_suit_hazard.dmi'
	wear_image_icon = 'icons/mob/overcoats/worn_suit_hazard.dmi'
	item_function_flags = IMMUNE_TO_ACID
	contraband = 3
	body_parts_covered = TORSO|LEGS|ARMS
	wear_layer = MOB_OVERLAY_BASE

	setupProperties()
		..()
		setProperty("space_movespeed", 0)
		setProperty("exploprot", 20)
		setProperty("meleeprot", 4)
		setProperty("rangedprot", 1.5)
		setProperty("disorient_resist", 65)

/obj/item/clothing/head/helmet/space/repo
	name = "ominous helmet"
	desc = "How is the visor glowing like that?"
	icon_state = "repo"
	item_state = "repo"
	icon = 'icons/obj/clothing/item_hats.dmi'
	wear_image_icon = 'icons/mob/head.dmi'
	item_function_flags = IMMUNE_TO_ACID
	color_r = 0.7
	color_g = 0.7
	color_b = 0.9

	equipped(mob/user)
		. = ..()
		APPLY_MOB_PROPERTY(user, PROP_THERMALSIGHT_MK2, src)

	unequipped(mob/user)
		REMOVE_MOB_PROPERTY(user, PROP_THERMALSIGHT_MK2, src)
		. = ..()

/mob/living/carbon/human/repo
	gender = "female"
	New()
		..()

		real_name = "Organ Repossession Agent"

		src.equip_new_if_possible(/obj/item/clothing/under/misc/syndicate, slot_w_uniform)
		src.equip_new_if_possible(/obj/item/clothing/suit/space/repo, slot_wear_suit)
		src.equip_new_if_possible(/obj/item/clothing/shoes/swat, slot_shoes)
		src.equip_new_if_possible(/obj/item/clothing/head/helmet/space/repo, slot_head)
		src.equip_new_if_possible(/obj/item/device/radio/headset, slot_ears)
		src.equip_new_if_possible(/obj/item/clothing/mask/gas/voice, slot_wear_mask)
		src.equip_new_if_possible(/obj/item/card/id/syndicate, slot_wear_id)
		src.equip_new_if_possible(/obj/item/storage/belt/security, slot_belt)
		src.equip_new_if_possible(/obj/item/tank/emergency_oxygen, slot_r_store)

	initializeBioholder()
		. = ..()
		bioHolder.age = 25
		bioHolder.bloodType = "O-"
		bioHolder.mobAppearance.customization_first = new /datum/customization_style/hair/short/floof
		bioHolder.mobAppearance.customization_first_color = "#9b6927"

// pew pew
/obj/item/implant/projectile/bullet_flechette
	name = "flechette"
	desc = "A small, nasty-looking steel dart designed to pierce through armor and space suits."

/obj/item/casing/polymer
	icon_state = "polymer"
	desc = "An odd plastic casing, entirely hollow and slightly melted."
	New()
		..()
		SPAWN_DBG(rand(1, 3))
			playsound(src.loc, "sound/weapons/casings/casing-shell-0[rand(1,7)].ogg", 15, 0.1, 0, 0.7)

obj/item/ammo/bullets/flechette_mag
	sname = "5x40mm SCF" // note this is the whole telescoped cartridge size, SCF: synthetic case flechette
	name = "Flechette magazine"
	ammo_type = new/datum/projectile/bullet/flechette
	icon_state = "flech_mag"
	amount_left = 24.0
	max_amount = 24.0
	caliber = 0.065 // the actual diameter of the flechette once free of the sabot
	sound_load = 'sound/weapons/gunload_hitek.ogg'

/datum/projectile/bullet/flechette
	name = "flechette"
	shot_sound = 'sound/weapons/fleshot.ogg'
	shot_volume = 70
	power = 12
	cost = 2
	ks_ratio = 1.0
	hit_ground_chance = 100
	damage_type = D_PIERCING
	hit_type = DAMAGE_STAB
	shot_number = 2
	shot_delay = 0.7
	caliber = 0.065
	dissipation_delay = 11
	dissipation_rate = 3
	icon_turf_hit = "bhole-small"
	implanted = /obj/item/implant/projectile/bullet_flechette
	casing = /obj/item/casing/polymer

/obj/item/gun/kinetic/flechette_rifle
	name = "Sylkyri flechette rifle"
	desc = "A bullpup assault rifle chambered in a proprietary flechette cartridge. Issued to Syndicate counter-boarding teams and outpost security."
	icon = 'icons/obj/large/48x32.dmi'
	icon_state = "flech"
	item_state = "assault_rifle"
	has_empty_state = 1
	uses_multiple_icon_states = 1
	force = MELEE_DMG_RIFLE
	contraband = 8
	caliber = 0.065 // this is the flechette diameter, which is telescoped in a polymer case.
	max_ammo_capacity = 24
	can_dual_wield = 0
	two_handed = 1
	auto_eject = 1
	flags =  FPRINT | TABLEPASS | CONDUCT | USEDELAY | EXTRADELAY | ONBACK
	object_flags = NO_ARM_ATTACH
	c_flags = NOT_EQUIPPED_WHEN_WORN | EQUIPPED_WHILE_HELD
	w_class = W_CLASS_BULKY
	spread_angle = 3

	New()
		ammo = new/obj/item/ammo/bullets/flechette_mag
		set_current_projectile(new/datum/projectile/bullet/flechette)
		..()