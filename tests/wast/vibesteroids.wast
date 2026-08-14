;; The runner inserts and registers the canonical production WAT as "sut"
;; before this companion script. All application-specific assertions live here.
(module $vibesteroids_tests
	(import "sut" "memory" (memory $state 1))
	(import "sut" "AE_state_schema" (func $state_schema (result i32)))
	(import "sut" "AE_state_len" (func $state_len (result i32)))
	(import "sut" "AE_tick_rate" (func $tick_rate (param i32 i32) (result i32 i32)))
	(import "sut" "AE_configure" (func $configure (result i32)))
	(import "sut" "AE_init" (func $init (param i32 i32 f32 f32) (result i32)))
	(import "sut" "AE_after_restore" (func $after_restore (result i32)))
	(import "sut" "AE_event" (func $event (param i32 i32 f32 f32) (result i32)))
	(import "sut" "AE_tick" (func $tick (param i32) (result i32)))
	(import "sut" "AE_render" (func $sut_render (result i32)))
	(import "test.host" "test_reset_config" (func $host_reset_config))
	(import "test.host" "test_reset_frame" (func $host_reset_frame))
	(import "test.host" "test_reset_effects" (func $host_reset_effects))
	(import "test.host" "test_motion_interest_valid"
		(func $host_motion_interest_valid (result i32)))
	(import "test.host" "test_set_motion_interest_status"
		(func $host_set_motion_interest_status (param i32)))
	(import "test.host" "test_title_ptr" (func $host_title_ptr (result i32)))
	(import "test.host" "test_title_len" (func $host_title_len (result i32)))
	(import "test.host" "test_menu_count" (func $host_menu_count (result i32)))
	(import "test.host" "test_menu_seen" (func $host_menu_seen (param i32) (result i32)))
	(import "test.host" "test_action_count" (func $host_action_count (result i32)))
	(import "test.host" "test_action_seen" (func $host_action_seen (param i32) (result i32)))
	(import "test.host" "test_action_declaration_errors" (func $host_action_declaration_errors (result i32)))
	(import "test.host" "test_synth_count" (func $host_synth_count (param i32) (result i32)))
	(import "test.host" "test_invalid_synth_voices" (func $host_invalid_synth_voices (result i32)))
	(import "test.host" "test_short_boom_voices" (func $host_short_boom_voices (result i32)))
	(import "test.host" "test_satellite_ping_valid" (func $host_satellite_ping_valid (result i32)))
	(import "test.host" "test_thrust_rumble_valid" (func $host_thrust_rumble_valid (result i32)))
	(import "test.host" "test_synth_signature" (func $host_synth_signature (result i64)))
	(import "test.host" "test_frame_count" (func $host_frame_count (result i32)))
	(import "test.host" "test_flash_frames" (func $host_flash_frames (result i32)))
	(import "test.host" "test_duplicate_stable_ids" (func $host_duplicate_stable_ids (result i32)))
	(import "test.host" "test_first_duplicate_stable_id" (func $host_first_duplicate_stable_id (result i32)))
	(import "test.host" "test_geometry_errors" (func $host_geometry_errors (result i32)))
	(import "test.host" "test_first_invalid_circle_id"
		(func $host_first_invalid_circle_id (result i32)))
	(import "test.host" "test_lifecycle_errors" (func $host_lifecycle_errors (result i32)))
	(import "test.host" "test_text_seen" (func $host_text_seen (param i32) (result i32)))
	(import "test.host" "test_asteroid_paths" (func $host_asteroid_paths (result i32)))
	(import "test.host" "test_bad_asteroid_vertices" (func $host_bad_asteroid_vertices (result i32)))
	(import "test.host" "test_asteroid_circles" (func $host_asteroid_circles (result i32)))
	(import "test.host" "test_reserve_paths" (func $host_reserve_paths (result i32)))
	(import "test.host" "test_main_ship_paths" (func $host_main_ship_paths (result i32)))
	(import "test.host" "test_reserve_count_text_valid" (func $host_reserve_count_text_valid (result i32)))
	(import "test.host" "test_star_circles" (func $host_star_circles (result i32)))
	(import "test.host" "test_ufo_paths" (func $host_ufo_paths (result i32)))
	(import "test.host" "test_enemy_bullet_circles" (func $host_enemy_bullet_circles (result i32)))
	(import "test.host" "test_package_paths" (func $host_package_paths (result i32)))
	(import "test.host" "test_package_bow_paths"
		(func $host_package_bow_paths (result i32)))
	(import "test.host" "test_package_bow_knots"
		(func $host_package_bow_knots (result i32)))
	(import "test.host" "test_satellite_paths" (func $host_satellite_paths (result i32)))
	(import "test.host" "test_satellite_lines" (func $host_satellite_lines (result i32)))
	(import "test.host" "test_satellite_circles" (func $host_satellite_circles (result i32)))
	(import "test.host" "test_satellite_connected_booms" (func $host_satellite_connected_booms (result i32)))
	(import "test.host" "test_satellite_footprint_valid" (func $host_satellite_footprint_valid (result i32)))
	(import "test.host" "test_satellite_glow_radius" (func $host_satellite_glow_radius (result f32)))
	(import "test.host" "test_laser_lines" (func $host_laser_lines (result i32)))
	(import "test.host" "test_blossom_marks" (func $host_blossom_marks (result i32)))
	(import "test.host" "test_blossom_help_valid" (func $host_blossom_help_valid (result i32)))
	(import "test.host" "test_help_copy_mask" (func $host_help_copy_mask (result i32)))
	(import "test.host" "test_touch_help_copy_mask"
		(func $host_touch_help_copy_mask (result i32)))
	(import "test.host" "test_help_frame_lines" (func $host_help_frame_lines (result i32)))
	(import "test.host" "test_gate_copy_kind" (func $host_gate_copy_kind (result i32)))
	(import "test.host" "test_gate_border_lines" (func $host_gate_border_lines (result i32)))
	(import "test.host" "test_game_over_gate_separated" (func $host_game_over_gate_separated (result i32)))
	(import "test.host" "test_ui_snapshot_count" (func $host_ui_snapshot_count (result i32)))
	(import "test.host" "test_ui_panel_count" (func $host_ui_panel_count (result i32)))
	(import "test.host" "test_ui_button_count" (func $host_ui_button_count (result i32)))
	(import "test.host" "test_ui_button_action" (func $host_ui_button_action (result i32)))
	(import "test.host" "test_ui_button_geometry_valid" (func $host_ui_button_geometry_valid (param i32) (result i32)))
	(import "test.host" "test_help_columns_valid" (func $host_help_columns_valid (result i32)))
	(import "test.host" "test_help_fits_height" (func $host_help_fits_height (param f32) (result i32)))
	(import "test.host" "test_help_max_y" (func $host_help_max_y (result f32)))
	(import "test.host" "test_help_pointer_gap_valid" (func $host_help_pointer_gap_valid (result i32)))
	(import "test.host" "test_help_stacked_valid" (func $host_help_stacked_valid (result i32)))
	(import "test.host" "test_help_keyboard_alias_copy_mask"
		(func $host_help_keyboard_alias_copy_mask (result i32)))
	(import "test.host" "test_power_hud_kind" (func $host_power_hud_kind (result i32)))
	(import "test.host" "test_power_hud_text_valid" (func $host_power_hud_text_valid (result i32)))
	(import "test.host" "test_power_hud_text_y" (func $host_power_hud_text_y (result f32)))
	(import "test.host" "test_power_hud_primitives" (func $host_power_hud_primitives (result i32)))
	(import "test.host" "test_blast_circles" (func $host_blast_circles (result i32)))
	(import "test.host" "test_blast_radius" (func $host_blast_radius (result f32)))
	(import "test.host" "test_flame_min_x" (func $host_flame_min_x (result f32)))
	(import "test.host" "test_audio_seen" (func $host_audio_seen (param i32) (result i32)))
	(import "test.host" "test_audio_count" (func $host_audio_count (param i32) (result i32)))
	(import "test.host" "test_thrust_audio_valid" (func $host_thrust_audio_valid (result i32)))
	(import "test.host" "test_sample_asset_valid" (func $host_sample_asset_valid (result i32)))
	(import "test.host" "test_sample_play_count" (func $host_sample_play_count (result i32)))
	(import "test.host" "test_sample_play_valid" (func $host_sample_play_valid (result i32)))
	(import "test.host" "test_effect_seen" (func $host_effect_seen (param i32) (result i32)))
	(import "test.host" "test_bullet_circles" (func $host_bullet_circles (result i32)))

	;; Makes every companion scenario enforce the real host's atomic frame-ID
	;; contract, so a future conditional render cannot omit the duplicate check.
	(func $render (result i32)
		(local $status i32)
		call $sut_render local.set $status
		local.get $status (if (then local.get $status return))
		call $host_duplicate_stable_ids
		call $host_geometry_errors i32.or
		call $host_lifecycle_errors i32.or)

	(func (export "schema") (result i32) call $state_schema)
	(func (export "state_len") (result i32) call $state_len)
	(func (export "tick_rate") (param i32 i32) (result i32 i32)
		local.get 0 local.get 1 call $tick_rate)
	;; Fixtures that exercise gameplay want a playable ship, so every ordinary
	;; entry point dismisses the boot gate through the real event path rather
	;; than by writing the flag directly. The gate consumes that key outright, so
	;; no matching key-up is needed and no action leaks into the fixture.
	;; reset_gated leaves the gate armed for its own oracles.
	(func $init_playable (param $seed i32) (param $mode i32)
		(param $width f32) (param $height f32) (result i32)
		(local $status i32)
		local.get $seed local.get $mode local.get $width local.get $height
		call $init local.set $status
		i32.const 1 i32.const 3 f32.const 0 f32.const 0 call $event drop
		local.get $status)
	(func (export "reset") (result i32)
		call $configure drop
		i32.const 0x5eed i32.const 0 f32.const 1024 f32.const 768 call $init_playable)
	(func (export "reset_gated") (result i32)
		call $configure drop
		i32.const 0x5eed i32.const 0 f32.const 1024 f32.const 768 call $init)
	(func (export "reset_seed") (param $seed i32) (result i32)
		call $configure drop
		local.get $seed i32.const 0 f32.const 1024 f32.const 768 call $init_playable)
	(func (export "after_restore") (result i32) call $after_restore)
	;; Classifies the unchanged hazardous-actor schedules over a deterministic
	;; seed set, preventing one lucky fixture from hiding a range regression.
	(func (export "hazard_schedules_within")
		(param $minimum i32) (param $maximum i32) (param $seed_count i32) (result i32)
		(local $seed i32) (local $ufo i32) (local $satellite i32)
		call $configure drop
		(block $valid (loop $seeds
			local.get $seed local.get $seed_count i32.ge_u
			(if (then i32.const 1 return))
			local.get $seed i32.const 1 i32.add i32.const 0
			f32.const 1024 f32.const 768 call $init_playable drop
			i32.const 16512 i32.load local.set $ufo
			i32.const 26732 i32.load local.set $satellite
			local.get $ufo local.get $minimum i32.lt_s
			local.get $ufo local.get $maximum i32.gt_s i32.or
			local.get $satellite local.get $minimum i32.lt_s i32.or
			local.get $satellite local.get $maximum i32.gt_s i32.or
			(if (then i32.const 0 return))
			local.get $seed i32.const 1 i32.add local.set $seed
				br $seeds))
		i32.const 1)
	;; Classifies gift schedules independently because destroyed gifts justify a
	;; shorter cadence without also making hazardous actors more frequent.
	(func (export "package_schedules_within")
		(param $minimum i32) (param $maximum i32) (param $seed_count i32) (result i32)
		(local $seed i32) (local $package i32)
		call $configure drop
		(block $valid (loop $seeds
			local.get $seed local.get $seed_count i32.ge_u
			(if (then i32.const 1 return))
			local.get $seed i32.const 1 i32.add i32.const 0
			f32.const 1024 f32.const 768 call $init_playable drop
			i32.const 16516 i32.load local.set $package
			local.get $package local.get $minimum i32.lt_s
			local.get $package local.get $maximum i32.gt_s i32.or
			(if (then i32.const 0 return))
			local.get $seed i32.const 1 i32.add local.set $seed
			br $seeds))
		i32.const 1)
	;; Couples each seeded satellite traversal sign to its entry edge and proves
	;; that clockwise and counter-clockwise initial spins both occur across a set.
	(func (export "satellite_entries_valid") (param $seed_count i32) (result i32)
		(local $seed i32) (local $direction i32) (local $spin i32)
		(local $directions i32) (local $spins i32)
		call $configure drop
		(block $valid (loop $seeds
			local.get $seed local.get $seed_count i32.ge_u br_if $valid
			local.get $seed i32.const 1 i32.add i32.const 0
			f32.const 1024 f32.const 768 call $init_playable drop
			call $clear_test_asteroids
			call $place_safe_decoy
			i32.const 26732 i32.const 1 i32.store
			i32.const 1 call $tick drop
			i32.const 26656 i32.load i32.eqz (if (then i32.const 0 return))
			i32.const 26660 i32.load local.tee $direction i32.const 1 i32.eq
			(if
				(then
					i32.const 26664 i64.load i64.const -80000000 i64.ne (if (then i32.const 0 return))
					local.get $directions i32.const 1 i32.or local.set $directions)
				(else
					local.get $direction i32.const -1 i32.ne (if (then i32.const 0 return))
					i32.const 26664 i64.load i32.const 1032 i64.load i64.const 80000000 i64.add i64.ne
					(if (then i32.const 0 return))
					local.get $directions i32.const 2 i32.or local.set $directions))
			i32.const 26720 i32.load local.tee $spin i32.const 1 i32.eq
			(if
				(then local.get $spins i32.const 1 i32.or local.set $spins)
				(else
					local.get $spin i32.const -1 i32.ne (if (then i32.const 0 return))
					local.get $spins i32.const 2 i32.or local.set $spins))
			local.get $seed i32.const 1 i32.add local.set $seed
			br $seeds))
		local.get $directions i32.const 3 i32.eq
		local.get $spins i32.const 3 i32.eq i32.and)
	;; Classifies foreign-actor directions over a seed set and couples each sign
	;; to its exact entry edge; both signs must occur for both independent actors.
	(func (export "foreign_actor_edges_valid") (param $seed_count i32) (result i32)
		(local $seed i32) (local $direction i32)
		(local $ufo_directions i32) (local $package_directions i32)
		call $configure drop
		(block $valid (loop $seeds
			local.get $seed local.get $seed_count i32.ge_u br_if $valid
			local.get $seed i32.const 1 i32.add i32.const 0
			f32.const 1024 f32.const 768 call $init_playable drop
			call $clear_test_asteroids
			call $place_safe_decoy
			i32.const 16512 i32.const 1 i32.store
			i32.const 16516 i32.const 1 i32.store
			i32.const 1 call $tick drop
			i32.const 16032 i32.load i32.eqz i32.const 16464 i32.load i32.eqz i32.or
			(if (then i32.const 0 return))
			i32.const 16036 i32.load local.tee $direction i32.const 1 i32.eq
			(if
				(then
					i32.const 16040 i64.load i64.const -30000000 i64.ne (if (then i32.const 0 return))
					local.get $ufo_directions i32.const 1 i32.or local.set $ufo_directions)
				(else
					local.get $direction i32.const -1 i32.ne (if (then i32.const 0 return))
					i32.const 16040 i64.load i32.const 1032 i64.load i64.const 30000000 i64.add i64.ne
					(if (then i32.const 0 return))
					local.get $ufo_directions i32.const 2 i32.or local.set $ufo_directions))
			i32.const 16468 i32.load local.tee $direction i32.const 1 i32.eq
			(if
				(then
					i32.const 16472 i64.load i64.const -30000000 i64.ne (if (then i32.const 0 return))
					local.get $package_directions i32.const 1 i32.or local.set $package_directions)
				(else
					local.get $direction i32.const -1 i32.ne (if (then i32.const 0 return))
					i32.const 16472 i64.load i32.const 1032 i64.load i64.const 30000000 i64.add i64.ne
					(if (then i32.const 0 return))
					local.get $package_directions i32.const 2 i32.or local.set $package_directions))
			local.get $seed i32.const 1 i32.add local.set $seed
			br $seeds))
		local.get $ufo_directions i32.const 3 i32.eq
		local.get $package_directions i32.const 3 i32.eq i32.and)
	(func (export "thrust_once") (result i32)
		call $configure drop
		i32.const 0x5eed i32.const 0 f32.const 1024 f32.const 768 call $init_playable drop
		i32.const 1 i32.const 3 f32.const 0 f32.const 0 call $event drop
		i32.const 1 call $tick)
	(func (export "fire_once") (result i32)
		call $configure drop
		i32.const 0x5eed i32.const 0 f32.const 1024 f32.const 768 call $init_playable drop
		i32.const 1 i32.const 4 f32.const 0 f32.const 0 call $event drop
		i32.const 1 call $tick)
	(func (export "drag_once") (result i32)
		call $configure drop
		i32.const 0x5eed i32.const 0 f32.const 1024 f32.const 768 call $init_playable drop
		i32.const 1064 i64.const 2500000 i64.store
		i32.const 1072 i64.const -1250000 i64.store
		i32.const 1 call $tick)
	(func (export "configure_only") (result i32)
		call $host_reset_config
		call $configure)
	(func (export "configure_with_motion_status") (param $status i32) (result i32)
		call $host_reset_config
		local.get $status call $host_set_motion_interest_status
		call $configure)
	(func (export "host_motion_interest_valid") (result i32)
		call $host_motion_interest_valid)
	(func (export "render_initial") (result i32)
		call $configure drop
		i32.const 0x5eed i32.const 0 f32.const 1024 f32.const 768 call $init_playable drop
		call $host_reset_frame
		call $render)
	(func (export "render_start_gate") (result i32)
		call $configure drop
		i32.const 0x5eed i32.const 0 f32.const 1024 f32.const 768 call $init drop
		call $host_reset_frame
		call $render)
	(func (export "render_resume_gate") (result i32)
		call $configure drop
		i32.const 0x5eed i32.const 0 f32.const 1024 f32.const 768 call $init_playable drop
		i32.const 8 i32.const 0 f32.const 0 f32.const 0 call $event drop
		call $host_reset_frame
		call $render)
	(func (export "render_game_over_gate") (result i32)
		call $configure drop
		i32.const 0x5eed i32.const 0 f32.const 1024 f32.const 768 call $init_playable drop
		i32.const 1124 i32.const 3 i32.store
		i32.const 1108 i32.const 1024 i32.store
		call $host_reset_frame
		call $render)
	(func (export "render_start_gate_twice") (result i32)
		call $configure drop
		i32.const 0x5eed i32.const 0 f32.const 1024 f32.const 768 call $init drop
		call $host_reset_frame
		call $render drop
		call $render)
	(func (export "render_resized_start_gate") (result i32)
		call $configure drop
		i32.const 0x5eed i32.const 0 f32.const 1024 f32.const 768 call $init drop
		call $render drop
		i32.const 6 i32.const 0 f32.const 1200 f32.const 900 call $event drop
		call $host_reset_frame
		call $render)
	(func (export "render_dismissed_start_gate") (result i32)
		call $configure drop
		i32.const 0x5eed i32.const 0 f32.const 1024 f32.const 768 call $init drop
		call $render drop
		i32.const 1 i32.const 3 f32.const 0 f32.const 0 call $event drop
		call $host_reset_frame
		call $render)
	(func (export "render_thrust") (result i32)
		call $configure drop
		i32.const 0x5eed i32.const 0 f32.const 1024 f32.const 768 call $init_playable drop
		i32.const 1 i32.const 3 f32.const 0 f32.const 0 call $event drop
		call $host_reset_frame
		call $render)
	(func (export "state_i64") (param $offset i32) (result i64)
		i32.const 1024 local.get $offset i32.add i64.load)
	(func (export "state_i64_absolute") (param $offset i32) (result i64)
		i32.const 1024 local.get $offset i32.add i64.load call $abs_i64)
	(func (export "state_i32") (param $offset i32) (result i32)
		i32.const 1024 local.get $offset i32.add i32.load)
	(func (export "data_u16") (param $address i32) (result i32)
		local.get $address i32.load16_u)
	(func (export "data_u8") (param $address i32) (result i32)
		local.get $address i32.load8_u)
	(func (export "state_set_i64") (param $offset i32) (param $value i64)
		i32.const 1024 local.get $offset i32.add local.get $value i64.store)
	(func (export "state_set_i32") (param $offset i32) (param $value i32)
		i32.const 1024 local.get $offset i32.add local.get $value i32.store)
	(func (export "state_i32_between") (param $offset i32) (param $minimum i32)
		(param $maximum i32) (result i32)
		(local $value i32)
		i32.const 1024 local.get $offset i32.add i32.load local.set $value
		local.get $value local.get $minimum i32.ge_s
		local.get $value local.get $maximum i32.le_s i32.and)
	(func (export "state_i32_is_either") (param $offset i32) (param $first i32)
		(param $second i32) (result i32)
		(local $value i32)
		i32.const 1024 local.get $offset i32.add i32.load local.set $value
		local.get $value local.get $first i32.eq
		local.get $value local.get $second i32.eq i32.or)
	(func (export "state_i64_positive") (param $offset i32) (result i32)
		i32.const 1024 local.get $offset i32.add i64.load i64.const 0 i64.gt_s)
	(func (export "state_i64_negative") (param $offset i32) (result i32)
		i32.const 1024 local.get $offset i32.add i64.load i64.const 0 i64.lt_s)
	(func (export "state_i64_between") (param $offset i32) (param $minimum i64)
		(param $maximum i64) (result i32)
		(local $value i64)
		i32.const 1024 local.get $offset i32.add i64.load local.set $value
		local.get $value local.get $minimum i64.ge_s
		local.get $value local.get $maximum i64.le_s i32.and)
	(func (export "active_count") (param $base i32) (param $stride i32) (param $capacity i32) (result i32)
		(local $index i32) (local $count i32)
		(block $done (loop $again
			local.get $index local.get $capacity i32.ge_u br_if $done
			i32.const 1024 local.get $base i32.add local.get $index local.get $stride i32.mul i32.add i32.load
			(if (then local.get $count i32.const 1 i32.add local.set $count))
			local.get $index i32.const 1 i32.add local.set $index br $again))
		local.get $count)
	(func (export "active_at_least") (param $base i32) (param $stride i32) (param $capacity i32) (param $minimum i32) (result i32)
		(local $index i32) (local $count i32)
		(block $done (loop $again
			local.get $index local.get $capacity i32.ge_u br_if $done
			i32.const 1024 local.get $base i32.add local.get $index local.get $stride i32.mul i32.add i32.load
			(if (then local.get $count i32.const 1 i32.add local.set $count))
			local.get $index i32.const 1 i32.add local.set $index br $again))
		local.get $count local.get $minimum i32.ge_u)
	(func (export "clear_active") (param $base i32) (param $stride i32) (param $capacity i32)
		(local $index i32)
		(block $done (loop $again
			local.get $index local.get $capacity i32.ge_u br_if $done
			i32.const 1024 local.get $base i32.add local.get $index local.get $stride i32.mul i32.add i32.const 0 i32.store
			local.get $index i32.const 1 i32.add local.set $index br $again)))
	(func (export "fill_active") (param $base i32) (param $stride i32) (param $capacity i32)
		(local $index i32)
		(block $done (loop $again
			local.get $index local.get $capacity i32.ge_u br_if $done
			i32.const 1024 local.get $base i32.add local.get $index local.get $stride i32.mul i32.add i32.const 1 i32.store
			local.get $index i32.const 1 i32.add local.set $index br $again)))
	;; Spawn-safety fixtures clear the whole rock pool, then construct explicit
	;; trajectory sets without calling production RNG or collision helpers.
	(func $clear_test_asteroids
		i32.const 4352 i32.const 0 i32.const 2560 memory.fill)
	(func $place_test_asteroid
		(param $index i32) (param $x i64) (param $y i64) (param $radius i64)
		(local $address i32)
		i32.const 4352 local.get $index i32.const 80 i32.mul i32.add local.set $address
		local.get $address i32.const 1 i32.store
		local.get $address i32.const 16 i32.add local.get $x i64.store
		local.get $address i32.const 24 i32.add local.get $y i64.store
		local.get $address i32.const 32 i32.add i64.const 0 i64.store
		local.get $address i32.const 40 i32.add i64.const 0 i64.store
		local.get $address i32.const 48 i32.add local.get $radius i64.store)
	(func $begin_spawn_fixture (param $seed i32)
		call $configure drop
		local.get $seed i32.const 0 f32.const 1024 f32.const 768
		call $init_playable drop
		call $clear_test_asteroids)
	(func $place_safe_decoy
		i32.const 1 i64.const 512000000 i64.const 384000000 i64.const 5000000
		call $place_test_asteroid)
	(func (export "fill_safe_decoy_asteroids") (param $count i32)
		(local $index i32)
		(block $done (loop $again
			local.get $index local.get $count i32.ge_u br_if $done
			local.get $index i64.const 512000000 i64.const 384000000 i64.const 5000000
			call $place_test_asteroid
			local.get $index i32.const 1 i32.add local.set $index
			br $again)))

	;; Classifies a set of UFO entry trajectories: a decoy-only set is safe, a
	;; current overlap and a future crossing defer, and the one-second retry bound
	;; admits a newly safe candidate without polling on every fixed tick.
	(func (export "ufo_spawn_safety_cases") (result i32)
		(local $candidate_x i64) (local $candidate_y i64)
		(local $direction i32) (local $mask i32)
		i32.const 0x51afe call $begin_spawn_fixture
		call $place_safe_decoy
		i32.const 16512 i32.const 1 i32.store
		i32.const 1 call $tick drop
		i32.const 16032 i32.load
		(if (then local.get $mask i32.const 1 i32.or local.set $mask))
		i32.const 16040 i64.load local.set $candidate_x
		i32.const 16048 i64.load local.set $candidate_y
		i32.const 16036 i32.load local.set $direction

		i32.const 0x51afe call $begin_spawn_fixture
		call $place_safe_decoy
		i32.const 0 local.get $candidate_x local.get $candidate_y i64.const 20000000
		call $place_test_asteroid
		i32.const 16512 i32.const 1 i32.store
		i32.const 1 call $tick drop
		i32.const 16032 i32.load i32.eqz
		i32.const 16512 i32.load i32.const 120 i32.eq i32.and
		(if (then local.get $mask i32.const 2 i32.or local.set $mask))

		i32.const 0x51afe call $begin_spawn_fixture
		call $place_safe_decoy
		i32.const 0
		local.get $candidate_x local.get $direction i64.extend_i32_s
		i64.const 100000000 i64.mul i64.add
		local.get $candidate_y i64.const 20000000 call $place_test_asteroid
		i32.const 16512 i32.const 1 i32.store
		i32.const 1 call $tick drop
		i32.const 16032 i32.load i32.eqz
		i32.const 16512 i32.load i32.const 120 i32.eq i32.and
		(if (then local.get $mask i32.const 4 i32.or local.set $mask))
		i32.const 119 call $tick drop
		i32.const 16032 i32.load i32.eqz
		i32.const 16512 i32.load i32.const 1 i32.eq i32.and
		i32.const 4352 i32.const 0 i32.store
		i32.const 1 call $tick drop
		i32.const 16032 i32.load i32.eqz i32.eqz i32.and
		(if (then local.get $mask i32.const 8 i32.or local.set $mask))
		local.get $mask)

	;; Voyager uses the same set classifier and retry bound at its larger hull
	;; radius and lower traversal speed. A 40-pixel offset remains a current
	;; overlap inside the asteroid wrap boundary; 110 pixels is future-only.
	(func (export "satellite_spawn_safety_cases") (result i32)
		(local $candidate_x i64) (local $candidate_y i64)
		(local $direction i32) (local $mask i32)
		i32.const 0x73a11 call $begin_spawn_fixture
		call $place_safe_decoy
		i32.const 26732 i32.const 1 i32.store
		i32.const 1 call $tick drop
		i32.const 26656 i32.load
		(if (then local.get $mask i32.const 1 i32.or local.set $mask))
		i32.const 26664 i64.load local.set $candidate_x
		i32.const 26672 i64.load local.set $candidate_y
		i32.const 26660 i32.load local.set $direction

		i32.const 0x73a11 call $begin_spawn_fixture
		call $place_safe_decoy
		i32.const 0
		local.get $candidate_x local.get $direction i64.extend_i32_s
		i64.const 40000000 i64.mul i64.add
		local.get $candidate_y i64.const 20000000 call $place_test_asteroid
		i32.const 26732 i32.const 1 i32.store
		i32.const 1 call $tick drop
		i32.const 26656 i32.load i32.eqz
		i32.const 26732 i32.load i32.const 120 i32.eq i32.and
		(if (then local.get $mask i32.const 2 i32.or local.set $mask))

		i32.const 0x73a11 call $begin_spawn_fixture
		call $place_safe_decoy
		i32.const 0
		local.get $candidate_x local.get $direction i64.extend_i32_s
		i64.const 110000000 i64.mul i64.add
		local.get $candidate_y i64.const 20000000 call $place_test_asteroid
		i32.const 26732 i32.const 1 i32.store
		i32.const 1 call $tick drop
		i32.const 26656 i32.load i32.eqz
		i32.const 26732 i32.load i32.const 120 i32.eq i32.and
		(if (then local.get $mask i32.const 4 i32.or local.set $mask))
		i32.const 119 call $tick drop
		i32.const 26656 i32.load i32.eqz
		i32.const 26732 i32.load i32.const 1 i32.eq i32.and
		i32.const 4352 i32.const 0 i32.store
		i32.const 1 call $tick drop
		i32.const 26656 i32.load i32.eqz i32.eqz i32.and
		(if (then local.get $mask i32.const 8 i32.or local.set $mask))
		local.get $mask)
	;; Fills the 64-slot legacy region with real, slowly moving projectiles so a
	;; pool-capacity fixture does not depend on inert records surviving a tick.
	(func (export "fill_legacy_bullet_pool")
		(local $index i32) (local $address i32)
		(block $done (loop $again
			local.get $index i32.const 64 i32.ge_u br_if $done
			i32.const 1280 local.get $index i32.const 48 i32.mul i32.add local.set $address
			local.get $address i32.const 1 i32.store
			local.get $address i32.const 24 i32.add i64.const 1000000 i64.store
			local.get $address i32.const 32 i32.add i64.const 0 i64.store
			local.get $index i32.const 1 i32.add local.set $index br $again)))
	;; Builds the smallest real scoring collision used to exercise production
	;; extra-life accounting without exposing an otherwise-private score helper.
	(func (export "hit_terminal_asteroid_at_score") (param $score i32) (result i32)
		i32.const 1096 local.get $score i32.store
		i32.const 4352 i32.const 1 i32.store
		i32.const 4368 i64.const 200000000 i64.store
		i32.const 4376 i64.const 200000000 i64.store
		i32.const 4384 i64.const 0 i64.store
		i32.const 4392 i64.const 0 i64.store
		i32.const 4400 i64.const 20000000 i64.store
		i32.const 1280 i32.const 1 i32.store
		i32.const 1288 i64.const 200000000 i64.store
		i32.const 1296 i64.const 200000000 i64.store
		i32.const 1304 i64.const 0 i64.store
		i32.const 1312 i64.const 0 i64.store
		i32.const 1 call $tick)
	(func (export "state_bits") (param $offset i32) (param $mask i32) (result i32)
		i32.const 1024 local.get $offset i32.add i32.load local.get $mask i32.and i32.eqz i32.eqz)
	(func (export "event") (param $kind i32) (param $code i32) (result i32)
		local.get $kind local.get $code f32.const 0 f32.const 0 call $event)
	(func (export "pointer_event") (param $kind i32) (param $code i32)
		(param $x f32) (param $y f32) (result i32)
		local.get $kind local.get $code local.get $x local.get $y call $event)
	(func (export "touch_event") (param $kind i32) (param $contact_id i32)
		(param $x f32) (param $y f32) (result i32)
		local.get $kind local.get $contact_id local.get $x local.get $y call $event)
	(func (export "device_change") (param $flags i32) (param $width f32)
		(param $height f32) (result i32)
		i32.const 6 local.get $flags local.get $width local.get $height call $event)
	(func (export "viewport") (param $width f32) (param $height f32) (result i32)
		i32.const 6 i32.const 0 local.get $width local.get $height call $event)
	;; Compares the rendered blast against itself at two equal-area viewports.
	;; This catches a return to diagonal scaling without transcribing a radius.
	(func (export "blast_matches_across_equal_area")
		(param $first_width f32) (param $first_height f32)
		(param $second_width f32) (param $second_height f32) (result i32)
		(local $first f32)
		call $configure drop
		i32.const 0x5eed i32.const 0 local.get $first_width local.get $first_height
		call $init_playable drop
		i32.const 26624 i32.const 1 i32.store
		i32.const 26632 i64.const 100000000 i64.store
		i32.const 26640 i64.const 100000000 i64.store
		i32.const 26648 i32.const 72 i32.store
		call $host_reset_frame
		call $render drop
		call $host_blast_radius local.set $first
		i32.const 6 i32.const 0 local.get $second_width local.get $second_height
		call $event drop
		call $host_reset_frame
		call $render drop
		local.get $first call $host_blast_radius f32.eq)
	;; Mixes the whole star field into one value so two layouts can be compared
	;; without scratch memory. The multiplier makes the accumulator order- and
	;; position-sensitive, so a moved star cannot cancel against another.
	(func $star_field_checksum (result i64)
		(local $index i32) (local $address i32) (local $checksum i64)
		(block $done
			(loop $again
				local.get $index i32.const 100 i32.ge_u br_if $done
				i32.const 14432 local.get $index i32.const 16 i32.mul i32.add
				local.set $address
				local.get $checksum i64.const 31 i64.mul
				local.get $address i64.load i64.add local.set $checksum
				local.get $checksum i64.const 31 i64.mul
				local.get $address i32.const 8 i32.add i64.load i64.add
				local.set $checksum
				local.get $index i32.const 1 i32.add local.set $index br $again))
		local.get $checksum)
	;; A star field generated from a deterministic PRNG must depend on the world
	;; seed. Passing one seed twice is the paired specificity case: it must
	;; report no difference, so a checksum that simply always differed could not
	;; be mistaken for the fix.
	(func (export "star_field_differs_across_seeds")
		(param $first i32) (param $second i32) (result i32)
		(local $first_checksum i64)
		local.get $first i32.const 0 f32.const 1024 f32.const 768 call $init_playable drop
		call $star_field_checksum local.set $first_checksum
		local.get $second i32.const 0 f32.const 1024 f32.const 768 call $init_playable drop
		local.get $first_checksum call $star_field_checksum i64.ne)
	;; Counts consecutive stars whose horizontal step repeats the first one. An
	;; arithmetic generator puts every star on one lattice and scores near 99; a
	;; PRNG scores near zero. This is the visible defect Peter reported, that the
	;; field reads as diagonal banding rather than as scattered sky.
	;; The boot gate is a flag rather than a lifecycle value, because the world
	;; behind it must keep advancing through the ordinary no-ship state.
	(func (export "gate_visible") (result i32)
		i32.const 1108 i32.load i32.const 1024 i32.and i32.const 0 i32.ne)
	(func (export "resume_gate_visible") (result i32)
		i32.const 1108 i32.load i32.const 2048 i32.and i32.const 0 i32.ne)
	;; Classifies whether the rock field actually advances across the given span,
	;; distinguishing an overlay from a pause. Any single rock moving is enough,
	;; and comparing a checksum avoids depending on which rock that is.
	(func (export "asteroids_moved_during") (param $ticks i32) (result i32)
		(local $index i32) (local $before i64) (local $after i64)
		call $asteroid_position_checksum local.set $before
		local.get $ticks call $tick_source drop
		local.get $before call $asteroid_position_checksum i64.ne)
	(func $asteroid_position_checksum (result i64)
		(local $index i32) (local $address i32) (local $checksum i64)
		(block $done
			(loop $again
				local.get $index i32.const 32 i32.ge_u br_if $done
				i32.const 1024 i32.const 3328 i32.add
				local.get $index i32.const 80 i32.mul i32.add local.set $address
				local.get $checksum i64.const 31 i64.mul
				local.get $address i32.const 16 i32.add i64.load i64.add local.set $checksum
				local.get $checksum i64.const 31 i64.mul
				local.get $address i32.const 24 i32.add i64.load i64.add local.set $checksum
				local.get $index i32.const 1 i32.add local.set $index br $again))
		local.get $checksum)
	(func (export "star_repeated_step_pairs") (result i32)
		(local $index i32) (local $step i64) (local $count i32)
		i32.const 14448 i64.load i32.const 14432 i64.load i64.sub local.set $step
		i32.const 1 local.set $index
		(block $done
			(loop $again
				local.get $index i32.const 99 i32.ge_u br_if $done
				i32.const 14432 local.get $index i32.const 1 i32.add
				i32.const 16 i32.mul i32.add i64.load
				i32.const 14432 local.get $index i32.const 16 i32.mul i32.add i64.load
				i64.sub local.get $step i64.eq
				(if (then local.get $count i32.const 1 i32.add local.set $count))
				local.get $index i32.const 1 i32.add local.set $index br $again))
		local.get $count)
	;; Converts source-authored 60-Hz fixture durations into the production
	;; rational rate while leaving the guest's raw AE_tick contract untouched.
	(func $tick_source (param $source_ticks i32) (result i32)
		(local $numerator i32) (local $denominator i32)
		i32.const 0 i32.const 0 call $tick_rate
		local.set $denominator local.set $numerator
		local.get $source_ticks i64.extend_i32_u local.get $numerator i64.extend_i32_u i64.mul
		i64.const 60 local.get $denominator i64.extend_i32_u i64.mul i64.div_u
		i32.wrap_i64 call $tick)
	(func (export "tick") (param $source_ticks i32) (result i32)
		local.get $source_ticks call $tick_source)
	(func (export "raw_tick") (param $ticks i32) (result i32)
		local.get $ticks call $tick)
	(func (export "render") (result i32) call $render)
	(func (export "host_reset_frame") call $host_reset_frame)
	(func (export "host_reset_effects") call $host_reset_effects)
	(func (export "host_title_ptr") (result i32) call $host_title_ptr)
	(func (export "host_title_len") (result i32) call $host_title_len)
	(func (export "host_menu_count") (result i32) call $host_menu_count)
	(func (export "host_menu_seen") (param i32) (result i32) local.get 0 call $host_menu_seen)
	(func (export "host_action_count") (result i32) call $host_action_count)
	(func (export "host_action_seen") (param i32) (result i32) local.get 0 call $host_action_seen)
	(func (export "host_action_declaration_errors") (result i32) call $host_action_declaration_errors)
	(func (export "host_synth_count") (param i32) (result i32) local.get 0 call $host_synth_count)
	(func (export "host_invalid_synth_voices") (result i32) call $host_invalid_synth_voices)
	(func (export "host_short_boom_voices") (result i32) call $host_short_boom_voices)
	(func (export "host_satellite_ping_valid") (result i32) call $host_satellite_ping_valid)
	(func (export "host_thrust_rumble_valid") (result i32) call $host_thrust_rumble_valid)
	(func (export "host_synth_signature") (result i64) call $host_synth_signature)
	(func (export "host_frame_count") (result i32) call $host_frame_count)
	(func (export "host_flash_frames") (result i32) call $host_flash_frames)
	(func (export "host_duplicate_stable_ids") (result i32) call $host_duplicate_stable_ids)
	(func (export "host_first_duplicate_stable_id") (result i32) call $host_first_duplicate_stable_id)
	(func (export "host_first_invalid_circle_id") (result i32)
		call $host_first_invalid_circle_id)
	(func (export "host_text_seen") (param i32) (result i32) local.get 0 call $host_text_seen)
	(func (export "host_asteroid_paths") (result i32) call $host_asteroid_paths)
	(func (export "host_bad_asteroid_vertices") (result i32) call $host_bad_asteroid_vertices)
	(func (export "host_asteroid_circles") (result i32) call $host_asteroid_circles)
	(func (export "host_reserve_paths") (result i32) call $host_reserve_paths)
	(func (export "host_main_ship_paths") (result i32) call $host_main_ship_paths)
	(func (export "host_reserve_count_text_valid") (result i32) call $host_reserve_count_text_valid)
	(func (export "host_star_circles") (result i32) call $host_star_circles)
	(func (export "host_ufo_paths") (result i32) call $host_ufo_paths)
	(func (export "host_enemy_bullet_circles") (result i32) call $host_enemy_bullet_circles)
	(func (export "host_package_paths") (result i32) call $host_package_paths)
	(func (export "host_package_bow_paths") (result i32)
		call $host_package_bow_paths)
	(func (export "host_package_bow_knots") (result i32)
		call $host_package_bow_knots)
	(func (export "host_satellite_paths") (result i32) call $host_satellite_paths)
	(func (export "host_satellite_lines") (result i32) call $host_satellite_lines)
	(func (export "host_satellite_circles") (result i32) call $host_satellite_circles)
	(func (export "host_satellite_connected_booms") (result i32) call $host_satellite_connected_booms)
	(func (export "host_satellite_footprint_valid") (result i32) call $host_satellite_footprint_valid)
	(func (export "host_satellite_glow_radius") (result f32) call $host_satellite_glow_radius)
	(func (export "host_laser_lines") (result i32) call $host_laser_lines)
	(func (export "host_blossom_marks") (result i32) call $host_blossom_marks)
	(func (export "host_blossom_help_valid") (result i32) call $host_blossom_help_valid)
	(func (export "host_help_copy_mask") (result i32) call $host_help_copy_mask)
	(func (export "host_touch_help_copy_mask") (result i32)
		call $host_touch_help_copy_mask)
	(func (export "host_help_frame_lines") (result i32) call $host_help_frame_lines)
	(func (export "host_gate_copy_kind") (result i32) call $host_gate_copy_kind)
	(func (export "host_gate_border_lines") (result i32) call $host_gate_border_lines)
	(func (export "host_game_over_gate_separated") (result i32) call $host_game_over_gate_separated)
	(func (export "host_ui_snapshot_count") (result i32) call $host_ui_snapshot_count)
	(func (export "host_ui_panel_count") (result i32) call $host_ui_panel_count)
	(func (export "host_ui_button_count") (result i32) call $host_ui_button_count)
	(func (export "host_ui_button_action") (result i32) call $host_ui_button_action)
	(func (export "host_ui_button_geometry_valid") (param i32) (result i32)
		local.get 0 call $host_ui_button_geometry_valid)
	(func (export "host_help_columns_valid") (result i32) call $host_help_columns_valid)
	(func (export "host_help_fits_height") (param f32) (result i32)
		local.get 0 call $host_help_fits_height)
	(func (export "host_help_max_y") (result f32) call $host_help_max_y)
	(func (export "host_help_pointer_gap_valid") (result i32)
		call $host_help_pointer_gap_valid)
	(func (export "host_help_stacked_valid") (result i32)
		call $host_help_stacked_valid)
	(func (export "host_help_keyboard_alias_copy_mask") (result i32)
		call $host_help_keyboard_alias_copy_mask)
	(func (export "host_power_hud_kind") (result i32) call $host_power_hud_kind)
	(func (export "host_power_hud_text_valid") (result i32) call $host_power_hud_text_valid)
	(func (export "host_power_hud_text_y") (result f32) call $host_power_hud_text_y)
	(func (export "host_power_hud_primitives") (result i32) call $host_power_hud_primitives)
	(func (export "host_blast_circles") (result i32) call $host_blast_circles)
	(func (export "host_blast_radius") (result f32) call $host_blast_radius)
	(func (export "host_flame_min_x") (result f32) call $host_flame_min_x)
	(func (export "host_audio_seen") (param i32) (result i32) local.get 0 call $host_audio_seen)
	(func (export "host_audio_count") (param i32) (result i32) local.get 0 call $host_audio_count)
	(func (export "host_thrust_audio_valid") (result i32) call $host_thrust_audio_valid)
	(func (export "host_sample_asset_valid") (result i32) call $host_sample_asset_valid)
	(func (export "host_sample_play_count") (result i32) call $host_sample_play_count)
	(func (export "host_sample_play_valid") (result i32) call $host_sample_play_valid)
	(func (export "host_effect_seen") (param i32) (result i32) local.get 0 call $host_effect_seen)
	(func (export "host_bullet_circles") (result i32) call $host_bullet_circles)
	(func $abs_i64 (param $value i64) (result i64)
		local.get $value i64.const 0 i64.lt_s
		(if (result i64) (then i64.const 0 local.get $value i64.sub) (else local.get $value)))
	(func $state_hash_from (param $offset i32) (param $words i32) (result i64)
		(local $index i32) (local $hash i64)
		i64.const -3750763034362895579 local.set $hash
		(block $done (loop $again
			local.get $index local.get $words i32.ge_u br_if $done
			local.get $hash
			i32.const 1024 local.get $offset i32.add local.get $index i32.const 4 i32.mul i32.add i32.load i64.extend_i32_u
			i64.xor i64.const 1099511628211 i64.mul local.set $hash
			local.get $index i32.const 1 i32.add local.set $index br $again))
		local.get $hash)
	(func (export "render_is_state_pure") (result i32)
		(local $before i64)
		call $configure drop
		i32.const 0x5eed i32.const 0 f32.const 1024 f32.const 768 call $init_playable drop
		i32.const 0 i32.const 8192 call $state_hash_from local.set $before
		call $render drop
		i32.const 0 i32.const 8192 call $state_hash_from local.get $before i64.eq)
	(func (export "deterministic_input_replay") (result i32)
		(local $before i64)
		call $configure drop
		i32.const 0x5eed i32.const 0 f32.const 1024 f32.const 768 call $init_playable drop
		i32.const 1 i32.const 2 f32.const 0 f32.const 0 call $event drop
		i32.const 1 i32.const 3 f32.const 0 f32.const 0 call $event drop
		i32.const 30 call $tick drop
		i32.const 2 i32.const 3 f32.const 0 f32.const 0 call $event drop
		i32.const 2 i32.const 2 f32.const 0 f32.const 0 call $event drop
		i32.const 0 i32.const 8192 call $state_hash_from local.set $before
		i32.const 0x5eed i32.const 0 f32.const 1024 f32.const 768 call $init_playable drop
		i32.const 1 i32.const 2 f32.const 0 f32.const 0 call $event drop
		i32.const 1 i32.const 3 f32.const 0 f32.const 0 call $event drop
		i32.const 30 call $tick drop
		i32.const 2 i32.const 3 f32.const 0 f32.const 0 call $event drop
		i32.const 2 i32.const 2 f32.const 0 f32.const 0 call $event drop
		i32.const 0 i32.const 8192 call $state_hash_from local.get $before i64.eq)
	(func (export "help_freezes_state") (result i32)
		(local $before i64)
		call $configure drop
		i32.const 0x5eed i32.const 0 f32.const 1024 f32.const 768 call $init_playable drop
		i32.const 7 i32.const 7 f32.const 0 f32.const 0 call $event drop
		i32.const 4 i32.const 8191 call $state_hash_from local.set $before
		i32.const 10 call $tick drop
		i32.const 4 i32.const 8191 call $state_hash_from local.get $before i64.eq)
	(func (export "pause_freezes_state") (result i32)
		(local $before i64)
		call $configure drop
		i32.const 0x5eed i32.const 0 f32.const 1024 f32.const 768 call $init_playable drop
		i32.const 1 i32.const 5 f32.const 0 f32.const 0 call $event drop
		i32.const 4 i32.const 8191 call $state_hash_from local.set $before
		i32.const 10 call $tick drop
		i32.const 4 i32.const 8191 call $state_hash_from local.get $before i64.eq)
	(func (export "seeded_fields_differ") (result i32)
		(local $x i64) (local $y i64)
		call $configure drop
		i32.const 1 i32.const 0 f32.const 1024 f32.const 768 call $init_playable drop
		i32.const 4368 i64.load local.set $x
		i32.const 4376 i64.load local.set $y
		i32.const 2 i32.const 0 f32.const 1024 f32.const 768 call $init_playable drop
		i32.const 4368 i64.load local.get $x i64.ne
		i32.const 4376 i64.load local.get $y i64.ne i32.or)
	(func (export "initial_asteroid_ranges_valid") (result i32)
		(local $seed i32) (local $index i32) (local $address i32)
		(local $radius i64) (local $spin i64) (local $saw_small i32) (local $saw_large i32) (local $saw_spin i32)
		i32.const 1 local.set $seed
		(block $seeds_done (loop $seeds
			local.get $seed i32.const 12 i32.gt_u br_if $seeds_done
			local.get $seed i32.const 0 f32.const 1024 f32.const 768 call $init_playable drop
			i32.const 0 local.set $index
			(block $rocks_done (loop $rocks
				local.get $index i32.const 5 i32.ge_u br_if $rocks_done
				i32.const 4352 local.get $index i32.const 80 i32.mul i32.add local.set $address
				local.get $address i32.const 48 i32.add i64.load local.set $radius
				local.get $radius i64.const 20000000 i64.lt_s (if (then i32.const 0 return))
				local.get $radius i64.const 50000000 i64.ge_s (if (then i32.const 0 return))
				local.get $radius i64.const 24000000 i64.lt_s (if (then i32.const 1 local.set $saw_small))
				local.get $radius i64.const 48000000 i64.gt_s (if (then i32.const 1 local.set $saw_large))
				local.get $address i32.const 72 i32.add i32.load i64.extend_i32_s local.tee $spin call $abs_i64
				i64.const 1000000 i64.gt_s (if (then i32.const 0 return))
				local.get $spin call $abs_i64 i64.const 60000 i64.gt_s (if (then i32.const 1 local.set $saw_spin))
				local.get $index i32.const 1 i32.add local.set $index br $rocks))
			local.get $seed i32.const 1 i32.add local.set $seed br $seeds))
		local.get $saw_small local.get $saw_large i32.and local.get $saw_spin i32.and)
	(func (export "initial_asteroid_velocities_valid") (result i32)
		(local $index i32) (local $address i32) (local $component i64)
		i32.const 0x5eed i32.const 0 f32.const 1024 f32.const 768 call $init_playable drop
		(block $done (loop $again
			local.get $index i32.const 5 i32.ge_u br_if $done
			i32.const 4352 local.get $index i32.const 80 i32.mul i32.add local.set $address
			local.get $address i32.const 32 i32.add i64.load call $abs_i64 local.set $component
			local.get $component i64.const 15000000 i64.lt_s (if (then i32.const 0 return))
			local.get $component i64.const 60000000 i64.gt_s (if (then i32.const 0 return))
			local.get $address i32.const 40 i32.add i64.load call $abs_i64 local.set $component
			local.get $component i64.const 15000000 i64.lt_s (if (then i32.const 0 return))
			local.get $component i64.const 60000000 i64.gt_s (if (then i32.const 0 return))
			local.get $index i32.const 1 i32.add local.set $index br $again))
		i32.const 1)
	(func (export "resize_invariants") (result i32)
		(local $rng i32) (local $asteroid_x i64) (local $asteroid_y i64) (local $star_x i64)
		call $configure drop
		i32.const 0x5eed i32.const 0 f32.const 1024 f32.const 768 call $init_playable drop
		i32.const 1028 i32.load local.set $rng
		i32.const 4368 i64.load local.set $asteroid_x
		i32.const 4376 i64.load local.set $asteroid_y
		i32.const 14432 i64.load local.set $star_x
		i32.const 1280 i32.const 1 i32.store
		i32.const 1288 i64.const 100000000 i64.store
		i32.const 1296 i64.const 200000000 i64.store
		i32.const 1304 i64.const 1234567 i64.store
		;; An active blast belongs to world space just like its snapshotted targets.
		i32.const 26624 i32.const 1 i32.store
		i32.const 26632 i64.const 300000000 i64.store
		i32.const 26640 i64.const 400000000 i64.store
		i32.const 6 i32.const 0 f32.const 1600 f32.const 900 call $event drop
		i32.const 1032 i64.load i64.const 1600000000 i64.ne (if (then i32.const 0 return))
		i32.const 1040 i64.load i64.const 900000000 i64.ne (if (then i32.const 0 return))
		i32.const 1048 i64.load i64.const 800000000 i64.ne (if (then i32.const 0 return))
		i32.const 1056 i64.load i64.const 450000000 i64.ne (if (then i32.const 0 return))
		i32.const 1288 i64.load i64.const 388000000 i64.ne (if (then i32.const 0 return))
		i32.const 1296 i64.load i64.const 266000000 i64.ne (if (then i32.const 0 return))
		i32.const 1304 i64.load i64.const 1234567 i64.ne (if (then i32.const 0 return))
		i32.const 4368 i64.load local.get $asteroid_x i64.const 288000000 i64.add i64.ne (if (then i32.const 0 return))
		i32.const 4376 i64.load local.get $asteroid_y i64.const 66000000 i64.add i64.ne (if (then i32.const 0 return))
		i32.const 26632 i64.load i64.const 588000000 i64.ne (if (then i32.const 0 return))
		i32.const 26640 i64.load i64.const 466000000 i64.ne (if (then i32.const 0 return))
		i32.const 1028 i32.load local.get $rng i32.ne (if (then i32.const 0 return))
		i32.const 14432 i64.load local.get $star_x i64.eq (if (then i32.const 0 return))
		i32.const 1)
	(func (export "radius_count") (param $radius i64) (result i32)
		(local $index i32) (local $address i32) (local $count i32)
		(block $done (loop $again
			local.get $index i32.const 32 i32.ge_u br_if $done
			i32.const 4352 local.get $index i32.const 80 i32.mul i32.add local.set $address
			local.get $address i32.load
			local.get $address i32.const 48 i32.add i64.load local.get $radius i64.eq i32.and
			(if (then local.get $count i32.const 1 i32.add local.set $count))
			local.get $index i32.const 1 i32.add local.set $index br $again))
		local.get $count)
	(func (export "radius_components_within") (param $radius i64) (param $maximum i64) (result i32)
		(local $index i32) (local $address i32)
		(block $done (loop $again
			local.get $index i32.const 32 i32.ge_u br_if $done
			i32.const 4352 local.get $index i32.const 80 i32.mul i32.add local.set $address
			local.get $address i32.load
			local.get $address i32.const 48 i32.add i64.load local.get $radius i64.eq i32.and
			(if (then
				local.get $address i32.const 32 i32.add i64.load call $abs_i64 local.get $maximum i64.gt_s
				local.get $address i32.const 40 i32.add i64.load call $abs_i64 local.get $maximum i64.gt_s i32.or
				(if (then i32.const 0 return))))
			local.get $index i32.const 1 i32.add local.set $index br $again))
		i32.const 1)
	(func (export "split_at_level") (param $level i32) (result i32)
		call $configure drop
		i32.const 0x5eed i32.const 0 f32.const 1024 f32.const 768 call $init_playable drop
		i32.const 1104 local.get $level i32.store
		i32.const 4368 i64.const 200000000 i64.store
		i32.const 4376 i64.const 200000000 i64.store
		i32.const 4384 i64.const 600000000 i64.store
		i32.const 4392 i64.const 600000000 i64.store
		i32.const 4400 i64.const 40000000 i64.store
		i32.const 1280 i32.const 1 i32.store
		i32.const 1288 i64.const 210000000 i64.store
		i32.const 1296 i64.const 210000000 i64.store
		i32.const 1304 i64.const 0 i64.store
		i32.const 1312 i64.const 0 i64.store
		i32.const 1 call $tick)
	(func (export "explosion_advances_at_tick_rate") (result i32)
		(local $debris_x i64) (local $debris_vx i64) (local $particle_life i32)
		call $configure drop
		i32.const 0x5eed i32.const 0 f32.const 1024 f32.const 768 call $init_playable drop
		i32.const 1116 i32.const 0 i32.store
		i32.const 4368 i64.const 512000000 i64.store
		i32.const 4376 i64.const 384000000 i64.store
		i32.const 4384 i64.const 0 i64.store
		i32.const 4392 i64.const 0 i64.store
		i32.const 4400 i64.const 20000000 i64.store
		i32.const 1 call $tick drop
		i32.const 14120 i64.load local.set $debris_x
		i32.const 14136 i64.load local.set $debris_vx
		i32.const 6916 i32.load local.set $particle_life
		i32.const 1 call $tick drop
		i32.const 14120 i64.load local.get $debris_x local.get $debris_vx i64.const 120 i64.div_s i64.add i64.ne
		(if (then i32.const 0 return))
		i32.const 14136 i64.load local.get $debris_vx i64.const 995000 i64.mul i64.const 1000000 i64.div_s i64.ne
		(if (then i32.const 0 return))
		i32.const 6916 i32.load local.get $particle_life i32.const 1 i32.sub i32.ne
		(if (then i32.const 0 return))
		i32.const 1)
)

