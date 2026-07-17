;; Production-module variants execute the same collision-free bullet trajectory
;; for one elapsed second. Rational rates use the whole ticks due at that time.
(module $rate_60_probe
	(import "sut_60" "memory" (memory $state 1))
	(import "sut_60" "AE_configure" (func $configure (result i32)))
	(import "sut_60" "AE_init" (func $init (param i32 i32 f32 f32) (result i32)))
	(import "sut_60" "AE_tick" (func $tick (param i32) (result i32)))
	(func $prepare
		(local $index i32)
		call $configure drop
		i32.const 0x5eed i32.const 0 f32.const 1024 f32.const 768 call $init drop
		(block $done (loop $next
			local.get $index i32.const 32 i32.ge_u br_if $done
			i32.const 4352 local.get $index i32.const 80 i32.mul i32.add i32.const 0 i32.store
			local.get $index i32.const 1 i32.add local.set $index br $next))
		i32.const 4352 i32.const 1 i32.store
		i32.const 4368 i64.const 900000000 i64.store
		i32.const 4376 i64.const 700000000 i64.store
		i32.const 4400 i64.const 10000000 i64.store
		i32.const 1280 i32.const 1 i32.store
		i32.const 1288 i64.const 100000000 i64.store
		i32.const 1296 i64.const 100000000 i64.store
		i32.const 1304 i64.const 60000000 i64.store
		i32.const 1312 i64.const 0 i64.store
		i32.const 1320 i64.const 0 i64.store
		i32.const 2156 i32.const 0 i32.store)
	(func (export "run") (result i64)
		call $prepare
		i32.const 60 call $tick drop
		i32.const 1288 i64.load)
)
(module $rate_120_probe
	(import "sut_120" "memory" (memory $state 1))
	(import "sut_120" "AE_configure" (func $configure (result i32)))
	(import "sut_120" "AE_init" (func $init (param i32 i32 f32 f32) (result i32)))
	(import "sut_120" "AE_tick" (func $tick (param i32) (result i32)))
	(func $prepare
		(local $index i32)
		call $configure drop
		i32.const 0x5eed i32.const 0 f32.const 1024 f32.const 768 call $init drop
		(block $done (loop $next
			local.get $index i32.const 32 i32.ge_u br_if $done
			i32.const 4352 local.get $index i32.const 80 i32.mul i32.add i32.const 0 i32.store
			local.get $index i32.const 1 i32.add local.set $index br $next))
		i32.const 4352 i32.const 1 i32.store
		i32.const 4368 i64.const 900000000 i64.store
		i32.const 4376 i64.const 700000000 i64.store
		i32.const 4400 i64.const 10000000 i64.store
		i32.const 1280 i32.const 1 i32.store
		i32.const 1288 i64.const 100000000 i64.store
		i32.const 1296 i64.const 100000000 i64.store
		i32.const 1304 i64.const 60000000 i64.store
		i32.const 1312 i64.const 0 i64.store
		i32.const 1320 i64.const 0 i64.store
		i32.const 2156 i32.const 0 i32.store)
	(func (export "run") (result i64)
		call $prepare
		i32.const 120 call $tick drop
		i32.const 1288 i64.load)
)
(module $rate_60000_1001_probe
	(import "sut_60000_1001" "memory" (memory $state 1))
	(import "sut_60000_1001" "AE_configure" (func $configure (result i32)))
	(import "sut_60000_1001" "AE_init" (func $init (param i32 i32 f32 f32) (result i32)))
	(import "sut_60000_1001" "AE_tick" (func $tick (param i32) (result i32)))
	(func $prepare
		(local $index i32)
		call $configure drop
		i32.const 0x5eed i32.const 0 f32.const 1024 f32.const 768 call $init drop
		(block $done (loop $next
			local.get $index i32.const 32 i32.ge_u br_if $done
			i32.const 4352 local.get $index i32.const 80 i32.mul i32.add i32.const 0 i32.store
			local.get $index i32.const 1 i32.add local.set $index br $next))
		i32.const 4352 i32.const 1 i32.store
		i32.const 4368 i64.const 900000000 i64.store
		i32.const 4376 i64.const 700000000 i64.store
		i32.const 4400 i64.const 10000000 i64.store
		i32.const 1280 i32.const 1 i32.store
		i32.const 1288 i64.const 100000000 i64.store
		i32.const 1296 i64.const 100000000 i64.store
		i32.const 1304 i64.const 60000000 i64.store
		i32.const 1312 i64.const 0 i64.store
		i32.const 1320 i64.const 0 i64.store
		i32.const 2156 i32.const 0 i32.store)
	(func (export "run") (result i64)
		call $prepare
		i32.const 59 call $tick drop
		i32.const 1288 i64.load)
)
(module $rate_120000_1001_probe
	(import "sut_120000_1001" "memory" (memory $state 1))
	(import "sut_120000_1001" "AE_configure" (func $configure (result i32)))
	(import "sut_120000_1001" "AE_init" (func $init (param i32 i32 f32 f32) (result i32)))
	(import "sut_120000_1001" "AE_tick" (func $tick (param i32) (result i32)))
	(func $prepare
		(local $index i32)
		call $configure drop
		i32.const 0x5eed i32.const 0 f32.const 1024 f32.const 768 call $init drop
		(block $done (loop $next
			local.get $index i32.const 32 i32.ge_u br_if $done
			i32.const 4352 local.get $index i32.const 80 i32.mul i32.add i32.const 0 i32.store
			local.get $index i32.const 1 i32.add local.set $index br $next))
		i32.const 4352 i32.const 1 i32.store
		i32.const 4368 i64.const 900000000 i64.store
		i32.const 4376 i64.const 700000000 i64.store
		i32.const 4400 i64.const 10000000 i64.store
		i32.const 1280 i32.const 1 i32.store
		i32.const 1288 i64.const 100000000 i64.store
		i32.const 1296 i64.const 100000000 i64.store
		i32.const 1304 i64.const 60000000 i64.store
		i32.const 1312 i64.const 0 i64.store
		i32.const 1320 i64.const 0 i64.store
		i32.const 2156 i32.const 0 i32.store)
	(func (export "run") (result i64)
		call $prepare
		i32.const 119 call $tick drop
		i32.const 1288 i64.load)
)

(assert_return (invoke $rate_60_probe "run") (i64.const 160000000))
(assert_return (invoke $rate_120_probe "run") (i64.const 160000000))
(assert_return (invoke $rate_60000_1001_probe "run") (i64.const 159059000))
(assert_return (invoke $rate_120000_1001_probe "run") (i64.const 159559500))
