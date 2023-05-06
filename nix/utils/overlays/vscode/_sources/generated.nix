# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  Ruby = {
    pname = "Ruby";
    version = "0.28.1";
    src = fetchurl {
      url = "https://rebornix.gallery.vsassets.io/_apis/public/gallery/publisher/rebornix/extension/Ruby/0.28.1/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "Ruby-0.28.1.zip";
      sha256 = "sha256-HAUdv+2T+neJ5aCGiQ37pCO6x6r57HIUnLm4apg9L50=";
    };
    name = "Ruby";
    publisher = "rebornix";
  };
  activitywatch = {
    pname = "activitywatch";
    version = "0.5.0";
    src = fetchurl {
      url = "https://activitywatch.gallery.vsassets.io/_apis/public/gallery/publisher/activitywatch/extension/aw-watcher-vscode/0.5.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "aw-watcher-vscode-0.5.0.zip";
      sha256 = "sha256-OrdIhgNXpEbLXYVJAx/jpt2c6Qa5jf8FNxqrbu5FfFs=";
    };
    name = "aw-watcher-vscode";
    publisher = "activitywatch";
  };
  ballerina = {
    pname = "ballerina";
    version = "4.2.0";
    src = fetchurl {
      url = "https://WSO2.gallery.vsassets.io/_apis/public/gallery/publisher/WSO2/extension/ballerina/4.2.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "ballerina-4.2.0.zip";
      sha256 = "sha256-xvdDMfw/GLXEy8rWQiCtlncLpHq2F1tGMHD7+iVzNfM=";
    };
    name = "ballerina";
    publisher = "WSO2";
  };
  copilot = {
    pname = "copilot";
    version = "1.85.75";
    src = fetchurl {
      url = "https://GitHub.gallery.vsassets.io/_apis/public/gallery/publisher/GitHub/extension/copilot/1.85.75/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "copilot-1.85.75.zip";
      sha256 = "sha256-HZuT40Y09Ii1CUfR1BZPp88nV12Xgh2ULnx5/98/CgM=";
    };
    name = "copilot";
    publisher = "GitHub";
  };
  crystal-lang = {
    pname = "crystal-lang";
    version = "0.8.4";
    src = fetchurl {
      url = "https://crystal-lang-tools.gallery.vsassets.io/_apis/public/gallery/publisher/crystal-lang-tools/extension/crystal-lang/0.8.4/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "crystal-lang-0.8.4.zip";
      sha256 = "sha256-hU6g4CqcCxXlhqSKL36vgzX2EJ7fIdbIuPCHbpRW/zE=";
    };
    name = "crystal-lang";
    publisher = "crystal-lang-tools";
  };
  crystal-spec-vscode = {
    pname = "crystal-spec-vscode";
    version = "0.1.0";
    src = fetchurl {
      url = "https://matthewmcgarvey.gallery.vsassets.io/_apis/public/gallery/publisher/matthewmcgarvey/extension/crystal-spec-vscode/0.1.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "crystal-spec-vscode-0.1.0.zip";
      sha256 = "sha256-3plr6exbkkaCSEcw766MFFI30NeQp+WNi1aAD4SpTT0=";
    };
    name = "crystal-spec-vscode";
    publisher = "matthewmcgarvey";
  };
  cucumberautocomplete = {
    pname = "cucumberautocomplete";
    version = "2.15.2";
    src = fetchurl {
      url = "https://alexkrechik.gallery.vsassets.io/_apis/public/gallery/publisher/alexkrechik/extension/cucumberautocomplete/2.15.2/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "cucumberautocomplete-2.15.2.zip";
      sha256 = "sha256-MdBJ71fIkIVOhLCoF/6/CATmUvutiTJPrIoVeb/eXc0=";
    };
    name = "cucumberautocomplete";
    publisher = "alexkrechik";
  };
  emacs-mcx = {
    pname = "emacs-mcx";
    version = "0.47.0";
    src = fetchurl {
      url = "https://tuttieee.gallery.vsassets.io/_apis/public/gallery/publisher/tuttieee/extension/emacs-mcx/0.47.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "emacs-mcx-0.47.0.zip";
      sha256 = "sha256-dGty5+1+JEtJgl/DiyqEB/wuf3K8tCj1qWKua6ongIs=";
    };
    name = "emacs-mcx";
    publisher = "tuttieee";
  };
  even-better-toml = {
    pname = "even-better-toml";
    version = "0.19.0";
    src = fetchurl {
      url = "https://tamasfe.gallery.vsassets.io/_apis/public/gallery/publisher/tamasfe/extension/even-better-toml/0.19.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "even-better-toml-0.19.0.zip";
      sha256 = "sha256-MqSQarNThbEf1wHDTf1yA46JMhWJN46b08c7tV6+1nU=";
    };
    name = "even-better-toml";
    publisher = "tamasfe";
  };
  gherkintablealign = {
    pname = "gherkintablealign";
    version = "1.0.2";
    src = fetchurl {
      url = "https://AlanCole.gallery.vsassets.io/_apis/public/gallery/publisher/AlanCole/extension/gherkintablealign/1.0.2/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "gherkintablealign-1.0.2.zip";
      sha256 = "sha256-AhCm/GyleEOW9NlzE9uSJKIjM8RKQBjSM+RS1j3jiRM=";
    };
    name = "gherkintablealign";
    publisher = "AlanCole";
  };
  haml = {
    pname = "haml";
    version = "1.0.1";
    src = fetchurl {
      url = "https://vayan.gallery.vsassets.io/_apis/public/gallery/publisher/vayan/extension/haml/1.0.1/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "haml-1.0.1.zip";
      sha256 = "sha256-KTsKUfo7bfwqVMSAjRYuPuk+K5Qk+jBlHBlHWTunCdI=";
    };
    name = "haml";
    publisher = "vayan";
  };
  indent-rainbow = {
    pname = "indent-rainbow";
    version = "8.3.1";
    src = fetchurl {
      url = "https://oderwat.gallery.vsassets.io/_apis/public/gallery/publisher/oderwat/extension/indent-rainbow/8.3.1/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "indent-rainbow-8.3.1.zip";
      sha256 = "sha256-dOicya0B2sriTcDSdCyhtp0Mcx5b6TUaFKVb0YU3jUc=";
    };
    name = "indent-rainbow";
    publisher = "oderwat";
  };
  julia-color-themes = {
    pname = "julia-color-themes";
    version = "0.1.1";
    src = fetchurl {
      url = "https://cameronbieganek.gallery.vsassets.io/_apis/public/gallery/publisher/cameronbieganek/extension/julia-color-themes/0.1.1/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "julia-color-themes-0.1.1.zip";
      sha256 = "sha256-22TA7RpC0W3G8uA4EIqeuB4gqDF9cr1gNS+u7qQ3IaA=";
    };
    name = "julia-color-themes";
    publisher = "cameronbieganek";
  };
  language-julia = {
    pname = "language-julia";
    version = "1.45.1";
    src = fetchurl {
      url = "https://julialang.gallery.vsassets.io/_apis/public/gallery/publisher/julialang/extension/language-julia/1.45.1/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "language-julia-1.45.1.zip";
      sha256 = "sha256-PC+f3mEaiHMYvS5nUmB8e4596Cx2PCBfxKbrE8tFLa4=";
    };
    name = "language-julia";
    publisher = "julialang";
  };
  markdown-preview-enhanced = {
    pname = "markdown-preview-enhanced";
    version = "0.6.8";
    src = fetchurl {
      url = "https://shd101wyy.gallery.vsassets.io/_apis/public/gallery/publisher/shd101wyy/extension/markdown-preview-enhanced/0.6.8/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "markdown-preview-enhanced-0.6.8.zip";
      sha256 = "sha256-9NRaHgtyiZJ0ic6h1B01MWzYhDABAl3Jm2IUPogYWr0=";
    };
    name = "markdown-preview-enhanced";
    publisher = "shd101wyy";
  };
  multi-cursor-case-preserve = {
    pname = "multi-cursor-case-preserve";
    version = "1.0.5";
    src = fetchurl {
      url = "https://Cardinal90.gallery.vsassets.io/_apis/public/gallery/publisher/Cardinal90/extension/multi-cursor-case-preserve/1.0.5/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "multi-cursor-case-preserve-1.0.5.zip";
      sha256 = "sha256-eJafjYDydD8DW83VLH9MPFeDENXBx3el7XvjZqu88Jw=";
    };
    name = "multi-cursor-case-preserve";
    publisher = "Cardinal90";
  };
  nickel-syntax = {
    pname = "nickel-syntax";
    version = "0.0.2";
    src = fetchurl {
      url = "https://kubukoz.gallery.vsassets.io/_apis/public/gallery/publisher/kubukoz/extension/nickel-syntax/0.0.2/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "nickel-syntax-0.0.2.zip";
      sha256 = "sha256-ffPZd717Y2OF4d9MWE6zKwcsGWS90ZJvhWkqP831tVM=";
    };
    name = "nickel-syntax";
    publisher = "kubukoz";
  };
  nix-extension-pack = {
    pname = "nix-extension-pack";
    version = "3.0.0";
    src = fetchurl {
      url = "https://pinage404.gallery.vsassets.io/_apis/public/gallery/publisher/pinage404/extension/nix-extension-pack/3.0.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "nix-extension-pack-3.0.0.zip";
      sha256 = "sha256-cWXd6AlyxBroZF+cXZzzWZbYPDuOqwCZIK67cEP5sNk=";
    };
    name = "nix-extension-pack";
    publisher = "pinage404";
  };
  nix-ide = {
    pname = "nix-ide";
    version = "0.2.1";
    src = fetchurl {
      url = "https://jnoortheen.gallery.vsassets.io/_apis/public/gallery/publisher/jnoortheen/extension/nix-ide/0.2.1/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "nix-ide-0.2.1.zip";
      sha256 = "sha256-yC4ybThMFA2ncGhp8BYD7IrwYiDU3226hewsRvJYKy4=";
    };
    name = "nix-ide";
    publisher = "jnoortheen";
  };
  pdf = {
    pname = "pdf";
    version = "1.2.2";
    src = fetchurl {
      url = "https://tomoki1207.gallery.vsassets.io/_apis/public/gallery/publisher/tomoki1207/extension/pdf/1.2.2/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "pdf-1.2.2.zip";
      sha256 = "sha256-i3Rlizbw4RtPkiEsodRJEB3AUzoqI95ohyqZ0ksROps=";
    };
    name = "pdf";
    publisher = "tomoki1207";
  };
  rails-snippets = {
    pname = "rails-snippets";
    version = "1.0.8";
    src = fetchurl {
      url = "https://hridoy.gallery.vsassets.io/_apis/public/gallery/publisher/hridoy/extension/rails-snippets/1.0.8/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "rails-snippets-1.0.8.zip";
      sha256 = "sha256-OSh/BhBxs4Vx5s8tTRlEIlk9sXRvpjLqZ6BqjGLgemA=";
    };
    name = "rails-snippets";
    publisher = "hridoy";
  };
  readable-indent = {
    pname = "readable-indent";
    version = "1.2.2";
    src = fetchurl {
      url = "https://cnojima.gallery.vsassets.io/_apis/public/gallery/publisher/cnojima/extension/readable-indent/1.2.2/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "readable-indent-1.2.2.zip";
      sha256 = "sha256-iTgbxasaNTIBlLLUPs00Y9x099zfXc6ES6drTc8CE78=";
    };
    name = "readable-indent";
    publisher = "cnojima";
  };
  remote-ssh-edit = {
    pname = "remote-ssh-edit";
    version = "0.84.0";
    src = fetchurl {
      url = "https://ms-vscode-remote.gallery.vsassets.io/_apis/public/gallery/publisher/ms-vscode-remote/extension/remote-ssh-edit/0.84.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "remote-ssh-edit-0.84.0.zip";
      sha256 = "sha256-33jHWC8K0TWJG54m6FqnYEotKqNxkcd/D14TFz6dgmc=";
    };
    name = "remote-ssh-edit";
    publisher = "ms-vscode-remote";
  };
  ruby = {
    pname = "ruby";
    version = "0.1.0";
    src = fetchurl {
      url = "https://groksrc.gallery.vsassets.io/_apis/public/gallery/publisher/groksrc/extension/ruby/0.1.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "ruby-0.1.0.zip";
      sha256 = "sha256-JrkzYKjRf1bExSrZOQxek9TS+K14jcJYxjNCEqqHcdk=";
    };
    name = "ruby";
    publisher = "groksrc";
  };
  ruby-linter = {
    pname = "ruby-linter";
    version = "1.0.0";
    src = fetchurl {
      url = "https://hoovercj.gallery.vsassets.io/_apis/public/gallery/publisher/hoovercj/extension/ruby-linter/1.0.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "ruby-linter-1.0.0.zip";
      sha256 = "sha256-DqykFLOQgv10xw/Q2ZtyW1ATOhI61+IY/6lrc9/ln3w=";
    };
    name = "ruby-linter";
    publisher = "hoovercj";
  };
  ruby-rubocop = {
    pname = "ruby-rubocop";
    version = "0.8.6";
    src = fetchurl {
      url = "https://misogi.gallery.vsassets.io/_apis/public/gallery/publisher/misogi/extension/ruby-rubocop/0.8.6/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "ruby-rubocop-0.8.6.zip";
      sha256 = "sha256-6hgJzOerGCCXcpADnISa7ewQnRWLAn6k6K4kLJR09UI=";
    };
    name = "ruby-rubocop";
    publisher = "misogi";
  };
  ruby-symbols = {
    pname = "ruby-symbols";
    version = "0.1.8";
    src = fetchurl {
      url = "https://miguel-savignano.gallery.vsassets.io/_apis/public/gallery/publisher/miguel-savignano/extension/ruby-symbols/0.1.8/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "ruby-symbols-0.1.8.zip";
      sha256 = "sha256-3IsqJ46IG0O2g7hKBt0OgQwruaGu9TuA3XpjAjAk550=";
    };
    name = "ruby-symbols";
    publisher = "miguel-savignano";
  };
  simple-ruby-erb = {
    pname = "simple-ruby-erb";
    version = "0.2.1";
    src = fetchurl {
      url = "https://vortizhe.gallery.vsassets.io/_apis/public/gallery/publisher/vortizhe/extension/simple-ruby-erb/0.2.1/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "simple-ruby-erb-0.2.1.zip";
      sha256 = "sha256-JZov46QWUHIewu4FZtlQL/wRV6rHpu6Kd9yuWdCL77w=";
    };
    name = "simple-ruby-erb";
    publisher = "vortizhe";
  };
  solargraph = {
    pname = "solargraph";
    version = "0.24.0";
    src = fetchurl {
      url = "https://castwide.gallery.vsassets.io/_apis/public/gallery/publisher/castwide/extension/solargraph/0.24.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "solargraph-0.24.0.zip";
      sha256 = "sha256-7mMzN+OdJ5R9CVaBJMzW218wMG5ETvNrUTST9/kjjV0=";
    };
    name = "solargraph";
    publisher = "castwide";
  };
  tabnine-vscode = {
    pname = "tabnine-vscode";
    version = "3.6.46";
    src = fetchurl {
      url = "https://TabNine.gallery.vsassets.io/_apis/public/gallery/publisher/TabNine/extension/tabnine-vscode/3.6.46/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "tabnine-vscode-3.6.46.zip";
      sha256 = "sha256-dr1CiadwFr5iF//rtKij4w6hCcndrNVSfoeA6nGulWU=";
    };
    name = "tabnine-vscode";
    publisher = "TabNine";
  };
  tokyo-night = {
    pname = "tokyo-night";
    version = "0.9.9";
    src = fetchurl {
      url = "https://enkia.gallery.vsassets.io/_apis/public/gallery/publisher/enkia/extension/tokyo-night/0.9.9/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "tokyo-night-0.9.9.zip";
      sha256 = "sha256-Vcb8w3eQrEs5X+Kbb9XmKF5yJAwgTUhaucfjCDhJnss=";
    };
    name = "tokyo-night";
    publisher = "enkia";
  };
  vscode-direnv = {
    pname = "vscode-direnv";
    version = "1.0.0";
    src = fetchurl {
      url = "https://cab404.gallery.vsassets.io/_apis/public/gallery/publisher/cab404/extension/vscode-direnv/1.0.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "vscode-direnv-1.0.0.zip";
      sha256 = "sha256-+nLH+T9v6TQCqKZw6HPN/ZevQ65FVm2SAo2V9RecM3Y=";
    };
    name = "vscode-direnv";
    publisher = "cab404";
  };
  vscode-docker = {
    pname = "vscode-docker";
    version = "1.25.0";
    src = fetchurl {
      url = "https://ms-azuretools.gallery.vsassets.io/_apis/public/gallery/publisher/ms-azuretools/extension/vscode-docker/1.25.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "vscode-docker-1.25.0.zip";
      sha256 = "sha256-c6Ev1nZUBrOhM+NAw5YUfBWoLyj2RPzhpGEPMYQ7LsI=";
    };
    name = "vscode-docker";
    publisher = "ms-azuretools";
  };
  vscode-emacs-friendly = {
    pname = "vscode-emacs-friendly";
    version = "0.9.0";
    src = fetchurl {
      url = "https://lfs.gallery.vsassets.io/_apis/public/gallery/publisher/lfs/extension/vscode-emacs-friendly/0.9.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "vscode-emacs-friendly-0.9.0.zip";
      sha256 = "sha256-YWu2a5hz0qGZvgR95DbzUw6PUvz17i1o4+eAUM/xjMg=";
    };
    name = "vscode-emacs-friendly";
    publisher = "lfs";
  };
  vscode-emacs-tab = {
    pname = "vscode-emacs-tab";
    version = "0.1.0";
    src = fetchurl {
      url = "https://garaemon.gallery.vsassets.io/_apis/public/gallery/publisher/garaemon/extension/vscode-emacs-tab/0.1.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "vscode-emacs-tab-0.1.0.zip";
      sha256 = "sha256-XXBJXgbWVdoiWYnsJ2CjgNDycKPWe5XMYjVkU4QxCQA=";
    };
    name = "vscode-emacs-tab";
    publisher = "garaemon";
  };
  vscode-markdownlint = {
    pname = "vscode-markdownlint";
    version = "0.49.0";
    src = fetchurl {
      url = "https://DavidAnson.gallery.vsassets.io/_apis/public/gallery/publisher/DavidAnson/extension/vscode-markdownlint/0.49.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "vscode-markdownlint-0.49.0.zip";
      sha256 = "sha256-Mh/OoRK410aXEr3sK2CYFDsXGSqFT+JOWi9jHOdK01Y=";
    };
    name = "vscode-markdownlint";
    publisher = "DavidAnson";
  };
  vscode-ruby = {
    pname = "vscode-ruby";
    version = "0.28.0";
    src = fetchurl {
      url = "https://wingrunr21.gallery.vsassets.io/_apis/public/gallery/publisher/wingrunr21/extension/vscode-ruby/0.28.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "vscode-ruby-0.28.0.zip";
      sha256 = "sha256-H3f1+c31x+lgCzhgTb0uLg9Bdn3pZyJGPPwfpCYrS70=";
    };
    name = "vscode-ruby";
    publisher = "wingrunr21";
  };
  zeek = {
    pname = "zeek";
    version = "0.6.0";
    src = fetchurl {
      url = "https://aeppert.gallery.vsassets.io/_apis/public/gallery/publisher/aeppert/extension/bro/0.6.0/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
      name = "bro-0.6.0.zip";
      sha256 = "sha256-+wISGCtGq/l058dOaAKlD3pGknP2ksekS1Rgmax5QgU=";
    };
    name = "bro";
    publisher = "aeppert";
  };
}
