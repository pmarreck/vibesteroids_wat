{
	description = "vibesteroids_wat game for the Mecha Aedicule frontplane";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		aedicule = {
			url = "github:pmarreck/aedicule/yolo";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, aedicule }:
		let
			systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
			forAllSystems = nixpkgs.lib.genAttrs systems;
			pkgsFor = system: import nixpkgs { inherit system; };
		in {
			packages = forAllSystems (system:
				let
					pkgs = pkgsFor system;
					frontplane = aedicule.packages.${system}.frontplane;
					application = pkgs.runCommand "vibesteroids_wat_code-0.1.0" {
						nativeBuildInputs = [ pkgs.gawk ];
					} ''
						mkdir -p $out/share/vibesteroids_wat/assets/audio \
							$out/share/vibesteroids_wat/lib
						cp ${./code.wat} $out/share/vibesteroids_wat/code.wat
						cp ${./assets/audio/satellite-destroyed.flac} \
							$out/share/vibesteroids_wat/assets/audio/satellite-destroyed.flac
						cp ${./README.md} $out/share/vibesteroids_wat/README.md
						cp ${./LICENSE} $out/share/vibesteroids_wat/LICENSE
						mkdir -p $out/share/vibesteroids_wat/tests
						VIBESTEROIDS_WAT_ROOT=${./.} \
							bash ${./tests/compose-wast} \
							>$out/share/vibesteroids_wat/tests/main.wast
					'';
					aed = pkgs.runCommand "vibesteroids_wat_aed-0.1.0" {
						nativeBuildInputs = [ frontplane ];
					} ''
						mkdir -p $out
						aedicule --package \
							${application}/share/vibesteroids_wat \
							$out/vibesteroids.aed
					'';
				in {
					inherit aed application frontplane;
					default = pkgs.runCommand "vibesteroids_wat-0.1.0" {
						nativeBuildInputs = [ pkgs.makeWrapper ];
						meta.mainProgram = "vibesteroids-wat";
					} ''
						mkdir -p $out/bin $out/share
						ln -s ${application}/share/vibesteroids_wat \
							$out/share/vibesteroids_wat
						makeWrapper ${frontplane}/bin/aedicule \
							$out/bin/vibesteroids-wat \
							--set AEDICULE_DEFAULT_APPLICATION $out/share/vibesteroids_wat
						makeWrapper ${frontplane}/bin/aedicule-render \
							$out/bin/vibesteroids-wat-render \
							--set AEDICULE_DEFAULT_APPLICATION $out/share/vibesteroids_wat
					'';
				});

			checks = forAllSystems (system:
				let
					pkgs = pkgsFor system;
					frontplane = self.packages.${system}.frontplane;
					application = self.packages.${system}.application;
				in {
					package = self.packages.${system}.default;
					runtime = pkgs.runCommand "vibesteroids_wat_aedicule_runtime" {
						nativeBuildInputs = [ frontplane pkgs.bash pkgs.ripgrep ];
					} ''
						mkdir -p $out
						if ! aedicule-render \
							${application}/share/vibesteroids_wat \
							--ticks 1 -o $out/frame.svg 2>$TMPDIR/runtime.stderr; then
							cat $TMPDIR/runtime.stderr >&2
							exit 1
						fi
						if test -s $TMPDIR/runtime.stderr; then
							cat $TMPDIR/runtime.stderr >&2
							exit 1
						fi
						if ! aedicule-render \
							${application}/share/vibesteroids_wat \
							--activate-action 8 --ticks 1 \
							-o $out/started.svg 2>$TMPDIR/action.stderr; then
							cat $TMPDIR/action.stderr >&2
							exit 1
						fi
						if test -s $TMPDIR/action.stderr; then
							cat $TMPDIR/action.stderr >&2
							exit 1
						fi
						if rg --fixed-strings --quiet 'data-command-id="1"' $out/frame.svg; then
							echo 'boot gate rendered the player ship before activation' >&2
							exit 1
						fi
						if ! rg --fixed-strings --quiet 'data-command-id="1"' $out/started.svg; then
							echo 'standalone Start action did not spawn the player ship' >&2
							exit 1
						fi
						bash ${./tests/integration/aedicule_touch_timeline} \
							${frontplane}/bin/aedicule-render \
							${application}/share/vibesteroids_wat \
							$out/touch-timeline
					'';
					wast = pkgs.stdenvNoCC.mkDerivation {
						pname = "vibesteroids_wat_wast";
						version = "0.1.0";
						src = builtins.path {
							path = ./.;
							name = "vibesteroids_wat_test_source";
							filter = path: type:
								let
									root = toString ./.;
									relative = pkgs.lib.removePrefix root (toString path);
								in relative == ""
									|| relative == "/tests"
									|| relative == "/tests/wast"
									|| relative == "/code.wat"
									|| relative == "/tests/run-wast"
									|| relative == "/tests/compose-wast"
									|| relative == "/tests/lint-wat"
									|| pkgs.lib.hasPrefix "/tests/wast/" relative;
						};
						nativeBuildInputs = with pkgs; [ bash gawk wasmtime ];
						buildPhase = ''
							export HOME=$TMPDIR
							patchShebangs tests/run-wast tests/compose-wast tests/lint-wat
							./tests/run-wast
							./tests/lint-wat
						'';
						installPhase = ''
							mkdir -p $out
							printf 'WAST and WAT policy checks passed\n' >$out/result
						'';
					};
				});

			devShells = forAllSystems (system:
				let
					pkgs = pkgsFor system;
				in {
					default = pkgs.mkShell {
						packages = with pkgs; [
							actionlint
							gawk
							nix
							ripgrep
							shellcheck
							wasmtime
						];
					};
				});
		};
}
