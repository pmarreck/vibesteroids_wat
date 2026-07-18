;; Enemy and package scheduling begins with independently seeded 60--180
;; simulated-second countdowns. Forced countdowns keep the proof fast.
(assert_return (invoke $vibesteroids_tests "reset") (i32.const 0))
(assert_return
	(invoke $vibesteroids_tests "state_i32_between"
		(i32.const 15488) (i32.const 3600) (i32.const 10800))
	(i32.const 1))
(assert_return
	(invoke $vibesteroids_tests "state_i32_between"
		(i32.const 15492) (i32.const 3600) (i32.const 10800))
	(i32.const 1))

;; A due UFO enters from exactly one horizontal edge with a signed direction.
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 15488) (i32.const 1)))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i32" (i32.const 15008)) (i32.const 1))
(assert_return
	(invoke $vibesteroids_tests "state_i32_is_either"
		(i32.const 15012) (i32.const -1) (i32.const 1))
	(i32.const 1))
(assert_return
	(invoke $vibesteroids_tests "state_i32_between"
		(i32.const 15024) (i32.const 100000000) (i32.const 668000000))
	(i32.const 1))

;; Horizontal motion is per-second fixed-point and the UFO has a distinct path.
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 15008) (i32.const 1)))
(assert_return (invoke $vibesteroids_tests "state_set_i32" (i32.const 15012) (i32.const 1)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 15016) (i64.const 100000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 15024) (i64.const 200000000)))
(assert_return (invoke $vibesteroids_tests "state_set_i64" (i32.const 15032) (i64.const 140000000)))
(assert_return (invoke $vibesteroids_tests "tick" (i32.const 1)) (i32.const 0))
(assert_return (invoke $vibesteroids_tests "state_i64" (i32.const 15016)) (i64.const 102333333))
(assert_return (invoke $vibesteroids_tests "host_reset_frame"))
(assert_return (invoke $vibesteroids_tests "render") (i32.const 0))
(assert_return (invoke $vibesteroids_tests "host_ufo_paths") (i32.const 1))
