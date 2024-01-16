#!/bin/bash

cd "$HOME/Repositories/Shipwright" ||
    { echo "Shipwright repository not available" ; exit 1;};

git fetch upstream;

# git stash push ||
#     { echo "Stash Failed." ; exit 1;};

git merge upstream/develop --no-edit ||
    { git merge --abort ; echo "Merge Failed, Aborting." ; exit 1;}

# git stash pop ||
#     { echo "Stash Pop Failed. Probably Conflicts" ; exit 1;};

rm -f ./build-cmake/*.otr || 
    { echo "Remove old .otr failed" ; exit 1;};

cmake --build build-cmake --target clean ||
    { echo "Clean Failed." ; exit 1;};

cmake -H. -Bbuild-cmake -GNinja -DCMAKE_BUILD_TYPE:STRING=Release ||
    { echo "CMake Failed." ; exit 1;};

cmake --build build-cmake --target ExtractAssets ||
    { echo "Extract Assets Failed." ; exit 1;};

cmake --build build-cmake --config Release ||
    { echo "Build Failed." ; exit 1;};

./scripts/linux/appimage/build.sh ||
    { echo "AppImage Build Failed." ; exit 1;};

rm -rf ./_packages;

cp ./build-cmake/*.appimage $HOME/Games/ShipOfHarkinian/soh.appimage ||
    { echo "AppImage Copy Failed." ; exit 1;};

rm "$HOME/Games/ShipOfHarkinian/*.otr" ||
    { echo "Remove old .otr failed" ;};

echo "Job Done!";
