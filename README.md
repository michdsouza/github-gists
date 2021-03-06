# Github Gists Challenge

A Ruby-on-Rails application that allows a user to manage their GitHub gists. The following user stories have been implemented as part of this code challenge:

1. As a github user, I want to be able to list all of my private gists, so that I can see them all
2. As a github user, I want to create a new private gist, so that I can add a new one
3. As a github user, I want to be able to edit one of my private gists, so that I can change the content
4. As a github user, I want to be able to delete one of my private gists, so that I can remove it

## Setup

``` sh
$ git clone https://github.com/michdsouza/github-gists
$ cd github-gists
$ bundle install
```
An example file called secret.yml.example has been provided to add the GitHub client id and secret, to test locally. Change the file name to secret.yml and add the GitHub credentials mentioned above. To generate a Github client id and secret, please refer to the first 3 points in this simple online tutorial: https://richonrails.com/articles/github-authentication-in-ruby-on-rails

``` sh
$ rake db:migrate
$ bin/rails s
```

## Run Tests

Used Rspec for testing

``` sh
$ cd github-gists
$ rspec
```

There are no controller tests and instead have been replaced by request specs, which most of the rails community is heading towards.

## Rubocop

To stay within the guidelines enforced by the community [Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide), Rubocop was used for static code analysis and styling.

## Heroku App

https://cisco-code-challenge-mdsouza.herokuapp.com/gists

## Design Choices

Omniauth was used so that authentication could be handled by Github. This meant that the application did not have to be responsible for storing usernames and passwords, and hence, is more secure.

To keep the MVP implementation simple, the interface does not support creating or editing gists with multiple files.

## CircleCI

For continuous integration

<img width="1355" alt="screen shot 2018-10-26 at 9 34 06 pm" src="https://user-images.githubusercontent.com/879181/47597662-5bcfbd00-d967-11e8-8b35-9ba250e97dbf.png">

