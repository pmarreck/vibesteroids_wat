;; Deterministic, instrumented implementation of the generic Aedicule host
;; imports. Production behavior is exercised without a Rust test runner, while
;; query exports let companion WAST modules assert guest-emitted effects.
(module $aedicule_v0
	(memory $stable_ids 1)
	(global $title_ptr (mut i32) (i32.const 0))
	(global $title_len (mut i32) (i32.const 0))
	(global $menu_count (mut i32) (i32.const 0))
	(global $menu_mask (mut i32) (i32.const 0))
	(global $synth_1 (mut i32) (i32.const 0))
	(global $synth_2 (mut i32) (i32.const 0))
	(global $synth_3 (mut i32) (i32.const 0))
	(global $synth_4 (mut i32) (i32.const 0))
	(global $synth_5 (mut i32) (i32.const 0))
	(global $synth_6 (mut i32) (i32.const 0))
	(global $synth_7 (mut i32) (i32.const 0))
	(global $synth_8 (mut i32) (i32.const 0))
	(global $synth_9 (mut i32) (i32.const 0))
	(global $synth_10 (mut i32) (i32.const 0))
	(global $synth_11 (mut i32) (i32.const 0))
	(global $synth_12 (mut i32) (i32.const 0))
	(global $synth_13 (mut i32) (i32.const 0))
	(global $satellite_ping_mask (mut i32) (i32.const 0))
	(global $satellite_ping_errors (mut i32) (i32.const 0))
	(global $short_boom_voices (mut i32) (i32.const 0))
	(global $invalid_synth_voices (mut i32) (i32.const 0))
	(global $synth_signature (mut i64) (i64.const -3750763034362895579))
	(global $frame_count (mut i32) (i32.const 0))
	(global $flash_frames (mut i32) (i32.const 0))
	(global $stable_id_count (mut i32) (i32.const 0))
	(global $duplicate_stable_ids (mut i32) (i32.const 0))
	(global $first_duplicate_stable_id (mut i32) (i32.const -1))
	(global $geometry_errors (mut i32) (i32.const 0))
	(global $lifecycle_errors (mut i32) (i32.const 0))
	(global $frame_open (mut i32) (i32.const 0))
	(global $path_open (mut i32) (i32.const 0))
	(global $transform_depth (mut i32) (i32.const 0))
	(global $text_mask (mut i64) (i64.const 0))
	(global $audio_mask (mut i32) (i32.const 0))
	(global $sample_asset_count (mut i32) (i32.const 0))
	(global $sample_asset_valid (mut i32) (i32.const 0))
	(global $sample_play_count (mut i32) (i32.const 0))
	(global $sample_play_valid (mut i32) (i32.const 0))
	(global $effect_mask (mut i32) (i32.const 0))
	(global $asteroid_paths (mut i32) (i32.const 0))
	(global $bad_asteroid_vertices (mut i32) (i32.const 0))
	(global $asteroid_circles (mut i32) (i32.const 0))
	(global $reserve_paths (mut i32) (i32.const 0))
	(global $reserve_count_text_valid (mut i32) (i32.const 0))
	(global $bullet_circles (mut i32) (i32.const 0))
	(global $star_circles (mut i32) (i32.const 0))
	(global $ufo_paths (mut i32) (i32.const 0))
	(global $enemy_bullet_circles (mut i32) (i32.const 0))
	(global $package_paths (mut i32) (i32.const 0))
	(global $satellite_paths (mut i32) (i32.const 0))
	(global $satellite_lines (mut i32) (i32.const 0))
	(global $satellite_circles (mut i32) (i32.const 0))
	(global $satellite_connected_booms (mut i32) (i32.const 0))
	(global $satellite_min_x (mut f32) (f32.const 10000))
	(global $satellite_max_x (mut f32) (f32.const -10000))
	(global $satellite_min_y (mut f32) (f32.const 10000))
	(global $satellite_max_y (mut f32) (f32.const -10000))
	(global $satellite_glow_radius (mut f32) (f32.const 0))
	(global $laser_lines (mut i32) (i32.const 0))
	(global $blossom_marks (mut i32) (i32.const 0))
	(global $blossom_help_valid (mut i32) (i32.const 0))
	(global $help_copy_mask (mut i32) (i32.const 0))
	(global $help_frame_lines (mut i32) (i32.const 0))
	(global $help_column_inputs (mut i32) (i32.const 0))
	(global $help_column_actions (mut i32) (i32.const 0))
	(global $help_column_errors (mut i32) (i32.const 0))
	(global $help_max_y (mut f32) (f32.const 0))
	(global $help_pointer_input_x (mut f32) (f32.const 0))
	(global $help_pointer_action_x (mut f32) (f32.const 0))
	(global $power_hud_kind (mut i32) (i32.const -1))
	(global $power_hud_text_valid (mut i32) (i32.const 0))
	(global $power_hud_primitives (mut i32) (i32.const 0))
	(global $blast_circles (mut i32) (i32.const 0))
	(global $blast_radius (mut f32) (f32.const 0))
	(global $current_path_key (mut i32) (i32.const -1))
	(global $current_path_moves (mut i32) (i32.const 0))
	(global $current_path_lines (mut i32) (i32.const 0))
	(global $flame_min_x (mut f32) (f32.const 0))

	(func (export "test_reset_config")
		i32.const 0 global.set $title_ptr
		i32.const 0 global.set $title_len
		i32.const 0 global.set $menu_count
		i32.const 0 global.set $menu_mask
		i32.const 0 global.set $synth_1
		i32.const 0 global.set $synth_2
		i32.const 0 global.set $synth_3
		i32.const 0 global.set $synth_4
		i32.const 0 global.set $synth_5
		i32.const 0 global.set $synth_6
		i32.const 0 global.set $synth_7
		i32.const 0 global.set $synth_8
		i32.const 0 global.set $synth_9
		i32.const 0 global.set $synth_10
		i32.const 0 global.set $synth_11
		i32.const 0 global.set $synth_12
		i32.const 0 global.set $synth_13
		i32.const 0 global.set $satellite_ping_mask
		i32.const 0 global.set $satellite_ping_errors
		i32.const 0 global.set $short_boom_voices
		i32.const 0 global.set $invalid_synth_voices
		i32.const 0 global.set $sample_asset_count
		i32.const 0 global.set $sample_asset_valid
		i64.const -3750763034362895579 global.set $synth_signature)
	(func (export "test_reset_frame")
		i32.const 0 global.set $frame_count
		i32.const 0 global.set $flash_frames
		i32.const 0 global.set $stable_id_count
		i32.const 0 global.set $duplicate_stable_ids
		i32.const -1 global.set $first_duplicate_stable_id
		i32.const 0 global.set $geometry_errors
		i32.const 0 global.set $lifecycle_errors
		i32.const 0 global.set $frame_open
		i32.const 0 global.set $path_open
		i32.const 0 global.set $transform_depth
		i64.const 0 global.set $text_mask
		i32.const 0 global.set $asteroid_paths
		i32.const 0 global.set $bad_asteroid_vertices
		i32.const 0 global.set $asteroid_circles
		i32.const 0 global.set $reserve_paths
		i32.const 0 global.set $reserve_count_text_valid
		i32.const 0 global.set $bullet_circles
		i32.const 0 global.set $star_circles
		i32.const 0 global.set $ufo_paths
		i32.const 0 global.set $enemy_bullet_circles
		i32.const 0 global.set $package_paths
		i32.const 0 global.set $satellite_paths
		i32.const 0 global.set $satellite_lines
		i32.const 0 global.set $satellite_circles
		i32.const 0 global.set $satellite_connected_booms
		f32.const 10000 global.set $satellite_min_x
		f32.const -10000 global.set $satellite_max_x
		f32.const 10000 global.set $satellite_min_y
		f32.const -10000 global.set $satellite_max_y
		f32.const 0 global.set $satellite_glow_radius
		i32.const 0 global.set $laser_lines
		i32.const 0 global.set $blossom_marks
		i32.const 0 global.set $blossom_help_valid
		i32.const 0 global.set $help_copy_mask
		i32.const 0 global.set $help_frame_lines
		i32.const 0 global.set $help_column_inputs
		i32.const 0 global.set $help_column_actions
		i32.const 0 global.set $help_column_errors
		f32.const 0 global.set $help_max_y
		f32.const 0 global.set $help_pointer_input_x
		f32.const 0 global.set $help_pointer_action_x
		i32.const -1 global.set $power_hud_kind
		i32.const 0 global.set $power_hud_text_valid
		i32.const 0 global.set $power_hud_primitives
		i32.const 0 global.set $blast_circles
		f32.const 0 global.set $blast_radius
		i32.const -1 global.set $current_path_key
		i32.const 0 global.set $current_path_moves
		i32.const 0 global.set $current_path_lines
		f32.const 0 global.set $flame_min_x)
	(func (export "test_reset_effects")
		i32.const 0 global.set $audio_mask
		i32.const 0 global.set $sample_play_count
		i32.const 0 global.set $sample_play_valid
		i32.const 0 global.set $effect_mask)

	(func (export "test_title_ptr") (result i32) global.get $title_ptr)
	(func (export "test_title_len") (result i32) global.get $title_len)
	(func (export "test_menu_count") (result i32) global.get $menu_count)
	(func (export "test_menu_seen") (param $id i32) (result i32)
		global.get $menu_mask i32.const 1 local.get $id i32.shl i32.and i32.eqz i32.eqz)
	(func (export "test_synth_count") (param $id i32) (result i32)
		local.get $id i32.const 1 i32.eq (if (then global.get $synth_1 return))
		local.get $id i32.const 2 i32.eq (if (then global.get $synth_2 return))
		local.get $id i32.const 3 i32.eq (if (then global.get $synth_3 return))
		local.get $id i32.const 4 i32.eq (if (then global.get $synth_4 return))
		local.get $id i32.const 5 i32.eq (if (then global.get $synth_5 return))
		local.get $id i32.const 6 i32.eq (if (then global.get $synth_6 return))
		local.get $id i32.const 7 i32.eq (if (then global.get $synth_7 return))
		local.get $id i32.const 8 i32.eq (if (then global.get $synth_8 return))
		local.get $id i32.const 9 i32.eq (if (then global.get $synth_9 return))
		local.get $id i32.const 10 i32.eq (if (then global.get $synth_10 return))
		local.get $id i32.const 11 i32.eq (if (then global.get $synth_11 return))
		local.get $id i32.const 12 i32.eq (if (then global.get $synth_12 return))
		local.get $id i32.const 13 i32.eq (if (then global.get $synth_13 return))
		i32.const 0)
	(func (export "test_invalid_synth_voices") (result i32) global.get $invalid_synth_voices)
	(func (export "test_short_boom_voices") (result i32) global.get $short_boom_voices)
	(func (export "test_satellite_ping_valid") (result i32)
		global.get $synth_13 i32.const 3 i32.eq
		global.get $satellite_ping_mask i32.const 7 i32.eq i32.and
		global.get $satellite_ping_errors i32.eqz i32.and)
	(func (export "test_synth_signature") (result i64) global.get $synth_signature)
	(func (export "test_frame_count") (result i32) global.get $frame_count)
	(func (export "test_flash_frames") (result i32) global.get $flash_frames)
	(func (export "test_duplicate_stable_ids") (result i32) global.get $duplicate_stable_ids)
	(func (export "test_first_duplicate_stable_id") (result i32) global.get $first_duplicate_stable_id)
	(func (export "test_geometry_errors") (result i32) global.get $geometry_errors)
	(func (export "test_lifecycle_errors") (result i32)
		global.get $lifecycle_errors
		global.get $frame_open global.get $path_open i32.or
		global.get $transform_depth i32.eqz i32.eqz i32.or
		i32.add)
	(func (export "test_text_seen") (param $id i32) (result i32)
		global.get $text_mask i64.const 1 local.get $id i64.extend_i32_u i64.shl i64.and i64.eqz i32.eqz)
	(func (export "test_audio_seen") (param $id i32) (result i32)
		global.get $audio_mask i32.const 1 local.get $id i32.shl i32.and i32.eqz i32.eqz)
	(func (export "test_sample_asset_valid") (result i32)
		global.get $sample_asset_count i32.const 1 i32.eq
		global.get $sample_asset_valid i32.and)
	(func (export "test_sample_play_count") (result i32) global.get $sample_play_count)
	(func (export "test_sample_play_valid") (result i32) global.get $sample_play_valid)
	(func (export "test_effect_seen") (param $id i32) (result i32)
		global.get $effect_mask i32.const 1 local.get $id i32.shl i32.and i32.eqz i32.eqz)
	(func (export "test_asteroid_paths") (result i32) global.get $asteroid_paths)
	(func (export "test_bad_asteroid_vertices") (result i32) global.get $bad_asteroid_vertices)
	(func (export "test_asteroid_circles") (result i32) global.get $asteroid_circles)
	(func (export "test_reserve_paths") (result i32) global.get $reserve_paths)
	(func (export "test_reserve_count_text_valid") (result i32) global.get $reserve_count_text_valid)
	(func (export "test_bullet_circles") (result i32) global.get $bullet_circles)
	(func (export "test_star_circles") (result i32) global.get $star_circles)
	(func (export "test_ufo_paths") (result i32) global.get $ufo_paths)
	(func (export "test_enemy_bullet_circles") (result i32) global.get $enemy_bullet_circles)
	(func (export "test_package_paths") (result i32) global.get $package_paths)
	(func (export "test_satellite_paths") (result i32) global.get $satellite_paths)
	(func (export "test_satellite_lines") (result i32) global.get $satellite_lines)
	(func (export "test_satellite_circles") (result i32) global.get $satellite_circles)
	(func (export "test_satellite_connected_booms") (result i32) global.get $satellite_connected_booms)
	(func (export "test_satellite_footprint_valid") (result i32)
		global.get $satellite_min_x f32.const -64 f32.ge
		global.get $satellite_min_x f32.const -60 f32.le i32.and
		global.get $satellite_max_x f32.const 72 f32.ge i32.and
		global.get $satellite_max_x f32.const 75 f32.le i32.and
		global.get $satellite_min_y f32.const -22 f32.ge i32.and
		global.get $satellite_min_y f32.const -18 f32.le i32.and
		global.get $satellite_max_y f32.const 25 f32.ge i32.and
		global.get $satellite_max_y f32.const 28 f32.le i32.and)
	(func (export "test_satellite_glow_radius") (result f32) global.get $satellite_glow_radius)
	(func (export "test_laser_lines") (result i32) global.get $laser_lines)
	(func (export "test_blossom_marks") (result i32) global.get $blossom_marks)
	(func (export "test_blossom_help_valid") (result i32) global.get $blossom_help_valid)
	(func (export "test_help_copy_mask") (result i32) global.get $help_copy_mask)
	(func (export "test_help_frame_lines") (result i32) global.get $help_frame_lines)
	(func (export "test_help_columns_valid") (result i32)
		global.get $help_column_inputs i32.const 13 i32.eq
		global.get $help_column_actions i32.const 13 i32.eq i32.and
		global.get $help_column_errors i32.eqz i32.and)
	(func (export "test_help_fits_height") (param $height f32) (result i32)
		global.get $help_max_y local.get $height f32.le)
	(func (export "test_help_pointer_gap_valid") (result i32)
		global.get $help_pointer_action_x global.get $help_pointer_input_x f32.sub
		f32.const 125 f32.ge)
	(func (export "test_power_hud_kind") (result i32) global.get $power_hud_kind)
	(func (export "test_power_hud_text_valid") (result i32) global.get $power_hud_text_valid)
	(func (export "test_power_hud_primitives") (result i32) global.get $power_hud_primitives)
	(func (export "test_blast_circles") (result i32) global.get $blast_circles)
	(func (export "test_blast_radius") (result f32) global.get $blast_radius)
	(func (export "test_flame_min_x") (result f32) global.get $flame_min_x)

	;; Mirrors the real host's frame-wide identity contract across primitive
	;; kinds. A compact linear registry accepts every i32 ID without sentinels;
	;; quadratic lookup is deliberate because this deterministic fake host favors
	;; transparent validation over production rendering throughput.
	(func $record_stable_id (param $id i32)
		(local $index i32)
		(block $new_id
			(loop $search
				local.get $index global.get $stable_id_count i32.ge_u br_if $new_id
				local.get $index i32.const 4 i32.mul i32.load local.get $id i32.eq
				(if (then
					global.get $first_duplicate_stable_id i32.const -1 i32.eq
					(if (then local.get $id global.set $first_duplicate_stable_id))
					global.get $duplicate_stable_ids i32.const 1 i32.add global.set $duplicate_stable_ids
					return))
				local.get $index i32.const 1 i32.add local.set $index
				br $search))
		global.get $stable_id_count i32.const 16384 i32.ge_u
		(if (then
			global.get $duplicate_stable_ids i32.const 1 i32.add global.set $duplicate_stable_ids
			return))
		global.get $stable_id_count i32.const 4 i32.mul local.get $id i32.store
		global.get $stable_id_count i32.const 1 i32.add global.set $stable_id_count)
	(func $record_lifecycle_error
		global.get $lifecycle_errors i32.const 1 i32.add global.set $lifecycle_errors)
	(func $record_satellite_point (param $x f32) (param $y f32)
		global.get $current_path_key i32.const 934 i32.ge_u
		global.get $current_path_key i32.const 955 i32.lt_u i32.and
		(if (then
			local.get $x global.get $satellite_min_x f32.lt
			(if (then local.get $x global.set $satellite_min_x))
			local.get $x global.get $satellite_max_x f32.gt
			(if (then local.get $x global.set $satellite_max_x))
			local.get $y global.get $satellite_min_y f32.lt
			(if (then local.get $y global.set $satellite_min_y))
			local.get $y global.get $satellite_max_y f32.gt
			(if (then local.get $y global.set $satellite_max_y)))))
	(func $record_synth_scalar (param $value i32)
		global.get $synth_signature local.get $value i64.extend_i32_u i64.xor
		i64.const 1099511628211 i64.mul global.set $synth_signature)
	(func $record_help_bottom (param $key i32) (param $bottom f32)
		local.get $key i32.const 2010 i32.ge_u local.get $key i32.const 2015 i32.lt_u i32.and
		local.get $key i32.const 2030 i32.ge_u local.get $key i32.const 2039 i32.lt_u i32.and i32.or
		local.get $key i32.const 40 i32.ge_u local.get $key i32.const 75 i32.lt_u i32.and i32.or
		(if (then
			local.get $bottom global.get $help_max_y f32.gt
			(if (then local.get $bottom global.set $help_max_y)))))

	(func (export "AE_title") (param $ptr i32) (param $len i32) (result i32)
		local.get $ptr global.set $title_ptr
		local.get $len global.set $title_len
		i32.const 0)
	(func (export "AE_menu_item") (param $id i32) (param i32 i32 i32 i32) (result i32)
		global.get $menu_count i32.const 1 i32.add global.set $menu_count
		global.get $menu_mask i32.const 1 local.get $id i32.shl i32.or global.set $menu_mask
		i32.const 0)
	(func (export "AE_frame_begin") (param $red f32) (param f32 f32 f32) (result i32)
		global.get $frame_open global.get $path_open i32.or
		global.get $transform_depth i32.eqz i32.eqz i32.or
		(if (then call $record_lifecycle_error i32.const 0 return))
		i32.const 1 global.set $frame_open
		i32.const 0 global.set $stable_id_count
		i32.const 0 global.set $duplicate_stable_ids
		i32.const -1 global.set $first_duplicate_stable_id
		global.get $frame_count i32.const 1 i32.add global.set $frame_count
		local.get $red f32.const 0.9 f32.gt
		(if (then global.get $flash_frames i32.const 1 i32.add global.set $flash_frames))
		i32.const 0)
	(func (export "AE_transform_push") (param f32 f32 f32 f32 f32 f32) (result i32)
		global.get $frame_open i32.eqz global.get $path_open i32.or
		(if (then call $record_lifecycle_error i32.const 0 return))
		global.get $transform_depth i32.const 1 i32.add global.set $transform_depth
		i32.const 0)
	(func (export "AE_transform_pop") (result i32)
		global.get $frame_open i32.eqz global.get $path_open i32.or
		global.get $transform_depth i32.eqz i32.or
		(if (then call $record_lifecycle_error i32.const 0 return))
		global.get $transform_depth i32.const 1 i32.sub global.set $transform_depth
		i32.const 0)
	(func (export "AE_path_begin") (param $key i32) (result i32)
		global.get $frame_open i32.eqz global.get $path_open i32.or
		(if (then call $record_lifecycle_error i32.const 0 return))
		i32.const 1 global.set $path_open
		local.get $key call $record_stable_id
		local.get $key global.set $current_path_key
		i32.const 0 global.set $current_path_moves
		i32.const 0 global.set $current_path_lines
		local.get $key i32.const 4 i32.eq (if (then f32.const 0 global.set $flame_min_x))
		i32.const 0)
	(func (export "AE_path_move") (param $x f32) (param $y f32) (result i32)
		global.get $path_open i32.eqz
		(if (then call $record_lifecycle_error i32.const 0 return))
		global.get $current_path_moves i32.const 1 i32.add global.set $current_path_moves
		local.get $x local.get $y call $record_satellite_point
		i32.const 0)
	(func (export "AE_path_line") (param $x f32) (param $y f32) (result i32)
		global.get $path_open i32.eqz
		(if (then call $record_lifecycle_error i32.const 0 return))
		global.get $current_path_lines i32.const 1 i32.add global.set $current_path_lines
		local.get $x local.get $y call $record_satellite_point
		global.get $current_path_key i32.const 4 i32.eq
		(if (then local.get $x global.get $flame_min_x f32.lt (if (then local.get $x global.set $flame_min_x))))
		i32.const 0)
	(func (export "AE_path_close") (result i32)
		global.get $path_open i32.eqz
		(if (then call $record_lifecycle_error))
		i32.const 0)
	(func (export "AE_path_end") (param f32 i32 i32 i32) (result i32)
		(local $minimum_lines i32) (local $valid i32)
		global.get $path_open i32.eqz
		(if (then call $record_lifecycle_error i32.const 0 return))
		i32.const 1 local.set $minimum_lines
		global.get $current_path_key i32.const 900 i32.eq
		(if (then i32.const 5 local.set $minimum_lines))
		global.get $current_path_key i32.const 910 i32.eq
		(if (then i32.const 3 local.set $minimum_lines))
		global.get $current_path_moves i32.eqz
		global.get $current_path_lines local.get $minimum_lines i32.lt_u i32.or
		(if
			(then global.get $geometry_errors i32.const 1 i32.add global.set $geometry_errors)
			(else i32.const 1 local.set $valid))
		global.get $current_path_key i32.const 200 i32.ge_u
		global.get $current_path_key i32.const 232 i32.lt_u i32.and
		local.get $valid i32.and
		(if (then
			global.get $asteroid_paths i32.const 1 i32.add global.set $asteroid_paths
			global.get $current_path_lines i32.const 7 i32.lt_u
			global.get $current_path_lines i32.const 11 i32.gt_u i32.or
			(if (then global.get $bad_asteroid_vertices i32.const 1 i32.add global.set $bad_asteroid_vertices))))
		global.get $current_path_key i32.const 50 i32.ge_u
		global.get $current_path_key i32.const 53 i32.lt_u i32.and
		local.get $valid i32.and
		(if (then global.get $reserve_paths i32.const 1 i32.add global.set $reserve_paths))
		global.get $current_path_key i32.const 900 i32.eq local.get $valid i32.and
		(if (then global.get $ufo_paths i32.const 1 i32.add global.set $ufo_paths))
		global.get $current_path_key i32.const 910 i32.eq local.get $valid i32.and
		(if (then global.get $package_paths i32.const 1 i32.add global.set $package_paths))
		global.get $current_path_key i32.const 934 i32.ge_u
		global.get $current_path_key i32.const 955 i32.lt_u i32.and local.get $valid i32.and
		(if (then global.get $satellite_paths i32.const 1 i32.add global.set $satellite_paths))
		global.get $current_path_key i32.const 938 i32.eq
		global.get $current_path_key i32.const 939 i32.eq i32.or
		global.get $current_path_moves i32.const 1 i32.eq i32.and
		global.get $current_path_lines i32.const 4 i32.ge_u i32.and local.get $valid i32.and
		(if (then global.get $satellite_connected_booms i32.const 1 i32.add global.set $satellite_connected_booms))
		i32.const 0 global.set $path_open
		i32.const -1 global.set $current_path_key
		i32.const 0)
	(func (export "AE_line") (param $key i32) (param $x1 f32) (param $y1 f32)
		(param $x2 f32) (param $y2 f32) (param $width f32) (param i32) (result i32)
		(local $valid i32)
		global.get $frame_open i32.eqz global.get $path_open i32.or
		(if (then call $record_lifecycle_error))
		local.get $key call $record_stable_id
		local.get $width f32.const 0 f32.gt
		local.get $x1 local.get $x2 f32.ne local.get $y1 local.get $y2 f32.ne i32.or
		i32.and local.set $valid
		local.get $valid i32.eqz
		(if (then global.get $geometry_errors i32.const 1 i32.add global.set $geometry_errors))
		local.get $key local.get $y1 local.get $y2 f32.max local.get $width f32.const 2 f32.div f32.add
		call $record_help_bottom
		local.get $key i32.const 980 i32.ge_u local.get $key i32.const 982 i32.lt_u i32.and
		local.get $valid i32.and
		(if (then global.get $laser_lines i32.const 1 i32.add global.set $laser_lines))
		local.get $key i32.const 921 i32.ge_u local.get $key i32.const 929 i32.lt_u i32.and
		local.get $valid i32.and
		(if (then global.get $blossom_marks i32.const 1 i32.add global.set $blossom_marks))
		local.get $key i32.const 2010 i32.ge_u local.get $key i32.const 2015 i32.lt_u i32.and
		local.get $valid i32.and
		(if (then global.get $help_frame_lines i32.const 1 i32.add global.set $help_frame_lines))
		local.get $key i32.const 2020 i32.ge_u local.get $key i32.const 2028 i32.lt_u i32.and
		local.get $valid i32.and
		(if (then global.get $power_hud_primitives i32.const 1 i32.add global.set $power_hud_primitives))
		local.get $key i32.const 950 i32.ge_u local.get $key i32.const 953 i32.lt_u i32.and
		local.get $valid i32.and
		(if (then global.get $satellite_lines i32.const 1 i32.add global.set $satellite_lines))
		i32.const 0)
	(func (export "AE_circle") (param $key i32) (param f32) (param $y f32) (param $radius f32) (param f32 i32 i32) (result i32)
		(local $valid i32)
		global.get $frame_open i32.eqz global.get $path_open i32.or
		(if (then call $record_lifecycle_error))
		local.get $key call $record_stable_id
		local.get $radius f32.const 0 f32.gt local.set $valid
		local.get $valid i32.eqz
		(if (then global.get $geometry_errors i32.const 1 i32.add global.set $geometry_errors))
		local.get $key local.get $y local.get $radius f32.add call $record_help_bottom
		local.get $key i32.const 100 i32.ge_u local.get $key i32.const 164 i32.lt_u i32.and
		local.get $key i32.const 1100 i32.ge_u local.get $key i32.const 1292 i32.lt_u i32.and i32.or local.get $valid i32.and
		(if (then global.get $bullet_circles i32.const 1 i32.add global.set $bullet_circles))
		local.get $key i32.const 200 i32.ge_u local.get $key i32.const 232 i32.lt_u i32.and
		local.get $valid i32.and
		(if (then global.get $asteroid_circles i32.const 1 i32.add global.set $asteroid_circles))
		local.get $key i32.const 800 i32.ge_u local.get $key i32.const 900 i32.lt_u i32.and
		local.get $valid i32.and
		(if (then global.get $star_circles i32.const 1 i32.add global.set $star_circles))
		local.get $key i32.const 960 i32.ge_u local.get $key i32.const 968 i32.lt_u i32.and
		local.get $valid i32.and
		(if (then global.get $enemy_bullet_circles i32.const 1 i32.add global.set $enemy_bullet_circles))
		local.get $key i32.const 920 i32.eq local.get $valid i32.and
		(if (then global.get $blossom_marks i32.const 1 i32.add global.set $blossom_marks))
		local.get $key i32.const 930 i32.ge_u local.get $key i32.const 932 i32.lt_u i32.and
		local.get $valid i32.and
		(if (then
			global.get $blast_circles i32.const 1 i32.add global.set $blast_circles
			local.get $key i32.const 930 i32.eq (if (then local.get $radius global.set $blast_radius))))
		local.get $key i32.const 2025 i32.eq local.get $valid i32.and
		(if (then global.get $power_hud_primitives i32.const 1 i32.add global.set $power_hud_primitives))
		local.get $key i32.const 932 i32.ge_u local.get $key i32.const 960 i32.lt_u i32.and
		local.get $valid i32.and
		(if (then global.get $satellite_circles i32.const 1 i32.add global.set $satellite_circles))
		local.get $key i32.const 932 i32.eq
		(if (then local.get $radius global.set $satellite_glow_radius))
		i32.const 0)
	(func (export "AE_text") (param $key i32) (param $ptr i32) (param $len i32)
		(param $x f32) (param $y f32) (param $size f32) (param $rgba i32) (param $flags i32) (result i32)
		global.get $frame_open i32.eqz global.get $path_open i32.or
		(if (then call $record_lifecycle_error))
		local.get $key call $record_stable_id
		local.get $key local.get $y local.get $size f32.add call $record_help_bottom
		local.get $key i32.const 56 i32.eq
		(if (then local.get $x global.set $help_pointer_input_x))
		local.get $key i32.const 71 i32.eq
		(if (then local.get $x global.set $help_pointer_action_x))
		global.get $text_mask i64.const 1 local.get $key i64.extend_i32_u i64.shl i64.or global.set $text_mask
		local.get $key i32.const 41 i32.ge_u local.get $key i32.const 50 i32.lt_u i32.and
		(if (then
			global.get $help_column_inputs i32.const 1 i32.add global.set $help_column_inputs
			local.get $x f32.const 98 f32.ne
			local.get $rgba i32.const 0xffffffff i32.ne i32.or
			local.get $flags i32.const 1 i32.and i32.eqz i32.eqz i32.or
			(if (then global.get $help_column_errors i32.const 1 i32.add global.set $help_column_errors))))
		local.get $key i32.const 56 i32.ge_u local.get $key i32.const 60 i32.lt_u i32.and
		(if (then
			global.get $help_column_inputs i32.const 1 i32.add global.set $help_column_inputs
			local.get $x f32.const 470 f32.ne
			local.get $rgba i32.const 0xffffffff i32.ne i32.or
			local.get $flags i32.const 1 i32.and i32.eqz i32.eqz i32.or
			(if (then global.get $help_column_errors i32.const 1 i32.add global.set $help_column_errors))))
		local.get $key i32.const 62 i32.ge_u local.get $key i32.const 71 i32.lt_u i32.and
		(if (then
			global.get $help_column_actions i32.const 1 i32.add global.set $help_column_actions
			local.get $x f32.const 285 f32.ne
			local.get $rgba i32.const 0x9bb8d1ff i32.ne i32.or
			local.get $flags i32.const 1 i32.and i32.eqz i32.eqz i32.or
			(if (then global.get $help_column_errors i32.const 1 i32.add global.set $help_column_errors))))
		local.get $key i32.const 71 i32.ge_u local.get $key i32.const 75 i32.lt_u i32.and
		(if (then
			global.get $help_column_actions i32.const 1 i32.add global.set $help_column_actions
			local.get $x f32.const 610 f32.ne
			local.get $rgba i32.const 0x9bb8d1ff i32.ne i32.or
			local.get $flags i32.const 1 i32.and i32.eqz i32.eqz i32.or
			(if (then global.get $help_column_errors i32.const 1 i32.add global.set $help_column_errors))))
		local.get $key i32.const 53 i32.eq
		(if (then
			local.get $ptr i32.const 512 i32.eq
			local.get $len i32.const 26 i32.eq i32.and
			global.set $blossom_help_valid))
		local.get $key i32.const 54 i32.eq
		(if (then local.get $ptr i32.const 560 i32.eq local.get $len i32.const 8 i32.eq i32.and
			(if (then global.get $help_copy_mask i32.const 1 i32.or global.set $help_copy_mask))))
		local.get $key i32.const 55 i32.eq
		(if (then local.get $ptr i32.const 568 i32.eq local.get $len i32.const 7 i32.eq i32.and
			(if (then global.get $help_copy_mask i32.const 2 i32.or global.set $help_copy_mask))))
		local.get $key i32.const 56 i32.eq
		(if (then local.get $ptr i32.const 576 i32.eq local.get $len i32.const 4 i32.eq i32.and
			(if (then global.get $help_copy_mask i32.const 4 i32.or global.set $help_copy_mask))))
		local.get $key i32.const 57 i32.eq
		(if (then local.get $ptr i32.const 592 i32.eq local.get $len i32.const 9 i32.eq i32.and
			(if (then global.get $help_copy_mask i32.const 8 i32.or global.set $help_copy_mask))))
		local.get $key i32.const 58 i32.eq
		(if (then local.get $ptr i32.const 616 i32.eq local.get $len i32.const 10 i32.eq i32.and
			(if (then global.get $help_copy_mask i32.const 16 i32.or global.set $help_copy_mask))))
		local.get $key i32.const 59 i32.eq
		(if (then local.get $ptr i32.const 640 i32.eq local.get $len i32.const 6 i32.eq i32.and
			(if (then global.get $help_copy_mask i32.const 32 i32.or global.set $help_copy_mask))))
		local.get $key i32.const 60 i32.eq
		(if (then
			i32.const 0 global.set $power_hud_kind
			local.get $ptr i32.const 672 i32.eq local.get $len i32.const 11 i32.eq i32.and global.set $power_hud_text_valid))
		local.get $key i32.const 61 i32.eq
		(if (then
			i32.const 1 global.set $power_hud_kind
			local.get $ptr i32.const 688 i32.eq local.get $len i32.const 11 i32.eq i32.and global.set $power_hud_text_valid))
		local.get $key i32.const 25 i32.eq
		(if (then
			local.get $len i32.const 1 i32.ge_u
			local.get $len i32.const 6 i32.le_u i32.and
			local.get $ptr local.get $len i32.add i32.const 550 i32.eq i32.and
			global.set $reserve_count_text_valid))
		i32.const 0)
	(func (export "AE_frame_end") (result i32)
		global.get $frame_open i32.eqz
		(if (then call $record_lifecycle_error i32.const 0 return))
		global.get $path_open global.get $transform_depth i32.eqz i32.eqz i32.or
		(if (then call $record_lifecycle_error))
		i32.const 0 global.set $frame_open
		i32.const 0 global.set $path_open
		i32.const 0 global.set $transform_depth
		i32.const -1 global.set $current_path_key
		i32.const 0)
	(func (export "AE_audio") (param $id i32) (param f32 f32 i32) (result i32)
		global.get $audio_mask i32.const 1 local.get $id i32.shl i32.or global.set $audio_mask
		i32.const 0)
	(func (export "AE_sample_asset")
		(param $id i32) (param $ptr i32) (param $len i32) (param $flags i32) (result i32)
		global.get $sample_asset_count i32.const 1 i32.add global.set $sample_asset_count
		local.get $id i32.const 1 i32.eq
		local.get $ptr i32.const 704 i32.eq i32.and
		local.get $len i32.const 37 i32.eq i32.and
		local.get $flags i32.eqz i32.and
		global.set $sample_asset_valid
		i32.const 0)
	(func (export "AE_sample_play")
		(param $id i32) (param $volume f32) (param $pitch f32) (param $flags i32) (result i32)
		global.get $sample_play_count i32.const 1 i32.add global.set $sample_play_count
		local.get $id i32.const 1 i32.eq
		local.get $volume f32.const 1 f32.eq i32.and
		local.get $pitch f32.const 1 f32.eq i32.and
		local.get $flags i32.eqz i32.and
		global.set $sample_play_valid
		i32.const 0)
	(func (export "AE_synth_voice")
		(param $id i32) (param $waveform i32) (param $delay i32) (param $duration i32)
		(param $frequency_start i32) (param $frequency_mid i32) (param $frequency_end i32)
		(param $gain_start i32) (param $gain_peak i32) (param $gain_end i32)
		(param $filter i32) (param $filter_start i32) (param $filter_end i32) (param $cooldown i32)
		(result i32)
		(local $satellite_voice i32)
		local.get $id call $record_synth_scalar
		local.get $waveform call $record_synth_scalar
		local.get $delay call $record_synth_scalar
		local.get $duration call $record_synth_scalar
		local.get $frequency_start call $record_synth_scalar
		local.get $frequency_mid call $record_synth_scalar
		local.get $frequency_end call $record_synth_scalar
		local.get $gain_start call $record_synth_scalar
		local.get $gain_peak call $record_synth_scalar
		local.get $gain_end call $record_synth_scalar
		local.get $filter call $record_synth_scalar
		local.get $filter_start call $record_synth_scalar
		local.get $filter_end call $record_synth_scalar
		local.get $cooldown call $record_synth_scalar
		local.get $waveform i32.const 1 i32.lt_s local.get $waveform i32.const 4 i32.gt_s i32.or
		local.get $duration i32.const 0 i32.le_s i32.or
		local.get $gain_start i32.const 0 i32.lt_s local.get $gain_start i32.const 1000000 i32.gt_s i32.or i32.or
		local.get $gain_peak i32.const 0 i32.lt_s local.get $gain_peak i32.const 1000000 i32.gt_s i32.or i32.or
		local.get $gain_end i32.const 0 i32.lt_s local.get $gain_end i32.const 1000000 i32.gt_s i32.or i32.or
		local.get $filter i32.const 0 i32.lt_s local.get $filter i32.const 2 i32.gt_s i32.or i32.or
		(if (then global.get $invalid_synth_voices i32.const 1 i32.add global.set $invalid_synth_voices))
		local.get $id i32.const 1 i32.eq (if (then global.get $synth_1 i32.const 1 i32.add global.set $synth_1))
		local.get $id i32.const 2 i32.eq (if (then global.get $synth_2 i32.const 1 i32.add global.set $synth_2))
		local.get $id i32.const 3 i32.eq (if (then global.get $synth_3 i32.const 1 i32.add global.set $synth_3))
		local.get $id i32.const 4 i32.eq (if (then global.get $synth_4 i32.const 1 i32.add global.set $synth_4))
		local.get $id i32.const 5 i32.eq (if (then global.get $synth_5 i32.const 1 i32.add global.set $synth_5))
		local.get $id i32.const 6 i32.eq (if (then global.get $synth_6 i32.const 1 i32.add global.set $synth_6))
		local.get $id i32.const 7 i32.eq (if (then global.get $synth_7 i32.const 1 i32.add global.set $synth_7))
		local.get $id i32.const 8 i32.eq (if (then global.get $synth_8 i32.const 1 i32.add global.set $synth_8))
		local.get $id i32.const 9 i32.eq (if (then global.get $synth_9 i32.const 1 i32.add global.set $synth_9))
		local.get $id i32.const 10 i32.eq (if (then global.get $synth_10 i32.const 1 i32.add global.set $synth_10))
		local.get $id i32.const 11 i32.eq (if (then global.get $synth_11 i32.const 1 i32.add global.set $synth_11))
		local.get $id i32.const 12 i32.eq
		(if (then
			global.get $synth_12 i32.const 1 i32.add global.set $synth_12
			local.get $duration i32.const 1000 i32.lt_s
			(if (then global.get $short_boom_voices i32.const 1 i32.add global.set $short_boom_voices))))
		local.get $id i32.const 13 i32.eq
		(if (then
			global.get $synth_13 i32.const 1 i32.add global.set $synth_13
			local.get $waveform i32.const 1 i32.eq
			local.get $frequency_start i32.const 520000 i32.eq i32.and
			local.get $frequency_mid i32.const 520000 i32.eq i32.and
			local.get $frequency_end i32.const 520000 i32.eq i32.and
			local.get $gain_start i32.eqz i32.and
			local.get $gain_end i32.eqz i32.and
			local.get $filter i32.eqz i32.and
			local.get $filter_start i32.eqz i32.and
			local.get $filter_end i32.eqz i32.and
			local.get $cooldown i32.eqz i32.and
			(if (then
				local.get $delay i32.eqz
				local.get $duration i32.const 420 i32.eq i32.and
				local.get $gain_peak i32.const 220000 i32.eq i32.and
				(if (then i32.const 1 local.set $satellite_voice))
				local.get $delay i32.const 160 i32.eq
				local.get $duration i32.const 520 i32.eq i32.and
				local.get $gain_peak i32.const 85000 i32.eq i32.and
				(if (then i32.const 2 local.set $satellite_voice))
				local.get $delay i32.const 340 i32.eq
				local.get $duration i32.const 620 i32.eq i32.and
				local.get $gain_peak i32.const 35000 i32.eq i32.and
				(if (then i32.const 4 local.set $satellite_voice))))
			local.get $satellite_voice i32.eqz
			(if
				(then global.get $satellite_ping_errors i32.const 1 i32.add global.set $satellite_ping_errors)
				(else global.get $satellite_ping_mask local.get $satellite_voice i32.or global.set $satellite_ping_mask))))
		i32.const 0)
	(func (export "AE_effect") (param $id i32) (param i32 i32) (result i32)
		global.get $effect_mask i32.const 1 local.get $id i32.shl i32.or global.set $effect_mask
		i32.const 0)
)
(register "aedicule.v0" $aedicule_v0)
(register "test.host" $aedicule_v0)
