;; Source-derived Vibesteroids mechanics expressed through the public guest ABI.

(assert_return (invoke $vibesteroids_tests "seeded_fields_differ") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "initial_asteroid_ranges_valid") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "initial_asteroid_velocities_valid") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "resize_invariants") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "explosion_advances_at_tick_rate") (i32.const 1))

;; Initial state and pool layout.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 72)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 76)) (i32.const 3))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 80)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 96)) (i32.const 30000))
(assert_return (invoke $vibesteroids_tests "active_count" (i32.const 3328) (i32.const 80) (i32.const 32)) (i32.const 5))

;; Free ships begin at 30,000; each later gap grows by exactly 1.5x while a
;; scoring event crossing a threshold still awards at most one reserve.
(assert_return (invoke $vibesteroids_tests "hit_terminal_asteroid_at_score" (i32.const 29900)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 72)) (i32.const 30020))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 76)) (i32.const 4))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 96)) (i32.const 75000))
(assert_return (invoke $vibesteroids_tests "hit_terminal_asteroid_at_score" (i32.const 74900)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 76)) (i32.const 5))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 96)) (i32.const 142500))
(assert_return (invoke $vibesteroids_tests "hit_terminal_asteroid_at_score" (i32.const 142400)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 76)) (i32.const 6))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 96)) (i32.const 243750))

;; Three reserves remain icon-only; four reserves become three icons plus the
;; numeric reserve total in the former fourth-icon position.
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 76) (i32.const 4)))
(assert_return (invoke $vibesteroids_tests "host_reset_frame"))
(assert_return (invoke $vibesteroids_tests "render") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_reserve_paths") (i32.const 3))
(assert_return (invoke $vibesteroids_tests "host_reserve_count_text_valid") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 76) (i32.const 5)))
(assert_return (invoke $vibesteroids_tests "host_reset_frame"))
(assert_return (invoke $vibesteroids_tests "render") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_reserve_paths") (i32.const 3))
(assert_return (invoke $vibesteroids_tests "host_reserve_count_text_valid") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "data_u8" (i32.const 549)) (i32.const 0x34))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 76) (i32.const 13)))
(assert_return (invoke $vibesteroids_tests "host_reset_frame"))
(assert_return (invoke $vibesteroids_tests "render") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_reserve_paths") (i32.const 3))
(assert_return (invoke $vibesteroids_tests "host_reserve_count_text_valid") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "data_u16" (i32.const 548)) (i32.const 0x3231))

;; Auto-fire is a latched toggle; releasing the key does not cancel it.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 7)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 2) (i32.const 7)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 24)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "active_count" (i32.const 256) (i32.const 48) (i32.const 64)) (i32.const 2))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 7)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 10)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "active_count" (i32.const 256) (i32.const 48) (i32.const 64)) (i32.const 2))

;; Held fire repeats at the ordinary cadence and each shot is drawn. Projectiles
;; carry no countdown any more, so the record's former lifetime slot stays zero;
;; expiry is proved separately against the viewport edge.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 4)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 45)) (i32.const 0))
;; At least three; a Boolean helper is unnecessary because the exact source cadence yields three.
(assert_return (invoke $vibesteroids_tests "active_count" (i32.const 256) (i32.const 48) (i32.const 64)) (i32.const 3))
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_reset_effects"))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 4)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 296)) (i64.const 0))
(assert_return (invoke $vibesteroids_tests "host_audio_seen" (i32.const 1)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_reset_frame"))
(assert_return (invoke $vibesteroids_tests "render") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_bullet_circles") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 2) (i32.const 4)) (i32.const 0))
;; Still airborne well past the distance the old countdown allowed, then gone by
;; leaving the viewport. The exact edge tick is pinned separately by a
;; hand-placed projectile, so this fixture asserts the shape rather than a
;; boundary that would move with the ship's muzzle offset.
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 30)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 256)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 200)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 256)) (i32.const 0))

;; Emptying the rock pool advances the wave and spawns one additional parent.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "clear_active" (i32.const 3328) (i32.const 80) (i32.const 32)))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 80)) (i32.const 2))
(assert_return (invoke $vibesteroids_tests "active_count" (i32.const 3328) (i32.const 80) (i32.const 32)) (i32.const 6))
(assert_return (invoke $vibesteroids_tests "clear_active" (i32.const 3328) (i32.const 80) (i32.const 32)))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 80)) (i32.const 3))
(assert_return (invoke $vibesteroids_tests "active_count" (i32.const 3328) (i32.const 80) (i32.const 32)) (i32.const 7))

;; Level endpoints jointly scale thrust, turn, bullet speed, and fire cadence.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 80) (i32.const 1)))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 3)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 48)) (i64.const -4981265))
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 80) (i32.const 1)))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 2)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 56)) (i64.const 83234))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 64)) (i64.const -996529))

;; Held thrust emits one bounded rumble request per nominal four 60-Hz ticks;
;; releasing the control stops new requests immediately.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 0)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_reset_effects"))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 3)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 3)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 0)) (i32.const 6))
(assert_return (invoke $vibesteroids_tests "host_audio_count" (i32.const 4)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_audio_count" (i32.const 4)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_thrust_audio_valid") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 3)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_audio_count" (i32.const 4)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_audio_count" (i32.const 4)) (i32.const 2))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 2) (i32.const 3)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 4)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_audio_count" (i32.const 4)) (i32.const 2))

