;; The concrete game must retain the mandatory v0 guest lifecycle while its
;; display event and fixed 60/1 rate stay independent of host display timing.
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

	(func (export "normal_startup") (result i32)
		(local $selected_numerator i32) (local $selected_denominator i32)
		call $abi_major i32.const 0 i32.ne (if (then i32.const 1 return))
		call $abi_minor i32.const 0 i32.ne (if (then i32.const 2 return))
		call $state_ptr i32.const 1024 i32.ne (if (then i32.const 3 return))
		call $state_len i32.const 16384 i32.ne (if (then i32.const 4 return))
		call $state_schema i32.const 4 i32.ne (if (then i32.const 5 return))
		call $configure (if (then i32.const 6 return))
		i32.const 0x5eedcafe i32.const 0 f32.const 1024 f32.const 768 call $init
		(if (then i32.const 7 return))
		i32.const 9 i32.const 60000 f32.const 1001 f32.const 0 call $event
		(if (then i32.const 8 return))
		i32.const 60000 i32.const 1001 call $tick_rate
		local.set $selected_denominator local.set $selected_numerator
		local.get $selected_denominator i32.const 1 i32.ne (if (then i32.const 9 return))
		local.get $selected_numerator i32.const 60 i32.ne (if (then i32.const 10 return))
		call $render (if (then i32.const 11 return))
		i32.const 0)
)

(assert_return (invoke $aedicule_contract "normal_startup") (i32.const 0))
