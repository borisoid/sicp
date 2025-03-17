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
            targetPkgs = p: [
                p.mitscheme

                # Fixes ascii escape chars for mit-scheme repl.
                # Use like this: `rlwrap scheme`
                p.rlwrap
            ];

            runScript = "bash";
        }).env;
    };
}