;; Entering Pause clears held controls, and no gameplay input may animate a
;; flame or mutate player modes behind the modal overlay.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 3)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 4)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 5)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 4)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_reset_frame"))
(assert_return (invoke $vibesteroids_tests "render") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_flame_min_x") (f32.const 0))
;; Gameplay inputs are a rejected set while paused.
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 3)) (i32.const 0))
(assert_return
	(invoke $vibesteroids_tests "pointer_event"
		(i32.const 4) (i32.const 2) (f32.const 512) (f32.const 384))
	(i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 7)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 8)) (i32.const 0))
(assert_return
	(invoke $vibesteroids_tests "pointer_event"
		(i32.const 3) (i32.const 0) (f32.const 700) (f32.const 500))
	(i32.const 0))
(assert_return
	(invoke $vibesteroids_tests "pointer_event"
		(i32.const 10) (i32.const 1) (f32.const 0) (f32.const -1))
	(i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 4)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 32)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 64)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 128)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 256)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 15560)) (i32.const 0))
;; Native commands and resize remain an accepted set while paused.
(assert_return (invoke $vibesteroids_tests "event" (i32.const 7) (i32.const 7)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 512)) (i32.const 1))
(assert_return
	(invoke $vibesteroids_tests "viewport" (f32.const 900) (f32.const 700))
	(i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 8)) (i64.const 900000000))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 7) (i32.const 7)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 5)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 16)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 3)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 4)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_reset_frame"))
(assert_return (invoke $vibesteroids_tests "render") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_flame_min_x") (f32.const -12))

;; Pointer aim uses the same bounded rotation step, then snaps exactly rather
;; than overshooting the target direction on the final tick.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return
	(invoke $vibesteroids_tests "pointer_event"
		(i32.const 3) (i32.const 0) (f32.const 612) (f32.const 384))
	(i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 15560)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 56)) (i64.const 83234))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 64)) (i64.const -996529))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 18)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 56)) (i64.const 1000000))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 64)) (i64.const 0))

;; Primary click holds fire, secondary click holds thrust, and keyboard turning
;; explicitly takes heading authority until the pointer next moves.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return
	(invoke $vibesteroids_tests "pointer_event"
		(i32.const 4) (i32.const 1) (f32.const 612) (f32.const 384))
	(i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 8)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "active_count" (i32.const 256) (i32.const 48) (i32.const 64)) (i32.const 1))
;; Holding primary fire repeats at the player's ordinary bounded cadence.
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 16)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "active_count" (i32.const 256) (i32.const 48) (i32.const 64)) (i32.const 2))
(assert_return
	(invoke $vibesteroids_tests "pointer_event"
		(i32.const 5) (i32.const 1) (f32.const 612) (f32.const 384))
	(i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 8)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 16)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "active_count" (i32.const 256) (i32.const 48) (i32.const 64)) (i32.const 2))
(assert_return
	(invoke $vibesteroids_tests "pointer_event"
		(i32.const 4) (i32.const 2) (f32.const 612) (f32.const 384))
	(i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 4)) (i32.const 1))
(assert_return
	(invoke $vibesteroids_tests "pointer_event"
		(i32.const 5) (i32.const 2) (f32.const 612) (f32.const 384))
	(i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 4)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 15560)) (i32.const 0))

;; Each physical source owns its held action independently: releasing Up must
;; not cancel thrust while the secondary pointer button remains held.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 3)) (i32.const 0))
(assert_return
	(invoke $vibesteroids_tests "pointer_event"
		(i32.const 4) (i32.const 2) (f32.const 612) (f32.const 384))
	(i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 2) (i32.const 3)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 4)) (i32.const 1))
(assert_return
	(invoke $vibesteroids_tests "pointer_event"
		(i32.const 5) (i32.const 2) (f32.const 612) (f32.const 384))
	(i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 4)) (i32.const 0))

;; Touch contacts own their starting zones independently. An edge contact fires
;; while a concurrent middle contact thrusts; terminating either one cannot
;; release the other's action.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return
	(invoke $vibesteroids_tests "touch_event"
		(i32.const 11) (i32.const 41) (f32.const 100) (f32.const 384))
	(i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 8)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 4)) (i32.const 0))
(assert_return
	(invoke $vibesteroids_tests "touch_event"
		(i32.const 11) (i32.const 42) (f32.const 512) (f32.const 384))
	(i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 12)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "active_count" (i32.const 256) (i32.const 48) (i32.const 64)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "state_i64_negative" (i32.const 48)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 16)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "active_count" (i32.const 256) (i32.const 48) (i32.const 64)) (i32.const 2))
(assert_return
	(invoke $vibesteroids_tests "touch_event"
		(i32.const 13) (i32.const 41) (f32.const 100) (f32.const 384))
	(i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 8)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 4)) (i32.const 1))
(assert_return
	(invoke $vibesteroids_tests "touch_event"
		(i32.const 14) (i32.const 42) (f32.const 512) (f32.const 384))
	(i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 12)) (i32.const 0))

