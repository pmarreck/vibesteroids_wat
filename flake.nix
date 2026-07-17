{
	description = "Vibesteroids game for the Mecha Aedicule WAT frontplane";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		mecha-aedicule = {
			url = "github:pmarreck/mecha-aedicule/yolo";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, mecha-aedicule }:
		let
			systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
			forAllSystems = nixpkgs.lib.genAttrs systems;
			pkgsFor = system: import nixpkgs { inherit system; };
		in {
			packages = forAllSystems (system:
				let
					pkgs = pkgsFor system;
					frontplane = mecha-aedicule.packages.${system}.frontplane;
					application = pkgs.runCommand "vibesteroids-aedicule-wat-0.1.0" {} ''
						mkdir -p $out/share/vibesteroids-aedicule
						cp ${./code.wat} $out/share/vibesteroids-aedicule/code.wat
					'';
				in {
					inherit application frontplane;
					default = pkgs.runCommand "vibesteroids-aedicule-0.1.0" {
						nativeBuildInputs = [ pkgs.makeWrapper ];
						meta.mainProgram = "vibesteroids-aedicule";
					} ''
						mkdir -p $out/bin $out/share/vibesteroids-aedicule
						ln -s ${application}/share/vibesteroids-aedicule/code.wat \
							$out/share/vibesteroids-aedicule/code.wat
						makeWrapper ${frontplane}/bin/gpui-wasm \
							$out/bin/vibesteroids-aedicule \
							--set GPUI_WASM_DEFAULT_PLUGIN $out/share/vibesteroids-aedicule/code.wat
						makeWrapper ${frontplane}/bin/gpui-wasm-render \
							$out/bin/vibesteroids-aedicule-render \
							--set GPUI_WASM_DEFAULT_PLUGIN $out/share/vibesteroids-aedicule/code.wat
					'';
				});

			checks = forAllSystems (system:
				let
					pkgs = pkgsFor system;
				in {
					package = self.packages.${system}.default;
					wast = pkgs.stdenvNoCC.mkDerivation {
						pname = "vibesteroids-aedicule-wast";
						version = "0.1.0";
						src = builtins.path {
							path = ./.;
							name = "vibesteroids-aedicule-test-source";
							filter = path: type:
								let
									root = toString ./.;
									relative = pkgs.lib.removePrefix root (toString path);
								in relative == ""
									|| relative == "/tests"
									|| relative == "/tests/wast"
									|| relative == "/code.wat"
									|| relative == "/tests/run-wast"
									|| relative == "/tests/lint-wat"
									|| pkgs.lib.hasPrefix "/tests/wast/" relative;
						};
						nativeBuildInputs = with pkgs; [ bash gawk wasmtime ];
						buildPhase = ''
							export HOME=$TMPDIR
							patchShebangs tests/run-wast tests/lint-wat
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
