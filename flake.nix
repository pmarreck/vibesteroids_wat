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
					application = pkgs.runCommand "vibesteroids_wat_code-0.1.0" {} ''
						mkdir -p $out/share/vibesteroids_wat
						cp ${./code.wat} $out/share/vibesteroids_wat/code.wat
					'';
				in {
					inherit application frontplane;
					default = pkgs.runCommand "vibesteroids_wat-0.1.0" {
						nativeBuildInputs = [ pkgs.makeWrapper ];
						meta.mainProgram = "vibesteroids-wat";
					} ''
						mkdir -p $out/bin $out/share/vibesteroids_wat
						ln -s ${application}/share/vibesteroids_wat/code.wat \
							$out/share/vibesteroids_wat/code.wat
						makeWrapper ${frontplane}/bin/gpui-wasm \
							$out/bin/vibesteroids-wat \
							--set GPUI_WASM_DEFAULT_PLUGIN $out/share/vibesteroids_wat/code.wat
						makeWrapper ${frontplane}/bin/gpui-wasm-render \
							$out/bin/vibesteroids-wat-render \
							--set GPUI_WASM_DEFAULT_PLUGIN $out/share/vibesteroids_wat/code.wat
					'';
				});

			checks = forAllSystems (system:
				let
					pkgs = pkgsFor system;
				in {
					package = self.packages.${system}.default;
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