;; Multiple contacts may own one action. Release/cancel removes one owner at a
;; time, and an unknown terminal ID cannot disturb any live owner.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 11) (i32.const 1) (f32.const 400) (f32.const 400)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 11) (i32.const 2) (f32.const 600) (f32.const 400)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 13) (i32.const 999) (f32.const 0) (f32.const 0)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 13) (i32.const 1) (f32.const 400) (f32.const 400)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 4)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 14) (i32.const 2) (f32.const 600) (f32.const 400)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 4)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 11) (i32.const 3) (f32.const 100) (f32.const 400)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 11) (i32.const 4) (f32.const 924) (f32.const 400)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 13) (i32.const 3) (f32.const 100) (f32.const 400)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 8)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 14) (i32.const 4) (f32.const 924) (f32.const 400)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 8)) (i32.const 0))

;; A duplicate active ID cannot jump zones, while a terminal edge makes that ID
;; reusable for a later independent contact.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 11) (i32.const 7) (f32.const 100) (f32.const 300)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 11) (i32.const 7) (f32.const 512) (f32.const 300)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 8)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 4)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 13) (i32.const 7) (f32.const 100) (f32.const 300)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 11) (i32.const 7) (f32.const 512) (f32.const 300)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 8)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 4)) (i32.const 1))

;; Left and right edge strokes map a one-eighth-height upward drag to opposite
;; quarter-turn headings. Unknown moves are inert, and a full-height stroke
;; spans two complete rotations back to the starting heading.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 11) (i32.const 10) (f32.const 100) (f32.const 384)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 12) (i32.const 404) (f32.const 100) (f32.const 288)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 56)) (i64.const 0))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 64)) (i64.const -1000000))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 12) (i32.const 10) (f32.const 100) (f32.const 288)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i64_between" (i32.const 56) (i64.const 990000) (i64.const 1002000)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "state_i64_between" (i32.const 64) (i64.const -10) (i64.const 10)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 13) (i32.const 10) (f32.const 100) (f32.const 288)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 11) (i32.const 11) (f32.const 924) (f32.const 384)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 12) (i32.const 11) (f32.const 924) (f32.const 288)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i64_between" (i32.const 56) (i64.const -1002000) (i64.const -990000)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "state_i64_between" (i32.const 64) (i64.const -10000) (i64.const 10000)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 13) (i32.const 11) (f32.const 924) (f32.const 288)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 11) (i32.const 12) (f32.const 100) (f32.const 0)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 12) (i32.const 12) (f32.const 100) (f32.const 768)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i64_between" (i32.const 56) (i64.const -10000) (i64.const 10000)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "state_i64_between" (i32.const 64) (i64.const -1000000) (i64.const -990000)) (i32.const 1))

;; Contact storage has an explicit eight-record bound. A ninth start is inert
;; rather than stealing an active record, and a terminal edge frees capacity.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 11) (i32.const 100) (f32.const 512) (f32.const 300)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 11) (i32.const 101) (f32.const 512) (f32.const 300)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 11) (i32.const 102) (f32.const 512) (f32.const 300)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 11) (i32.const 103) (f32.const 512) (f32.const 300)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 11) (i32.const 104) (f32.const 512) (f32.const 300)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 11) (i32.const 105) (f32.const 512) (f32.const 300)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 11) (i32.const 106) (f32.const 512) (f32.const 300)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 11) (i32.const 107) (f32.const 512) (f32.const 300)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 11) (i32.const 108) (f32.const 100) (f32.const 300)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 8)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 13) (i32.const 100) (f32.const 512) (f32.const 300)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 11) (i32.const 108) (f32.const 100) (f32.const 300)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 8)) (i32.const 1))

;; Death Blossom owns heading while active. Edge contact motion remains inert
;; until the special attack releases heading authority.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 11) (i32.const 120) (f32.const 100) (f32.const 384)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 9)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 12) (i32.const 120) (f32.const 100) (f32.const 288)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 56)) (i64.const 0))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 64)) (i64.const -1000000))

;; Touch is one concurrent input family. Releasing its owner must preserve a
;; still-held keyboard fire edge, and focus loss or reload clears every contact.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 4)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 11) (i32.const 20) (f32.const 100) (f32.const 384)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 13) (i32.const 20) (f32.const 100) (f32.const 384)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 8)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 2) (i32.const 4)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 11) (i32.const 21) (f32.const 100) (f32.const 384)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 11) (i32.const 22) (f32.const 512) (f32.const 384)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 8) (i32.const 0)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 12)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 11) (i32.const 23) (f32.const 100) (f32.const 384)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 11) (i32.const 24) (f32.const 512) (f32.const 384)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "after_restore") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 12)) (i32.const 0))

;; The original top-center zone remains a pause toggle. Entering Pause clears
;; every live contact, ordinary touches are inert behind it, and only another
;; top-center start resumes without arming thrust or fire.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 11) (i32.const 30) (f32.const 100) (f32.const 384)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 11) (i32.const 31) (f32.const 512) (f32.const 384)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 11) (i32.const 32) (f32.const 512) (f32.const 50)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 16)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 12)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 11) (i32.const 33) (f32.const 512) (f32.const 384)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 20)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "touch_event" (i32.const 11) (i32.const 34) (f32.const 512) (f32.const 50)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 28)) (i32.const 0))

