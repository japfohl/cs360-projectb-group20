# CS360 ProjectB Group 20 Repo

## Steps for working on a new feature

1. Make sure you're on master: `git checkout master`
2. Pull down any changes that might have occured since you last pulled: `git pull origin master` (*Don't do this anywhere but master!*)
3. Create a new feature branch: `git checkout -b name-of-feature-branch`
4. Do work on your feature branch.
5. Add and commit your changes as you work:
    * `git add <filename>` adds a file to the staging area
    * `git add .` adds everything to the staging area
    * `git commit -m "describe the changes in this commit"` (_commits are typically reserved for when you complete a good chunk of a new feature_)
6. Once your feature is complete, push it to its own branch of origin: `git push -u origin HEAD`
7. Log into GitHub and create a pull request.
    * In the pull request, tag 2-3 of the other group members as reviewers.
    * The other members should pull your down to their C9 workspace (`git pull`), and then test to ensure it does what you say it does.
    * Once the code has been reviewed, the other members approve it.
8. Once your code has been approved by the other reviewers, merge the pull request (PR) into master.
9. At that point, you should be good and everyone else should switch to master and perform a `git pull`
    * If you have any merge conflicts, stop and reach out to someone with experience dealing with them.  They take more time to describe than I have here.

## Important Notes

* You should __*NEVER*__ work directly on master or push directly to master.
* If you want to figure out what your code changes and you have un-comitted changes, you can run `git diff`.
* For a cool way to view the log of changes in any git repo, add the following to your .gitconfig:
    * `lg = log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit`

**Most Importantly:** Let's have fun with this project!