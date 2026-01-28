{
  lib,
  pkgs,
  ...
}:
{

  home.packages = [
    pkgs.claude-code
  ];

  programs.opencode = {
    enable = true;
    package = pkgs.opencode;
    settings = {
      "$schema" = "https://opencode.ai/config.json";
      "model" = "ollama/glm-4.7-flash-tool:latest";
      "provider" = {
        "ollama" = {
          "npm" = "@ai-sdk/openai-compatible";
          "name" = "Ollama";
          "options" = {
            "baseURL" = "http://127.0.0.1:11434/v1";
          };
          "models" = {
            "glm-4.7-flash-tool:latest" = {
              "name" = "glm-4.7-flash-tool:latest";
              "reasoning" = true;
              "tools" = true;
            };
            "gpt-oss:latest" = {
              "name" = "gpt-oss:latest";
              "reasoning" = true;
              "tools" = true;
            };
            "gemma3:4b" = {
              "name" = "gemma3:4b";
              "reasoning" = true;
              "tools" = true;
            };
          };
        };
      };
    };
  };
}