;; W (13) exactly aliases Up thrust on both edges.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 13)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 4)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 2) (i32.const 13)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 4)) (i32.const 0))

;; Up, W, and the secondary pointer are three independent thrust sources, so
;; thrust survives every release until the last held source lets go.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 3)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 13)) (i32.const 0))
(assert_return
	(invoke $vibesteroids_tests "pointer_event"
		(i32.const 4) (i32.const 2) (f32.const 612) (f32.const 384))
	(i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 2) (i32.const 3)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 4)) (i32.const 1))
(assert_return
	(invoke $vibesteroids_tests "pointer_event"
		(i32.const 5) (i32.const 2) (f32.const 612) (f32.const 384))
	(i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 4)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 2) (i32.const 13)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 4)) (i32.const 0))

;; A (14) and D (15) alias Left and Right and take heading authority from aim.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return
	(invoke $vibesteroids_tests "pointer_event"
		(i32.const 3) (i32.const 0) (f32.const 612) (f32.const 384))
	(i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 15560)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 14)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 1)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 15560)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 2) (i32.const 14)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 1)) (i32.const 0))
(assert_return
	(invoke $vibesteroids_tests "pointer_event"
		(i32.const 3) (i32.const 0) (f32.const 612) (f32.const 384))
	(i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 15560)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 15)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 2)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 15560)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 2) (i32.const 15)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 2)) (i32.const 0))

;; Arrow and letter rotation aliases own their direction independently, so
;; releasing one must not cancel rotation the other still holds.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 14)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 2) (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 1)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 2) (i32.const 14)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 2)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 15)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 2) (i32.const 15)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 2)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 2) (i32.const 2)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 2)) (i32.const 0))

;; Focus loss clears every transient letter source without stranding it: a
;; later arrow release must not resurrect an action. The first later letter
;; press dismisses Resume and is consumed; its next press takes effect.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 3)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 13)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 14)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 15)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 8) (i32.const 0)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 7)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 2) (i32.const 3)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 2) (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 7)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 13)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 4)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 13)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 4)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 2) (i32.const 13)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 4)) (i32.const 0))

;; Entering Pause releases held letter aliases too, so resuming and releasing
;; the arrow cannot resurrect thrust from a stranded W source.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 3)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 13)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 14)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 5)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 7)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 5)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 2) (i32.const 3)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 7)) (i32.const 0))

;; Live reload cannot promise a release edge for a key or button held while the
;; guest is replaced. Restore clears only edge-latched controls, retaining the
;; player's persistent toggles and precise pointer target authority.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 84) (i32.const 895)))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 15560) (i32.const 1)))
(assert_return (invoke $vibesteroids_tests "after_restore") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 84)) (i32.const 880))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 15560)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 80) (i32.const 1)))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 4)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 16)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "active_count" (i32.const 256) (i32.const 48) (i32.const 64)) (i32.const 2))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "active_count" (i32.const 256) (i32.const 48) (i32.const 64)) (i32.const 2))

;; Level two applies one exact +20% projectile-speed step while retaining the
;; original bounded fire-cadence curve after live play found 20%/level excessive.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 80) (i32.const 2)))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 4)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 288)) (i64.const -405000000))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 14)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "active_count" (i32.const 256) (i32.const 48) (i32.const 64)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "active_count" (i32.const 256) (i32.const 48) (i32.const 64)) (i32.const 2))

(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 80) (i32.const 20)))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 3)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 48)) (i64.const -8302107))
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 80) (i32.const 20)))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 2)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 56)) (i64.const 165896))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 64)) (i64.const -986144))
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 80) (i32.const 20)))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 4)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 8)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 288)) (i64.const -1620000000))
(assert_return (invoke $vibesteroids_tests "active_count" (i32.const 256) (i32.const 48) (i32.const 64)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "active_count" (i32.const 256) (i32.const 48) (i32.const 64)) (i32.const 2))

