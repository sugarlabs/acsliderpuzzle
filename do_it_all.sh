set -e

git_url="git://git.sugarlabs.org/slider-puzzle-branch/mainline.git"


# Remove the upstream cloned-directory, if any.
if [ -d "activity" ]; then
	sudo rm -r activity
fi

# Clone a fresh copy of the upstream.
git clone "$git_url" activity

# Build the activity (to generate "generated" files such as locale files).
cd activity
python setup.py build

# Now, apply the AC patches.
git am ../patches/*.patch

# Finally, build the bundle (to be retrieved from "activity/dist").
python setup.py dist_xo
