#!/usr/bin/env bash
for name in `cat ~/.tool-versions | awk  -F' ' '{print $1}'` ; do
  echo "asdf plugin add $name"
  asdf plugin add $name
done

bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'

asdf install