;; A large hit creates two 24-pixel children, particles, score, and level-aware velocity caps.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 80) (i32.const 1)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3344) (i64.const 200000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3352) (i64.const 200000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3360) (i64.const 600000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3368) (i64.const 600000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3376) (i64.const 40000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 256) (i32.const 1)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 264) (i64.const 210000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 272) (i64.const 210000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 280) (i64.const 0)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 288) (i64.const 0)))
(assert_return (invoke $vibesteroids_tests "host_reset_effects"))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 72)) (i32.const 80))
(assert_return (invoke $vibesteroids_tests "radius_count" (i64.const 24000000)) (i32.const 2))
(assert_return (invoke $vibesteroids_tests "active_count" (i32.const 3328) (i32.const 80) (i32.const 32)) (i32.const 6))
(assert_return (invoke $vibesteroids_tests "active_count" (i32.const 5888) (i32.const 48) (i32.const 150)) (i32.const 20))
(assert_return (invoke $vibesteroids_tests "radius_components_within" (i64.const 24000000) (i64.const 60000000)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_audio_seen" (i32.const 2)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "split_at_level" (i32.const 2)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "radius_count" (i64.const 24000000)) (i32.const 2))
(assert_return (invoke $vibesteroids_tests "radius_components_within" (i64.const 24000000) (i64.const 71999999)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "radius_components_within" (i64.const 24000000) (i64.const 72000000)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "split_at_level" (i32.const 20)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "radius_count" (i64.const 24000000)) (i32.const 2))
(assert_return (invoke $vibesteroids_tests "radius_components_within" (i64.const 24000000) (i64.const 287999999)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "radius_components_within" (i64.const 24000000) (i64.const 288000000)) (i32.const 1))

;; Rendering is pure, replay is deterministic, and modal overlays freeze all state except the clock.
(assert_return (invoke $vibesteroids_tests "render_is_state_pure") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "deterministic_input_replay") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "help_freezes_state") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_reset_frame"))
(assert_return (invoke $vibesteroids_tests "render") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_first_duplicate_stable_id") (i32.const -1))
(assert_return (invoke $vibesteroids_tests "host_duplicate_stable_ids") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_text_seen" (i32.const 40)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_blossom_help_valid") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_help_copy_mask") (i32.const 63))
(assert_return (invoke $vibesteroids_tests "host_help_frame_lines") (i32.const 5))
(assert_return (invoke $vibesteroids_tests "host_help_columns_valid") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_help_max_y") (f32.const 669))
(assert_return (invoke $vibesteroids_tests "host_help_keyboard_alias_copy_mask") (i32.const 3))
(assert_return (invoke $vibesteroids_tests "data_u8" (i32.const 245)) (i32.const 0x41))
(assert_return (invoke $vibesteroids_tests "data_u8" (i32.const 253)) (i32.const 0x44))
(assert_return (invoke $vibesteroids_tests "data_u8" (i32.const 267)) (i32.const 0x57))
(assert_return (invoke $vibesteroids_tests "data_u8" (i32.const 560)) (i32.const 0x4b))
(assert_return (invoke $vibesteroids_tests "data_u8" (i32.const 568)) (i32.const 0x50))
(assert_return (invoke $vibesteroids_tests "data_u8" (i32.const 576)) (i32.const 0x4d))
(assert_return (invoke $vibesteroids_tests "data_u8" (i32.const 592)) (i32.const 0x48))
(assert_return (invoke $vibesteroids_tests "data_u8" (i32.const 616)) (i32.const 0x48))
(assert_return (invoke $vibesteroids_tests "data_u8" (i32.const 640)) (i32.const 0x53))
;; Taller viewports add no dead panel space: the border remains content-sized.
(assert_return
	(invoke $vibesteroids_tests "viewport" (f32.const 1024) (f32.const 900))
	(i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_reset_frame"))
(assert_return (invoke $vibesteroids_tests "render") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_help_max_y") (f32.const 669))
;; The reference composition compacts vertically, including its content-sized
;; border, when the live viewport is shorter than the approved 768px geometry.
(assert_return
	(invoke $vibesteroids_tests "viewport" (f32.const 800) (f32.const 600))
	(i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_reset_frame"))
(assert_return (invoke $vibesteroids_tests "render") (i32.const 0))
(assert_return
	(invoke $vibesteroids_tests "host_help_fits_height" (f32.const 600))
	(i32.const 1))
(assert_return
	(invoke $vibesteroids_tests "host_help_fits_height" (f32.const 530))
	(i32.const 1))
(assert_return
	(invoke $vibesteroids_tests "host_help_pointer_gap_valid")
	(i32.const 1))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 7) (i32.const 7)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_reset_frame"))
(assert_return (invoke $vibesteroids_tests "render") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_text_seen" (i32.const 40)) (i32.const 0))

;; The approved active-power badge is text-plus-icon, exposes a deterministic
;; tenths countdown, and disappears completely when the reward expires.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 15496) (i32.const 2376)))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 15568) (i32.const 0)))
(assert_return (invoke $vibesteroids_tests "host_reset_frame"))
(assert_return (invoke $vibesteroids_tests "render") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_text_seen" (i32.const 60)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_text_seen" (i32.const 61)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_power_hud_kind") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_power_hud_text_valid") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_power_hud_text_y") (f32.const 95))
(assert_return (invoke $vibesteroids_tests "host_power_hud_primitives") (i32.const 6))
(assert_return (invoke $vibesteroids_tests "data_u8" (i32.const 679)) (i32.const 0x31))
(assert_return (invoke $vibesteroids_tests "data_u8" (i32.const 680)) (i32.const 0x39))
(assert_return (invoke $vibesteroids_tests "data_u8" (i32.const 682)) (i32.const 0x38))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 15568) (i32.const 1)))
(assert_return (invoke $vibesteroids_tests "host_reset_frame"))
(assert_return (invoke $vibesteroids_tests "render") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_text_seen" (i32.const 60)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_text_seen" (i32.const 61)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_power_hud_kind") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_power_hud_text_valid") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_power_hud_text_y") (f32.const 95))
(assert_return (invoke $vibesteroids_tests "host_power_hud_primitives") (i32.const 8))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 15496) (i32.const 0)))
(assert_return (invoke $vibesteroids_tests "host_reset_frame"))
(assert_return (invoke $vibesteroids_tests "render") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_text_seen" (i32.const 60)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_text_seen" (i32.const 61)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_power_hud_primitives") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "pause_freezes_state") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 11)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 16)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 12)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 512)) (i32.const 1))

;; The four-second title remains visible through tick 239 and disappears at 240.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 92) (i32.const 10000)))
(assert_return (invoke $vibesteroids_tests "host_reset_frame"))
(assert_return (invoke $vibesteroids_tests "render") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_text_seen" (i32.const 10)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 239)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_reset_frame"))
(assert_return (invoke $vibesteroids_tests "render") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_text_seen" (i32.const 10)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_reset_frame"))
(assert_return (invoke $vibesteroids_tests "render") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_text_seen" (i32.const 10)) (i32.const 0))

;; Death Blossom is once-per-life, cancels thrust, emits its siren, and ends at tick 629.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_reset_frame"))
(assert_return (invoke $vibesteroids_tests "render") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_blossom_marks") (i32.const 9))
(assert_return (invoke $vibesteroids_tests "host_reset_effects"))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 9)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 128)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 256)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_audio_seen" (i32.const 5)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_reset_frame"))
(assert_return (invoke $vibesteroids_tests "render") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_blossom_marks") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_reset_frame"))
(assert_return (invoke $vibesteroids_tests "render") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_text_seen" (i32.const 36)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 3)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 10)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 40)) (i64.const 0))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 48)) (i64.const 0))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 120)) (i64.const 1200000))
(assert_return (invoke $vibesteroids_tests "active_at_least" (i32.const 256) (i32.const 48) (i32.const 64) (i32.const 5)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 618)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 128)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 128)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 9)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 128)) (i32.const 0))

