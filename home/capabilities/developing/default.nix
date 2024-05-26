{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    libreoffice
		jmeter

		watchexec

    shellcheck

    python311
    python311Packages.pip
    python311Packages.mypy
    python311Packages.flake8
    python311Packages.black
    python311Packages.virtualenv
    poetry

    rustc
    cargo
    cargo-generate
    cargo-watch
    cargo-audit
		cargo-profiler
    rustfmt
    rust-analyzer
    clippy

    gcc
    gnumake
    cmake
		valgrind
    llvmPackages_9.clang-unwrapped

    dotnet-sdk_8
    dotnetPackages.Nuget

    nodejs_20
    corepack_20
    bun

		jdk
		jetbrains.idea-ultimate

    mysql80
    mongodb-compass
    redis

		wrangler_1
		turso-cli

		go
  ];
}
