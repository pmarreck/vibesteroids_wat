;; ABI fixture proving display-refresh delivery precedes rational rate selection.
(module $select_120_fixture
	(global $display_numerator (mut i32) (i32.const 0))
	(global $display_denominator (mut i32) (i32.const 0))
	(global $event_count (mut i32) (i32.const 0))
	(global $prior_numerator (mut i32) (i32.const 0))
	(global $prior_denominator (mut i32) (i32.const 0))

	(func (export "AE_event") (param $kind i32) (param $code i32) (param $a f32) (param f32) (result i32)
		local.get $kind i32.const 9 i32.eq
		(if (then
			local.get $code global.set $display_numerator
			local.get $a i32.trunc_sat_f32_u global.set $display_denominator
			global.get $event_count i32.const 1 i32.add global.set $event_count))
		i32.const 0)
	(func (export "AE_tick_rate") (param $current_numerator i32)
		(param $current_denominator i32) (result i32 i32)
		local.get $current_numerator global.set $prior_numerator
		local.get $current_denominator global.set $prior_denominator
		global.get $display_numerator i32.const 60000 i32.eq
		global.get $display_denominator i32.const 1001 i32.eq i32.and
		(if (result i32 i32)
			(then i32.const 120000 i32.const 1001)
			(else local.get $current_numerator local.get $current_denominator)))

	(func (export "display_numerator") (result i32) global.get $display_numerator)
	(func (export "display_denominator") (result i32) global.get $display_denominator)
	(func (export "event_count") (result i32) global.get $event_count)
	(func (export "prior_numerator") (result i32) global.get $prior_numerator)
	(func (export "prior_denominator") (result i32) global.get $prior_denominator)
)

(assert_return
	(invoke $select_120_fixture "AE_event"
		(i32.const 9) (i32.const 60000) (f32.const 1001) (f32.const 0))
	(i32.const 0))
(assert_return
	(invoke $select_120_fixture "AE_tick_rate" (i32.const 60) (i32.const 1))
	(i32.const 120000) (i32.const 1001))
(assert_return (invoke $select_120_fixture "event_count") (i32.const 1))
(assert_return (invoke $select_120_fixture "display_numerator") (i32.const 60000))
(assert_return (invoke $select_120_fixture "display_denominator") (i32.const 1001))
(assert_return (invoke $select_120_fixture "prior_numerator") (i32.const 60))
(assert_return (invoke $select_120_fixture "prior_denominator") (i32.const 1))

;; A following guest declares no replacement rate. Aedicule independently owns
;; adopting the last reported display rate after this return value.
(module $follow_display_fixture
	(global $display_numerator (mut i32) (i32.const 0))
	(global $display_denominator (mut i32) (i32.const 0))
	(global $event_count (mut i32) (i32.const 0))

	(func (export "AE_event") (param $kind i32) (param $code i32) (param $a f32) (param f32) (result i32)
		local.get $kind i32.const 9 i32.eq
		(if (then
			local.get $code global.set $display_numerator
			local.get $a i32.trunc_sat_f32_u global.set $display_denominator
			global.get $event_count i32.const 1 i32.add global.set $event_count))
		i32.const 0)
	(func (export "AE_tick_rate") (param $current_numerator i32)
		(param $current_denominator i32) (result i32 i32)
		i32.const 0 i32.const 0)
	(func (export "display_numerator") (result i32) global.get $display_numerator)
	(func (export "display_denominator") (result i32) global.get $display_denominator)
	(func (export "event_count") (result i32) global.get $event_count)
)

(assert_return
	(invoke $follow_display_fixture "AE_event"
		(i32.const 9) (i32.const 120000) (f32.const 1001) (f32.const 0))
	(i32.const 0))
(assert_return
	(invoke $follow_display_fixture "AE_tick_rate" (i32.const 60000) (i32.const 1001))
	(i32.const 0) (i32.const 0))
(assert_return (invoke $follow_display_fixture "event_count") (i32.const 1))
(assert_return (invoke $follow_display_fixture "display_numerator") (i32.const 120000))
(assert_return (invoke $follow_display_fixture "display_denominator") (i32.const 1001))
