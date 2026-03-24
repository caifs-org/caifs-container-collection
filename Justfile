set export
set shell := ["/bin/sh", "-c"]

PATH := x"$HOME/.local/bin:$PATH"

[doc('List available recipes')]
help:
    @just --list

[doc('Install the CAIFS framework')]
[script]
install-caifs:
    curl -sL https://raw.githubusercontent.com/caifs-org/caifs/refs/heads/main/install.sh | sh
    ls -l $HOME/.local/bin/

[doc('Install CI runner dependencies (uv, pre-commit, rumdl)')]
[script]
install-caifs-runner-deps:
    caifs add uv pre-commit rumdl --hooks

[doc('Bump version (use --patch, --minor, or --major)')]
[script]
[arg("patch", long="patch", value="patch")]
[arg("minor", long="minor", value="minor")]
[arg("major", long="major", value="major")]
bump-version $patch="" $minor="" $major="" *args:
    bump-my-version bump --verbose $patch $minor $major {{ args }}

[doc('Create release.tar.gz for distribution')]
[script]
create-release-tar:
    tar --exclude-from .tarignore --transform 's,^,caifs-container-collection/,' -czvf release.tar.gz *

[doc('List contents of release tarball')]
[script]
list-release-tar-files:
    tar -ztf release.tar.gz

[doc('Install pre-commit hooks locally')]
[script]
pre-commit-install:
    pre-commit install --install-hooks

[doc('Run pre-commit checks on all files')]
[script]
pre-commit-run:
    pre-commit run --all

[doc('Utility function to do a regex replacement on a string')]
[script]
replace str from to:
    echo {{ replace(str, from, to) }}
