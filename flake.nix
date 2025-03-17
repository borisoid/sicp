{
    inputs = {
        nixPackagesUnstable.url = "flake:nixPackagesUnstable";
    };

    outputs = { nixPackagesUnstable, ... }@inputs:
    let
        system = "x86_64-linux";

        p = nixPackagesUnstable.legacyPackages.${system};
    in {
        devShells.${system}.default = (p.buildFHSEnv {
            name = "sicp-fhs-env";
            targetPkgs = p: let
                py = p.python3Packages;
            in [
                p.mitscheme

                # Fixes ascii escape chars for mit-scheme repl.
                # Use like this: `rlwrap scheme`
                p.rlwrap

                py.python
            ];

            runScript = "bash";
        }).env;
    };
}
