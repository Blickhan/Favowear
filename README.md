# Test app README

_______________________Starting up___________________________

// Download rails package from railsinstaller.org

$ gem install rails

$ mkdir workspace

$ cd workspace

$ rails new <app_name>

$ cd <app_name>

$ git config --global user.name "Your Name"

$ git config --global user.email your.email@example.com

$ git config --global push.default matching

$ git config --global alias.co checkout

$ git init

$ git add -A

$ git commit -m "initial commit"

// sign up for a Bitbucket.org account

// copy machine's public key ($ cat ~/.ssh/id_rsa.pub)

// add public key to Bitbucket by Managing Account and then going to SSH keys

// create a new repository on Bitbucket

$ git remote add origin git@bitbucket.org:<username>/<repo_name>.git 

$ git push -u origin --all # pushes up the repo and its refs for the first time