(assert_return (invoke $vibesteroids_tests "schema") (i32.const 11))
(assert_return (invoke $vibesteroids_tests "state_len") (i32.const 32768))
(assert_return
	(invoke $vibesteroids_tests "tick_rate" (i32.const 120) (i32.const 1))
	(i32.const 120) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 8)) (i64.const 1024000000))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 16)) (i64.const 768000000))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 24)) (i64.const 512000000))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 32)) (i64.const 384000000))

;; Schema 11 stores canonical per-second velocities while integrating at 120
;; Hz. The retired per-projectile countdown slot remains reserved and zero.
(assert_return (invoke $vibesteroids_tests "thrust_once") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 48)) (i64.const -2493750))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 32)) (i64.const 383979219))
(assert_return (invoke $vibesteroids_tests "fire_once") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 288)) (i64.const -337500000))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 296)) (i64.const 0))
(assert_return (invoke $vibesteroids_tests "drag_once") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 40)) (i64.const 2493750))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 48)) (i64.const -1246875))

;; Configuration is application-owned: title, menus, and synth programs.
(assert_return (invoke $vibesteroids_tests "configure_only") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_title_ptr") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_title_len") (i32.const 20))
(assert_return (invoke $vibesteroids_tests "host_menu_count") (i32.const 4))
(assert_return (invoke $vibesteroids_tests "host_menu_seen" (i32.const 0)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_menu_seen" (i32.const 1)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_menu_seen" (i32.const 6)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_menu_seen" (i32.const 7)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_action_count") (i32.const 2))
(assert_return (invoke $vibesteroids_tests "host_action_seen" (i32.const 8)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_action_seen" (i32.const 9)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_action_declaration_errors") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_synth_count" (i32.const 1)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_synth_count" (i32.const 2)) (i32.const 2))
(assert_return (invoke $vibesteroids_tests "host_synth_count" (i32.const 3)) (i32.const 3))
(assert_return (invoke $vibesteroids_tests "host_synth_count" (i32.const 4)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_synth_count" (i32.const 5)) (i32.const 3))
(assert_return (invoke $vibesteroids_tests "host_synth_count" (i32.const 6)) (i32.const 5))
(assert_return (invoke $vibesteroids_tests "host_synth_count" (i32.const 7)) (i32.const 2))
(assert_return (invoke $vibesteroids_tests "host_synth_count" (i32.const 8)) (i32.const 2))
(assert_return (invoke $vibesteroids_tests "host_synth_count" (i32.const 9)) (i32.const 2))
(assert_return (invoke $vibesteroids_tests "host_synth_count" (i32.const 10)) (i32.const 3))
(assert_return (invoke $vibesteroids_tests "host_synth_count" (i32.const 11)) (i32.const 2))
(assert_return (invoke $vibesteroids_tests "host_synth_count" (i32.const 12)) (i32.const 3))
(assert_return (invoke $vibesteroids_tests "host_synth_count" (i32.const 13)) (i32.const 3))
(assert_return (invoke $vibesteroids_tests "host_satellite_ping_valid") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_thrust_rumble_valid") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_sample_asset_valid") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_short_boom_voices") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_invalid_synth_voices") (i32.const 0))
(assert_return
	(invoke $vibesteroids_tests "host_synth_signature")
	(i64.const 7053023749173270469))

;; The initial frame is a real vector game scene, not the former circle demo.
(assert_return (invoke $vibesteroids_tests "render_initial") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_frame_count") (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_duplicate_stable_ids") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_text_seen" (i32.const 10)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_text_seen" (i32.const 20)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_text_seen" (i32.const 24)) (i32.const 1))
(assert_return (invoke $vibesteroids_tests "host_asteroid_paths") (i32.const 5))
(assert_return (invoke $vibesteroids_tests "host_bad_asteroid_vertices") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_asteroid_circles") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_reserve_paths") (i32.const 2))
(assert_return (invoke $vibesteroids_tests "host_star_circles") (i32.const 100))
(assert_return (invoke $vibesteroids_tests "host_satellite_paths") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_satellite_circles") (i32.const 0))

;; Thruster output remains behind the local-space hull tail at x=-10.
(assert_return (invoke $vibesteroids_tests "render_thrust") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_flame_min_x") (f32.const -12))
