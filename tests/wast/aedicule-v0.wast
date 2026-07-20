;; Deterministic, instrumented implementation of the generic Aedicule host
;; imports. Production behavior is exercised without a Rust test runner, while
;; query exports let companion WAST modules assert guest-emitted effects.
(module $aedicule_v0
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
	(global $short_boom_voices (mut i32) (i32.const 0))
	(global $invalid_synth_voices (mut i32) (i32.const 0))
	(global $frame_count (mut i32) (i32.const 0))
	(global $flash_frames (mut i32) (i32.const 0))
	(global $text_mask (mut i64) (i64.const 0))
	(global $audio_mask (mut i32) (i32.const 0))
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
	(global $laser_lines (mut i32) (i32.const 0))
	(global $blossom_marks (mut i32) (i32.const 0))
	(global $blossom_help_valid (mut i32) (i32.const 0))
	(global $blast_circles (mut i32) (i32.const 0))
	(global $blast_radius (mut f32) (f32.const 0))
	(global $current_path_key (mut i32) (i32.const -1))
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
		i32.const 0 global.set $short_boom_voices
		i32.const 0 global.set $invalid_synth_voices)
	(func (export "test_reset_frame")
		i32.const 0 global.set $frame_count
		i32.const 0 global.set $flash_frames
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
		i32.const 0 global.set $laser_lines
		i32.const 0 global.set $blossom_marks
		i32.const 0 global.set $blossom_help_valid
		i32.const 0 global.set $blast_circles
		f32.const 0 global.set $blast_radius
		i32.const -1 global.set $current_path_key
		i32.const 0 global.set $current_path_lines
		f32.const 0 global.set $flame_min_x)
	(func (export "test_reset_effects")
		i32.const 0 global.set $audio_mask
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
		i32.const 0)
	(func (export "test_invalid_synth_voices") (result i32) global.get $invalid_synth_voices)
	(func (export "test_short_boom_voices") (result i32) global.get $short_boom_voices)
	(func (export "test_frame_count") (result i32) global.get $frame_count)
	(func (export "test_flash_frames") (result i32) global.get $flash_frames)
	(func (export "test_text_seen") (param $id i32) (result i32)
		global.get $text_mask i64.const 1 local.get $id i64.extend_i32_u i64.shl i64.and i64.eqz i32.eqz)
	(func (export "test_audio_seen") (param $id i32) (result i32)
		global.get $audio_mask i32.const 1 local.get $id i32.shl i32.and i32.eqz i32.eqz)
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
	(func (export "test_laser_lines") (result i32) global.get $laser_lines)
	(func (export "test_blossom_marks") (result i32) global.get $blossom_marks)
	(func (export "test_blossom_help_valid") (result i32) global.get $blossom_help_valid)
	(func (export "test_blast_circles") (result i32) global.get $blast_circles)
	(func (export "test_blast_radius") (result f32) global.get $blast_radius)
	(func (export "test_flame_min_x") (result f32) global.get $flame_min_x)

	(func (export "AE_title") (param $ptr i32) (param $len i32) (result i32)
		local.get $ptr global.set $title_ptr
		local.get $len global.set $title_len
		i32.const 0)
	(func (export "AE_menu_item") (param $id i32) (param i32 i32 i32 i32) (result i32)
		global.get $menu_count i32.const 1 i32.add global.set $menu_count
		global.get $menu_mask i32.const 1 local.get $id i32.shl i32.or global.set $menu_mask
		i32.const 0)
	(func (export "AE_frame_begin") (param $red f32) (param f32 f32 f32) (result i32)
		global.get $frame_count i32.const 1 i32.add global.set $frame_count
		local.get $red f32.const 0.9 f32.gt
		(if (then global.get $flash_frames i32.const 1 i32.add global.set $flash_frames))
		i32.const 0)
	(func (export "AE_transform_push") (param f32 f32 f32 f32 f32 f32) (result i32) i32.const 0)
	(func (export "AE_transform_pop") (result i32) i32.const 0)
	(func (export "AE_path_begin") (param $key i32) (result i32)
		local.get $key global.set $current_path_key
		i32.const 0 global.set $current_path_lines
		local.get $key i32.const 4 i32.eq (if (then f32.const 0 global.set $flame_min_x))
		i32.const 0)
	(func (export "AE_path_move") (param f32 f32) (result i32) i32.const 0)
	(func (export "AE_path_line") (param $x f32) (param f32) (result i32)
		global.get $current_path_lines i32.const 1 i32.add global.set $current_path_lines
		global.get $current_path_key i32.const 4 i32.eq
		(if (then local.get $x global.get $flame_min_x f32.lt (if (then local.get $x global.set $flame_min_x))))
		i32.const 0)
	(func (export "AE_path_close") (result i32) i32.const 0)
	(func (export "AE_path_end") (param f32 i32 i32 i32) (result i32)
		global.get $current_path_key i32.const 200 i32.ge_u
		global.get $current_path_key i32.const 232 i32.lt_u i32.and
		(if (then
			global.get $asteroid_paths i32.const 1 i32.add global.set $asteroid_paths
			global.get $current_path_lines i32.const 7 i32.lt_u
			global.get $current_path_lines i32.const 11 i32.gt_u i32.or
			(if (then global.get $bad_asteroid_vertices i32.const 1 i32.add global.set $bad_asteroid_vertices))))
		global.get $current_path_key i32.const 50 i32.ge_u
		global.get $current_path_key i32.const 53 i32.lt_u i32.and
		(if (then global.get $reserve_paths i32.const 1 i32.add global.set $reserve_paths))
		global.get $current_path_key i32.const 900 i32.eq
		(if (then global.get $ufo_paths i32.const 1 i32.add global.set $ufo_paths))
		global.get $current_path_key i32.const 910 i32.eq
		(if (then global.get $package_paths i32.const 1 i32.add global.set $package_paths))
		i32.const 0)
	(func (export "AE_line") (param $key i32) (param f32 f32 f32 f32 f32 i32) (result i32)
		local.get $key i32.const 980 i32.ge_u local.get $key i32.const 982 i32.lt_u i32.and
		(if (then global.get $laser_lines i32.const 1 i32.add global.set $laser_lines))
		local.get $key i32.const 921 i32.ge_u local.get $key i32.const 929 i32.lt_u i32.and
		(if (then global.get $blossom_marks i32.const 1 i32.add global.set $blossom_marks))
		i32.const 0)
	(func (export "AE_circle") (param $key i32) (param f32 f32) (param $radius f32) (param f32 i32 i32) (result i32)
		local.get $key i32.const 100 i32.ge_u local.get $key i32.const 164 i32.lt_u i32.and
		local.get $key i32.const 1100 i32.ge_u local.get $key i32.const 1292 i32.lt_u i32.and i32.or
		(if (then global.get $bullet_circles i32.const 1 i32.add global.set $bullet_circles))
		local.get $key i32.const 200 i32.ge_u local.get $key i32.const 232 i32.lt_u i32.and
		(if (then global.get $asteroid_circles i32.const 1 i32.add global.set $asteroid_circles))
		local.get $key i32.const 800 i32.ge_u local.get $key i32.const 900 i32.lt_u i32.and
		(if (then global.get $star_circles i32.const 1 i32.add global.set $star_circles))
		local.get $key i32.const 960 i32.ge_u local.get $key i32.const 968 i32.lt_u i32.and
		(if (then global.get $enemy_bullet_circles i32.const 1 i32.add global.set $enemy_bullet_circles))
		local.get $key i32.const 920 i32.eq
		(if (then global.get $blossom_marks i32.const 1 i32.add global.set $blossom_marks))
		local.get $key i32.const 930 i32.ge_u local.get $key i32.const 932 i32.lt_u i32.and
		(if (then
			global.get $blast_circles i32.const 1 i32.add global.set $blast_circles
			local.get $key i32.const 930 i32.eq (if (then local.get $radius global.set $blast_radius))))
		i32.const 0)
	(func (export "AE_text") (param $key i32) (param $ptr i32) (param $len i32) (param f32 f32 f32 i32 i32) (result i32)
		global.get $text_mask i64.const 1 local.get $key i64.extend_i32_u i64.shl i64.or global.set $text_mask
		local.get $key i32.const 50 i32.eq
		(if (then
			local.get $ptr i32.const 512 i32.eq
			local.get $len i32.const 26 i32.eq i32.and
			global.set $blossom_help_valid))
		local.get $key i32.const 25 i32.eq
		(if (then
			local.get $len i32.const 1 i32.ge_u
			local.get $len i32.const 6 i32.le_u i32.and
			local.get $ptr local.get $len i32.add i32.const 550 i32.eq i32.and
			global.set $reserve_count_text_valid))
		i32.const 0)
	(func (export "AE_frame_end") (result i32) i32.const 0)
	(func (export "AE_audio") (param $id i32) (param f32 f32 i32) (result i32)
		global.get $audio_mask i32.const 1 local.get $id i32.shl i32.or global.set $audio_mask
		i32.const 0)
	(func (export "AE_synth_voice")
		(param $id i32) (param $waveform i32) (param i32) (param $duration i32)
		(param i32 i32 i32) (param $gain_start i32) (param $gain_peak i32) (param $gain_end i32)
		(param $filter i32) (param i32 i32 i32)
		(result i32)
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
		i32.const 0)
	(func (export "AE_effect") (param $id i32) (param i32 i32) (result i32)
		global.get $effect_mask i32.const 1 local.get $id i32.shl i32.or global.set $effect_mask
		i32.const 0)
)
(register "aedicule.v0" $aedicule_v0)
(register "test.host" $aedicule_v0)
