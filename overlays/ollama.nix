final: prev: {
  ollama = prev.ollama.overrideAttrs (old: rec {
    version = "0.14.3-rc2"; 
    src = prev.fetchFromGitHub {
      owner = "ollama";
      repo = "ollama";
      tag = "v${version}";
      hash = "sha256-0L5mlYEkvVaGRwrRYJZAMyEktStZYmQe4pa+Et/AgCs=";
    };

    vendorHash = "sha256-WdHAjCD20eLj0d9v1K6VYP8vJ+IZ8BEZ3CciYLLMtxc=";
    acceleration = "cuda";
  });
}
