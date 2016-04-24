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

// install heroku cli at https://toolbelt.heroku.com/

$ heroku version

$ heroku login

$ heroku keys:add // add public ssh key // to generate a key ($ ssh-keygen -t 
rsa)

$ heroku create

$ git push heroku master

// rename to <app_name>.herokuapp.com using ($ heroku rename <app_name>)



$ heroku git:remote -a <heroku app name> //push existing git repo to existing 
heroku app



# For illustration only; don't do this unless you mess up a branch

$ git checkout -b topic-branch

$ <really screw up the branch>

$ git add -A

$ git commit -a -m "Major screw up"

$ git checkout master

$ git branch -D topic-branch