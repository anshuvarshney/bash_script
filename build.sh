!#/bin/bash


#List of repositories
repos=("repo1" "repo2" "repo3" "repo4" "repo5" "repo6" "repo7" "repo8" "repo9" "repo10")

for repo in "${repos[@]}"
do
	echo "Building repo in $repo"
	cd "$repo"
	sudo apt update
	npm install -y
	npm run build

	echo "Building pnpm in $repo"
	sudo apt update
	pnpm install -y
	pnpm run build 

	cd ..
done

