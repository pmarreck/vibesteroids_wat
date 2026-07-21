;; The concrete game must retain the mandatory v0 guest lifecycle while its
;; display event and fixed 120/1 rate stay independent of host display timing.
(module $aedicule_contract
	(import "sut" "AE_abi_major" (func $abi_major (result i32)))
	(import "sut" "AE_abi_minor" (func $abi_minor (result i32)))
	(import "sut" "AE_configure" (func $configure (result i32)))
	(import "sut" "AE_init" (func $init (param i32 i32 f32 f32) (result i32)))
	(import "sut" "AE_event" (func $event (param i32 i32 f32 f32) (result i32)))
	(import "sut" "AE_tick_rate" (func $tick_rate (param i32 i32) (result i32 i32)))
	(import "sut" "AE_render" (func $render (result i32)))
	(import "sut" "AE_state_ptr" (func $state_ptr (result i32)))
	(import "sut" "AE_state_len" (func $state_len (result i32)))
	(import "sut" "AE_state_schema" (func $state_schema (result i32)))
	(import "test.host" "test_reset_frame" (func $host_reset_frame))
	(import "test.host" "test_duplicate_stable_ids" (func $host_duplicate_stable_ids (result i32)))
	(import "test.host" "test_first_duplicate_stable_id" (func $host_first_duplicate_stable_id (result i32)))
	(import "test.host" "AE_circle" (func $host_circle (param i32 f32 f32 f32 f32 i32 i32) (result i32)))
	(import "test.host" "AE_text" (func $host_text (param i32 i32 i32 f32 f32 f32 i32 i32) (result i32)))

	(func (export "normal_startup") (result i32)
		(local $selected_numerator i32) (local $selected_denominator i32)
		call $abi_major i32.const 0 i32.ne (if (then i32.const 1 return))
		call $abi_minor i32.const 0 i32.ne (if (then i32.const 2 return))
		call $state_ptr i32.const 1024 i32.ne (if (then i32.const 3 return))
		call $state_len i32.const 32768 i32.ne (if (then i32.const 4 return))
		call $state_schema i32.const 8 i32.ne (if (then i32.const 5 return))
		call $configure (if (then i32.const 6 return))
		i32.const 0x5eedcafe i32.const 0 f32.const 1024 f32.const 768 call $init
		(if (then i32.const 7 return))
		i32.const 9 i32.const 60000 f32.const 1001 f32.const 0 call $event
		(if (then i32.const 8 return))
		i32.const 60000 i32.const 1001 call $tick_rate
		local.set $selected_denominator local.set $selected_numerator
		local.get $selected_denominator i32.const 1 i32.ne (if (then i32.const 9 return))
		local.get $selected_numerator i32.const 120 i32.ne (if (then i32.const 10 return))
		call $render (if (then i32.const 11 return))
		call $host_duplicate_stable_ids (if (then i32.const 12 return))
		i32.const 0)
	;; Mutation/specificity controls prove the fake host accepts distinct IDs and
	;; rejects cross-primitive reuse, so a reject-everything registry cannot pass.
	(func (export "stable_id_registry_controls") (result i32)
		call $host_reset_frame
		i32.const 6000 f32.const 0 f32.const 0 f32.const 1 f32.const 0 i32.const -1 i32.const 1 call $host_circle drop
		i32.const 6001 i32.const 0 i32.const 0 f32.const 0 f32.const 0 f32.const 1 i32.const -1 i32.const 0 call $host_text drop
		call $host_duplicate_stable_ids i32.const 0 i32.ne (if (then i32.const 1 return))
		call $host_reset_frame
		i32.const 6000 f32.const 0 f32.const 0 f32.const 1 f32.const 0 i32.const -1 i32.const 1 call $host_circle drop
		i32.const 6000 i32.const 0 i32.const 0 f32.const 0 f32.const 0 f32.const 1 i32.const -1 i32.const 0 call $host_text drop
		call $host_duplicate_stable_ids i32.const 1 i32.ne (if (then i32.const 2 return))
		call $host_first_duplicate_stable_id i32.const 6000 i32.ne (if (then i32.const 3 return))
		i32.const 0)
)

(assert_return (invoke $aedicule_contract "normal_startup") (i32.const 0))
(assert_return (invoke $aedicule_contract "stable_id_registry_controls") (i32.const 0))