;; Any host-observable wheel roll spends the once-per-life Death Blossom charge.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_reset_effects"))
(assert_return
	(invoke $vibesteroids_tests "pointer_event"
		(i32.const 10) (i32.const 1) (f32.const 0) (f32.const -1))
	(i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 128)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 256)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_audio_seen" (i32.const 5)) (i32.const 1))

;; Kid Mode preserves lives and suppresses the ordinary score/lives HUD on collision.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 92) (i32.const 0)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3344) (i64.const 512000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3352) (i64.const 384000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3360) (i64.const 0)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3368) (i64.const 0)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3376) (i64.const 20000000)))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 8)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 76)) (i32.const 3))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 72)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 100)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_reset_frame"))
(assert_return (invoke $vibesteroids_tests "render") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_text_seen" (i32.const 20)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_text_seen" (i32.const 24)) (i32.const 0))

;; A terminal asteroid awards 120 and disappears without splitting.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3344) (i64.const 200000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3352) (i64.const 200000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3360) (i64.const 0)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3368) (i64.const 0)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3376) (i64.const 20000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 256) (i32.const 1)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 264) (i64.const 200000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 272) (i64.const 200000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 280) (i64.const 0)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 288) (i64.const 0)))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 72)) (i32.const 120))
(assert_return (invoke $vibesteroids_tests "active_count" (i32.const 3328) (i32.const 80) (i32.const 32)) (i32.const 4))

;; Swept collision catches tunneling: both discrete bullet endpoints lie well
;; outside the rock, but the finite movement segment crosses its center.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "clear_active" (i32.const 3328) (i32.const 80) (i32.const 32)))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 3328) (i32.const 1)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3344) (i64.const 150000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3352) (i64.const 200000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3360) (i64.const 0)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3368) (i64.const 0)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3376) (i64.const 10000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 256) (i32.const 1)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 264) (i64.const 100000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 272) (i64.const 200000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 280) (i64.const 12000000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 288) (i64.const 0)))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 72)) (i32.const 120))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 256)) (i32.const 0))

;; A full bullet pool fails closed and focus loss releases held controls.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "fill_legacy_bullet_pool"))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 4)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "active_count" (i32.const 256) (i32.const 48) (i32.const 64)) (i32.const 64))
(assert_return (invoke $vibesteroids_tests "active_count" (i32.const 3328) (i32.const 80) (i32.const 32)) (i32.const 5))

;; Blast extent follows viewport area. Equal-area viewports must render the same
;; peak radius even when their aspect ratios differ.
(assert_return (invoke $vibesteroids_tests "blast_matches_across_equal_area"
	(f32.const 1024) (f32.const 768) (f32.const 1536) (f32.const 512)) (i32.const 1))

