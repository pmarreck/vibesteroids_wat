;; Production-module variants execute the same collision-free bullet trajectory
;; for one elapsed second. Rational rates use the whole ticks due at that time.
(module $rate_60_probe
	(import "sut_60" "memory" (memory $state 1))
	(import "sut_60" "AE_configure" (func $configure (result i32)))
	(import "sut_60" "AE_init" (func $init (param i32 i32 f32 f32) (result i32)))
	(import "sut_60" "AE_event" (func $event (param i32 i32 f32 f32) (result i32)))
	(import "sut_60" "AE_tick" (func $tick (param i32) (result i32)))
	(func $prepare
		(local $index i32)
		call $configure drop
		i32.const 0x5eed i32.const 0 f32.const 1024 f32.const 768 call $init drop
		i32.const 1 i32.const 3 f32.const 0 f32.const 0 call $event drop
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
	(func (export "drag_run") (result i64)
		call $prepare
		i32.const 1064 i64.const 100000000 i64.store
		i32.const 60 call $tick drop
		i32.const 1064 i64.load)
	(func (export "initial_timers") (result i32 i32)
		call $prepare i32.const 1116 i32.load i32.const 1132 i32.load)
	(func (export "power_timer") (result i32)
		call $prepare
		i32.const 16464 i32.const 1 i32.store
		i32.const 16472 i32.const 1048 i64.load i64.store
		i32.const 16480 i32.const 1056 i64.load i64.store
		i32.const 16504 i64.const 20000000 i64.store
		i32.const 1 call $tick drop
		i32.const 16520 i32.load)
	(func (export "blast_boundary") (param $due i32) (result i32 i32)
		call $prepare
		i32.const 26624 i32.const 1 i32.store i32.const 26648 i32.const 0 i32.store
		local.get $due i32.const 1 i32.sub call $tick drop
		i32.const 26624 i32.load
		i32.const 1 call $tick drop
		i32.const 26624 i32.load)
	(func (export "satellite_ping_boundary") (param $due i32) (result i32 i32)
		call $prepare
		i32.const 26656 i32.const 1 i32.store
		i32.const 26664 i64.const 200000000 i64.store
		i32.const 26672 i64.const 200000000 i64.store
		i32.const 26696 i64.const 1000000 i64.store
		i32.const 26712 i64.const 60000000 i64.store
		i32.const 26724 local.get $due i32.store
		local.get $due i32.const 1 i32.sub call $tick drop
		i32.const 26724 i32.load
		i32.const 1 call $tick drop
		i32.const 26724 i32.load)
	(func (export "satellite_quote_boundary") (param $due i32) (result i32 i32)
		call $prepare
		i32.const 26736 local.get $due i32.store
		local.get $due i32.const 1 i32.sub call $tick drop
		i32.const 26736 i32.load
		i32.const 1 call $tick drop
		i32.const 26736 i32.load)
)
(register "rate_60_probe" $rate_60_probe)
(module $rate_120_probe
	(import "sut_120" "memory" (memory $state 1))
	(import "sut_120" "AE_configure" (func $configure (result i32)))
	(import "sut_120" "AE_init" (func $init (param i32 i32 f32 f32) (result i32)))
	(import "sut_120" "AE_event" (func $event (param i32 i32 f32 f32) (result i32)))
	(import "sut_120" "AE_tick" (func $tick (param i32) (result i32)))
	(func $prepare
		(local $index i32)
		call $configure drop
		i32.const 0x5eed i32.const 0 f32.const 1024 f32.const 768 call $init drop
		i32.const 1 i32.const 3 f32.const 0 f32.const 0 call $event drop
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
	(func (export "drag_run") (result i64)
		call $prepare
		i32.const 1064 i64.const 100000000 i64.store
		i32.const 120 call $tick drop
		i32.const 1064 i64.load)
	(func (export "initial_timers") (result i32 i32)
		call $prepare i32.const 1116 i32.load i32.const 1132 i32.load)
	(func (export "power_timer") (result i32)
		call $prepare
		i32.const 16464 i32.const 1 i32.store
		i32.const 16472 i32.const 1048 i64.load i64.store
		i32.const 16480 i32.const 1056 i64.load i64.store
		i32.const 16504 i64.const 20000000 i64.store
		i32.const 1 call $tick drop
		i32.const 16520 i32.load)
	(func (export "blast_boundary") (param $due i32) (result i32 i32)
		call $prepare
		i32.const 26624 i32.const 1 i32.store i32.const 26648 i32.const 0 i32.store
		local.get $due i32.const 1 i32.sub call $tick drop
		i32.const 26624 i32.load
		i32.const 1 call $tick drop
		i32.const 26624 i32.load)
	(func (export "satellite_ping_boundary") (param $due i32) (result i32 i32)
		call $prepare
		i32.const 26656 i32.const 1 i32.store
		i32.const 26664 i64.const 200000000 i64.store
		i32.const 26672 i64.const 200000000 i64.store
		i32.const 26696 i64.const 1000000 i64.store
		i32.const 26712 i64.const 60000000 i64.store
		i32.const 26724 local.get $due i32.store
		local.get $due i32.const 1 i32.sub call $tick drop
		i32.const 26724 i32.load
		i32.const 1 call $tick drop
		i32.const 26724 i32.load)
	(func (export "satellite_quote_boundary") (param $due i32) (result i32 i32)
		call $prepare
		i32.const 26736 local.get $due i32.store
		local.get $due i32.const 1 i32.sub call $tick drop
		i32.const 26736 i32.load
		i32.const 1 call $tick drop
		i32.const 26736 i32.load)
)
(register "rate_120_probe" $rate_120_probe)
(module $rate_60000_1001_probe
	(import "sut_60000_1001" "memory" (memory $state 1))
	(import "sut_60000_1001" "AE_configure" (func $configure (result i32)))
	(import "sut_60000_1001" "AE_init" (func $init (param i32 i32 f32 f32) (result i32)))
	(import "sut_60000_1001" "AE_event" (func $event (param i32 i32 f32 f32) (result i32)))
	(import "sut_60000_1001" "AE_tick" (func $tick (param i32) (result i32)))
	(func $prepare
		(local $index i32)
		call $configure drop
		i32.const 0x5eed i32.const 0 f32.const 1024 f32.const 768 call $init drop
		i32.const 1 i32.const 3 f32.const 0 f32.const 0 call $event drop
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
	(func (export "initial_timers") (result i32 i32)
		call $prepare i32.const 1116 i32.load i32.const 1132 i32.load)
	(func (export "power_timer") (result i32)
		call $prepare
		i32.const 16464 i32.const 1 i32.store
		i32.const 16472 i32.const 1048 i64.load i64.store
		i32.const 16480 i32.const 1056 i64.load i64.store
		i32.const 16504 i64.const 20000000 i64.store
		i32.const 1 call $tick drop
		i32.const 16520 i32.load)
	(func (export "blast_boundary") (param $due i32) (result i32 i32)
		call $prepare
		i32.const 26624 i32.const 1 i32.store i32.const 26648 i32.const 0 i32.store
		local.get $due i32.const 1 i32.sub call $tick drop
		i32.const 26624 i32.load
		i32.const 1 call $tick drop
		i32.const 26624 i32.load)
	(func (export "satellite_ping_boundary") (param $due i32) (result i32 i32)
		call $prepare
		i32.const 26656 i32.const 1 i32.store
		i32.const 26664 i64.const 200000000 i64.store
		i32.const 26672 i64.const 200000000 i64.store
		i32.const 26696 i64.const 1000000 i64.store
		i32.const 26712 i64.const 60000000 i64.store
		i32.const 26724 local.get $due i32.store
		local.get $due i32.const 1 i32.sub call $tick drop
		i32.const 26724 i32.load
		i32.const 1 call $tick drop
		i32.const 26724 i32.load)
	(func (export "satellite_quote_boundary") (param $due i32) (result i32 i32)
		call $prepare
		i32.const 26736 local.get $due i32.store
		local.get $due i32.const 1 i32.sub call $tick drop
		i32.const 26736 i32.load
		i32.const 1 call $tick drop
		i32.const 26736 i32.load)
)
(module $rate_120000_1001_probe
	(import "sut_120000_1001" "memory" (memory $state 1))
	(import "sut_120000_1001" "AE_configure" (func $configure (result i32)))
	(import "sut_120000_1001" "AE_init" (func $init (param i32 i32 f32 f32) (result i32)))
	(import "sut_120000_1001" "AE_event" (func $event (param i32 i32 f32 f32) (result i32)))
	(import "sut_120000_1001" "AE_tick" (func $tick (param i32) (result i32)))
	(func $prepare
		(local $index i32)
		call $configure drop
		i32.const 0x5eed i32.const 0 f32.const 1024 f32.const 768 call $init drop
		i32.const 1 i32.const 3 f32.const 0 f32.const 0 call $event drop
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
	(func (export "initial_timers") (result i32 i32)
		call $prepare i32.const 1116 i32.load i32.const 1132 i32.load)
	(func (export "power_timer") (result i32)
		call $prepare
		i32.const 16464 i32.const 1 i32.store
		i32.const 16472 i32.const 1048 i64.load i64.store
		i32.const 16480 i32.const 1056 i64.load i64.store
		i32.const 16504 i64.const 20000000 i64.store
		i32.const 1 call $tick drop
		i32.const 16520 i32.load)
	(func (export "blast_boundary") (param $due i32) (result i32 i32)
		call $prepare
		i32.const 26624 i32.const 1 i32.store i32.const 26648 i32.const 0 i32.store
		local.get $due i32.const 1 i32.sub call $tick drop
		i32.const 26624 i32.load
		i32.const 1 call $tick drop
		i32.const 26624 i32.load)
	(func (export "satellite_ping_boundary") (param $due i32) (result i32 i32)
		call $prepare
		i32.const 26656 i32.const 1 i32.store
		i32.const 26664 i64.const 200000000 i64.store
		i32.const 26672 i64.const 200000000 i64.store
		i32.const 26696 i64.const 1000000 i64.store
		i32.const 26712 i64.const 60000000 i64.store
		i32.const 26724 local.get $due i32.store
		local.get $due i32.const 1 i32.sub call $tick drop
		i32.const 26724 i32.load
		i32.const 1 call $tick drop
		i32.const 26724 i32.load)
	(func (export "satellite_quote_boundary") (param $due i32) (result i32 i32)
		call $prepare
		i32.const 26736 local.get $due i32.store
		local.get $due i32.const 1 i32.sub call $tick drop
		i32.const 26736 i32.load
		i32.const 1 call $tick drop
		i32.const 26736 i32.load)
)

(assert_return (invoke $rate_60_probe "run") (i64.const 160000000))
(assert_return (invoke $rate_120_probe "run") (i64.const 160000000))
(assert_return (invoke $rate_60000_1001_probe "run") (i64.const 159059000))
(assert_return (invoke $rate_120000_1001_probe "run") (i64.const 159559500))

;; Every lifecycle uses the same source-authored duration conversion. These
;; probes cover reset timers, a collected 20-second reward, and the tick just
;; before/at hazardous-blast expiry across integral and rational rates.
(assert_return (invoke $rate_60_probe "initial_timers") (i32.const 120) (i32.const 240))
(assert_return (invoke $rate_120_probe "initial_timers") (i32.const 240) (i32.const 480))
(assert_return (invoke $rate_60000_1001_probe "initial_timers") (i32.const 119) (i32.const 239))
(assert_return (invoke $rate_120000_1001_probe "initial_timers") (i32.const 239) (i32.const 479))
(assert_return (invoke $rate_60_probe "power_timer") (i32.const 1200))
(assert_return (invoke $rate_120_probe "power_timer") (i32.const 2400))
(assert_return (invoke $rate_60000_1001_probe "power_timer") (i32.const 1198))
(assert_return (invoke $rate_120000_1001_probe "power_timer") (i32.const 2397))
(assert_return (invoke $rate_60_probe "blast_boundary" (i32.const 72)) (i32.const 1) (i32.const 0))
(assert_return (invoke $rate_120_probe "blast_boundary" (i32.const 144)) (i32.const 1) (i32.const 0))
(assert_return (invoke $rate_60000_1001_probe "blast_boundary" (i32.const 71)) (i32.const 1) (i32.const 0))
(assert_return (invoke $rate_120000_1001_probe "blast_boundary" (i32.const 143)) (i32.const 1) (i32.const 0))


;; The delayed phone-home cue resets on the same three simulated seconds at
;; integral and NTSC-derived rates, without sleeps or wall-clock observation.
(assert_return (invoke $rate_60_probe "satellite_ping_boundary" (i32.const 90)) (i32.const 1) (i32.const 180))
(assert_return (invoke $rate_120_probe "satellite_ping_boundary" (i32.const 180)) (i32.const 1) (i32.const 360))
(assert_return (invoke $rate_60000_1001_probe "satellite_ping_boundary" (i32.const 89)) (i32.const 1) (i32.const 179))
(assert_return (invoke $rate_120000_1001_probe "satellite_ping_boundary" (i32.const 179)) (i32.const 1) (i32.const 359))

;; The player-attributed quote begins on the same one simulated-second boundary
;; at integral and NTSC-derived rates, independently of host audio duration.
(assert_return (invoke $rate_60_probe "satellite_quote_boundary" (i32.const 60)) (i32.const 1) (i32.const 0))
(assert_return (invoke $rate_120_probe "satellite_quote_boundary" (i32.const 120)) (i32.const 1) (i32.const 0))
(assert_return (invoke $rate_60000_1001_probe "satellite_quote_boundary" (i32.const 59)) (i32.const 1) (i32.const 0))
(assert_return (invoke $rate_120000_1001_probe "satellite_quote_boundary" (i32.const 119)) (i32.const 1) (i32.const 0))

;; Linearized retention factors keep one-second damping perceptually equal
;; even though integer rounding differs across simulation step counts.
(module $drag_equal_time_probe
	(import "rate_60_probe" "drag_run" (func $drag_60 (result i64)))
	(import "rate_120_probe" "drag_run" (func $drag_120 (result i64)))
	(func (export "run") (result i32)
		(local $difference i64)
		call $drag_60 call $drag_120 i64.sub local.tee $difference i64.const 0 i64.lt_s
		(if (then i64.const 0 local.get $difference i64.sub local.set $difference))
		local.get $difference i64.const 500000 i64.le_u)
)
(assert_return (invoke $drag_equal_time_probe "run") (i32.const 1))
