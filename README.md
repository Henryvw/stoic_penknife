<img align="right" src="https://github.com/Henryvw/stoic_penknife/blob/master/app/assets/images/stoic_penknife_logo_new_clay.png" alt="Stoic Penknife" width="200" />

# Stoic Penknife [![BUILD_STATUS][]][CIRCLE_CI] [![TEST_COVERAGE][]][CODE_COV]

[BUILD_STATUS]: https://circleci.com/gh/Henryvw/stoic_penknife/tree/master.svg?style=svg
[CIRCLE_CI]: https://circleci.com/gh/Henryvw/stoic_penknife/tree/master
[TEST_COVERAGE]: https://codecov.io/gh/Henryvw/stoic_penknife/branch/master/graph/badge.svg?style=svg
[CODE_COV]: https://codecov.io/gh/Henryvw/stoic_penknife

## What is Stoic Penknife?
Stoic Penknife (https://www.stoicpenknife.com) is a web application to practice **ancient Stoic philosophical 'think-exercises'** to question your perceptions about yourself and your life. **Marcus Aurelius**, **Seneca**, **Epictetus** and other ancient Greek + Roman philosophers once practiced these exercises on paper - now you can do it with an app! Amazing.

# For Philosophers
## How Can I Use the App?
To practice ancient Stoic philosophical 'think-exercises' and to create your own custom 'think-exercises', visit the production instance at https://www.stoicpenknife.com.

[![ReadMe Screenshot](https://github.com/Henryvw/stoic_penknife/blob/master/app/assets/images/readme_screenshot.png)](https://www.stoicpenknife.com)

## How Can I Contribute?
We would love to hear about your experiences using the application and in particular the 'think-exercises.' Are there 'think-exercises' that you find particularly helpful or meaningful?

Are there any problems that you encountered? You can open an Issue or write to me, Henry, at `henry@stoicpenknife.com`.

# For Programmers
## How Can I Contribute?
Stoic Penknife is an open source project. If you are interested in contributing, feel free to create an issue or a task in the Project tab: We have a [list of tasks in the Project tab](https://github.com/Henryvw/stoic_penknife/projects/1). Alternatively or in addition, feel free to write to me, Henry, at `henry@stoicpenknife.com`. We would also love to hear about additional improvement ideas. You are also free to fork the project and to make your own version (perhaps an Epicurean, Platonic-Academic, Aristotlean-Peripatetic, Pyrrho-Skeptic, Eclectic, Diogenes-Cynic or Heraklitean version?!)

## How is the Application Organized?
* Rails Active Record Backend
* Bootstrap Views with HAML + JQuery
* 2 Admins - Custom Admin (Managed with CanCanCan Gem) plus an Active Admin

The Custom CanCanCan Admin is for managing exercises, doctrines and quotations. The Active Record Admin is for managing users. In the future I would love to combine them. There is no reason to have two separate Admins.

## Test Coverage
Stoic Penknife uses RSpec's new System Specs to test all key integrated user actions. I also have controller specs for the Exercise controller, the most important controller. All the key models are covered.

I use `CodeCov` to monitor Test Coverage: https://codecov.io/gh/Henryvw/stoic_penknife

The exception to Stoic Penknife's test coverage (the reason it is not 100% covered) is the Active Admin backend. This Admin is not relevant to the user experience and I have not written tests for it. Again, should I combine the two Admins into one, I would start by writing a new 'Admin' test suite.

## Hosting + Deployment
I use CircleCI to run the `Rubocop` linter and the full test suite, push to CodeCov and and manage deployment to the production Heroku instance: https://github.com/Henryvw/stoic_penknife/blob/master/.circleci/config.yml

## Play with the App Locally / Have a Dev Environment
If you want to play around, simply download the app and make sure you have Rails 7.0.2 and Ruby 3.1.1 installed and spin her up - `bin/dev`.

I still have not written a `seed` file for the database. You will need to manually create a User with `admin=true` in Rails Console in order to administer global exercises. 

The second, ActiveAdmin back-end you can access at `/admin`. At the present time this also requires a Rails Console-manually-created separate, Active Admin user created using the `AdminUser` model.

### Note about Selenium Web Driver and Chrome RSpec Tests
In order to run the test suite, you will need to install the `chromedriver` utility. On Mac OS X, this is managed by `homebrew`. Every time Chrome releases a new version of itself, for example going from Version 74 to Version 76, on your local machine to run the test suite you will need to update the `chromedriver` utility.

On Mac OS X, `chromedriver` is managed by `homebrew`. You can update it via the command:

`brew cask reinstall chromedriver`

## License
[![Creative Common License](https://licensebuttons.net/l/by-sa/3.0/88x31.png)](https://creativecommons.org/licenses/by-sa/4.0/)

Stoic Penknife is licensed under the **Creative Commons** Attribution-ShareAlike CC BY-SA License. This license lets you remix, tweak, and build upon Stoic Penknife even for commercial purposes, as long as you credit me and license your new creations under the identical terms. Read more at the [Creative Commons page for this license](https://creativecommons.org/licenses/by-sa/4.0/).