;; Rapid-fire Death Blossom must outgrow the legacy 64-slot pool. After 70
;; ticks, even the shot heading toward the nearest edge has traveled only about
;; 197 of the required 384 pixels, so all 130 emitted projectiles remain.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "clear_active" (i32.const 3328) (i32.const 80) (i32.const 32)))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 3328) (i32.const 1)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3344) (i64.const 10000000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3352) (i64.const 10000000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3376) (i64.const 20000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 15496) (i32.const 2400)))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 15568) (i32.const 1)))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 9)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 70)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "active_count" (i32.const 256) (i32.const 48) (i32.const 64)) (i32.const 64))
(assert_return (invoke $vibesteroids_tests "active_count" (i32.const 16384) (i32.const 48) (i32.const 192)) (i32.const 66))
(assert_return (invoke $vibesteroids_tests "host_reset_frame"))
(assert_return (invoke $vibesteroids_tests "render") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_bullet_circles") (i32.const 130))

;; Focus loss clears the complete set of held controls without silently
;; changing pause, Auto-fire, Kid Mode, Help, or either Death Blossom bit. It
;; also raises a Resume gate that freezes the world until a completed button
;; click or any key-down dismisses it. Pointer motion and pointer-down alone do
;; not count as the completed tap needed to resume.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 84) (i32.const 1023)))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 8) (i32.const 0)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 84)) (i32.const 4080))
(assert_return (invoke $vibesteroids_tests "gate_visible") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "resume_gate_visible") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 48)) (i64.const 0))

;; With no other modal flag involved, the Resume gate alone freezes moving
;; actors. Raw canvas pointer events cannot activate the host-owned button;
;; only its exact semantic action can dismiss the gate.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 8) (i32.const 0)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "asteroids_moved_during" (i32.const 30)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "pointer_event" (i32.const 3) (i32.const 0) (f32.const 512) (f32.const 384)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "gate_visible") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "pointer_event" (i32.const 4) (i32.const 1) (f32.const 512) (f32.const 384)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "gate_visible") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "pointer_event" (i32.const 5) (i32.const 1) (f32.const 8) (f32.const 8)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "gate_visible") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "pointer_event" (i32.const 4) (i32.const 1) (f32.const 512) (f32.const 384)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "pointer_event" (i32.const 5) (i32.const 1) (f32.const 512) (f32.const 384)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "gate_visible") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 7) (i32.const 8)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "gate_visible") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 7) (i32.const 9)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "gate_visible") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "resume_gate_visible") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "asteroids_moved_during" (i32.const 1)) (i32.const 1))

;; A key dismisses Resume but is consumed, so the resuming Space edge cannot
;; also leave firing held or create a projectile on the following tick.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 8) (i32.const 0)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 4)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "gate_visible") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 8)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "active_count" (i32.const 256) (i32.const 48) (i32.const 64)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "active_count" (i32.const 16384) (i32.const 48) (i32.const 192)) (i32.const 0))

;; Standard New Game is guest-owned; Quit is a generic host effect.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 72) (i32.const 1234)))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 7) (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 72)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_reset_effects"))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 7) (i32.const 6)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_effect_seen" (i32.const 2)) (i32.const 1))

;; Ship collision creates debris, consumes a life, respawns, and eventually reaches game over.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 92) (i32.const 0)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3344) (i64.const 512000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3352) (i64.const 384000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3360) (i64.const 0)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3368) (i64.const 0)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3376) (i64.const 20000000)))
(assert_return (invoke $vibesteroids_tests "host_reset_effects"))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 76)) (i32.const 2))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 100)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "active_count" (i32.const 13088) (i32.const 80) (i32.const 4)) (i32.const 4))
(assert_return (invoke $vibesteroids_tests "host_audio_seen" (i32.const 3)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 120)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 100)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 76)) (i32.const 2))

(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 76) (i32.const 1)))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 92) (i32.const 0)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3344) (i64.const 512000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3352) (i64.const 384000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3360) (i64.const 0)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3368) (i64.const 0)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3376) (i64.const 20000000)))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 121)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 100)) (i32.const 3))
(assert_return (invoke $vibesteroids_tests "gate_visible") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_reset_frame"))
(assert_return (invoke $vibesteroids_tests "render") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_text_seen" (i32.const 34)) (i32.const 1))
;; Starting again is immediate and consumes the key, yielding the same fresh,
;; protected ship as the boot gate rather than carrying a fire edge forward.
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 4)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "gate_visible") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 100)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 76)) (i32.const 3))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 72)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_bits" (i32.const 84) (i32.const 8)) (i32.const 0))

;; Respawn safety shrinks at tick 300; the tick-600 bomb clears only the unsafe zone.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 100) (i32.const 2)))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 104) (i32.const 596)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3344) (i64.const 612000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3352) (i64.const 384000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3360) (i64.const 0)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3368) (i64.const 0)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3376) (i64.const 20000000)))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 100)) (i32.const 2))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 100)) (i32.const 0))

(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "clear_active" (i32.const 3328) (i32.const 80) (i32.const 32)))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 100) (i32.const 2)))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 104) (i32.const 1196)))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 3328) (i32.const 1)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3344) (i64.const 572000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3352) (i64.const 384000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3360) (i64.const 0)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3368) (i64.const 0)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3376) (i64.const 20000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 3408) (i32.const 1)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3424) (i64.const 812000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3432) (i64.const 384000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3440) (i64.const 0)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3448) (i64.const 0)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3456) (i64.const 20000000)))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 3328)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 3328)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 3408)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 72)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 100)) (i32.const 0))

;; The star field must come from the deterministic PRNG, like every other
;; placement. It was generated from the loop index alone, so every seed drew the
;; identical sky, and both coordinates advanced by a fixed step per star, which
;; laid all one hundred on a diagonal lattice instead of scattering them.
(assert_return (invoke $vibesteroids_tests "star_field_differs_across_seeds" (i32.const 1) (i32.const 2)) (i32.const 1))
;; Specificity: one seed must still reproduce its own sky exactly.
(assert_return (invoke $vibesteroids_tests "star_field_differs_across_seeds" (i32.const 1) (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "star_repeated_step_pairs") (i32.const 0))

;; iOS grants Web Audio only on a completed tap, and a steering drag never
;; counts, so boot is gated behind a Start Game button to guarantee the first
;; interaction is a tap. The gate holds lifecycle 2, the existing no-ship state,
;; so rocks drift behind it and dismissal spawns the ship through the ordinary
;; respawn-safety path rather than a second spawn mechanism.
(assert_return (invoke $vibesteroids_tests "reset_gated") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 100)) (i32.const 2))
(assert_return (invoke $vibesteroids_tests "gate_visible") (i32.const 1))
;; The gate outlasts any number of ticks; only a dismissal clears it.
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 600)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 100)) (i32.const 2))
(assert_return (invoke $vibesteroids_tests "gate_visible") (i32.const 1))
;; Rocks drift behind it, so the gate is an overlay and not a pause.
(assert_return (invoke $vibesteroids_tests "asteroids_moved_during" (i32.const 30)) (i32.const 1))
;; A key dismisses it, and the ship then arrives through the respawn path with
;; the ordinary invulnerability window rather than materializing unprotected.
(assert_return (invoke $vibesteroids_tests "reset_gated") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 1) (i32.const 3)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "gate_visible") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 100)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32_between" (i32.const 92) (i32.const 1) (i32.const 240)) (i32.const 1))

;; Start and Resume use one real retained host button with distinct standalone
;; action IDs. No canvas imitation remains, and game over keeps its indication
;; above the native button.
(assert_return (invoke $vibesteroids_tests "render_start_gate") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_ui_snapshot_count") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_ui_panel_count") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_ui_button_count") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_ui_button_action") (i32.const 8))
(assert_return (invoke $vibesteroids_tests "host_ui_button_geometry_valid" (i32.const 22282240)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_gate_copy_kind") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_gate_border_lines") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_main_ship_paths") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "render_resume_gate") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_ui_snapshot_count") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_ui_button_action") (i32.const 9))
(assert_return (invoke $vibesteroids_tests "host_ui_button_geometry_valid" (i32.const 22282240)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_gate_copy_kind") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_gate_border_lines") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "render_game_over_gate") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_text_seen" (i32.const 34)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_ui_button_action") (i32.const 8))
(assert_return (invoke $vibesteroids_tests "host_ui_button_geometry_valid" (i32.const 28573696)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_gate_copy_kind") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_game_over_gate_separated") (i32.const 1))

;; The retained document is sent once per visible state, sent again after a
;; resize changes geometry, and replaced by an explicit empty snapshot when
;; the gate disappears.
(assert_return (invoke $vibesteroids_tests "render_start_gate_twice") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_ui_snapshot_count") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "render_resized_start_gate") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_ui_snapshot_count") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_ui_button_count") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "render_dismissed_start_gate") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_ui_snapshot_count") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_ui_panel_count") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_ui_button_count") (i32.const 0))

;; Start and Resume reject the other mode's action ID, then accept their own.
(assert_return (invoke $vibesteroids_tests "reset_gated") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 7) (i32.const 9)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "gate_visible") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 7) (i32.const 8)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "gate_visible") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 8) (i32.const 0)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 7) (i32.const 8)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "gate_visible") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "event" (i32.const 7) (i32.const 9)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "gate_visible") (i32.const 0))

;; Projectiles are projectiles: they end on a hit or at the viewport edge, and
;; they never wrap. The previous distance countdown made shots evaporate in open
;; space, which Peter reported as the range being far too short.
;; A zero-world-velocity shot is reachable when ship motion exactly cancels
;; muzzle speed. An overlapping target must claim that shot before the inert
;; record guard retires it.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "hit_terminal_asteroid_at_score" (i32.const 0)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 72)) (i32.const 120))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 256)) (i32.const 0))

;; Bullet 0 is placed by hand at centre travelling right at the base speed, so
;; the arithmetic is exact rather than dependent on ship heading. A far-away
;; rock keeps wave scheduling inert without becoming a collision target.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "clear_active" (i32.const 256) (i32.const 48) (i32.const 64)))
(assert_return (invoke $vibesteroids_tests "clear_active" (i32.const 3328) (i32.const 80) (i32.const 32)))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 3328) (i32.const 1)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3344) (i64.const 10000000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3352) (i64.const 10000000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 3376) (i64.const 20000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 256) (i32.const 1)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 264) (i64.const 512000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 272) (i64.const 384000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 280) (i64.const 337500000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 288) (i64.const 0)))
;; Still airborne just inside the right margin after 95 original 60-Hz source
;; ticks, which the harness converts to 190 production ticks.
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 95)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 264)) (i64.const 1046375000))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 256)) (i32.const 1))
;; One more source tick carries it past the margin, where it ends by leaving.
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 256)) (i32.const 0))
;; Gone once it clears the edge, and gone by leaving rather than by wrapping
;; back into play from the left.
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 6)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 256)) (i32.const 0))
