#Performa
## Office management of performance
  Our new rails project, with **BDD with RSpec, Capybara, Steak, FactoryGirl. Other libraries are PaperTrail, Remotipart and Devise**
	[vidriloco](https://github.com/vidriloco) in charge.

### Installation
Follow the usual *deployment* process amongst all rails applications (in Production using Heroku):

0. heroku run bundle install / bundle update
1. heroku run rake db:migrate 
2. heroku run rake db:seed

Similarly for *development* 

1. rake db:migrate RAILS_ENV=development
2. rake db:seed RAILS_ENV=development

For *testing* and before committing changes to remote repository and heroku slice. It is IMPORTANT to make sure we are not uploading an application version not having all it's tests green.

It is suggested to use spork for launching a testing server which loads the rails environment for making specs to execute faster.

1. spork
2. rspec spec/
3. watch tests pass or fail and then repair/implement existent/new features


###Domain management

This application handle subdomains, You  could  see this article  to configure  your local  enviroment:
http://railscasts.com/episodes/221-subdomains-in-rails-3?view=asciicast

Use  lvh.me:port   instead of  localhost:port in order  to  have  subdomains  like  company.lvh.me  running 



### About the modularity of certain components of the application

#### Contextual Legends

The *contextual legends* is a component which displays a block of information which can be modified. This block of information is associated always with the current URL. There are some "static" contextual legend definitions loaded from seeds.rb
Specs for this component cover it's complete behavior, however there are some issues which need to be resolved to have a more powerful component which handles the scenarios depicted on issues numbered [8,7]. 

#### Comments

The *comments component* handles the application comments for all the models which require that component, however more sound specs are needed to cover the independent (respect any model) correctness behavior of this component. It is suggested to do something similar to what has been done with the *contextual legends* component. The issue related has number 4. 

#### Notifications

Although not yet implement, it is suggested to follow the principle of modularization in views, specs and controllers implemented by the previous two components, such that integrating this feature (notification) with other models view is as easy as placing a partial in the correct html.erb file. 

### About version controlling

By a suggestion from [Omar](https://github.com/ovargas27) we started using git-flow, thus we have several branches each one representing a functionality or block of functionalities such as design, or development. In the master branch we manage the production ready version of the application. 

#### About planning and modeling of the application 

In the *planning* directory within the application directory there is an updated diagram of all the models of the application
and it's relations. It is editable with Omnigraffle.
   
## RSpec and friends

### What to spec

In this project we have been focusing on acceptance testing *(specs/acceptance)*, unit testing *(specs/models)* and integration testing *(specs/controllers)*. While implementing those three groups of tests we are sometimes testing the functionality given by some helpers for code refactoring in the views mainly and also testing routes work correctly. The latter are found at *(specs/helpers)* and at *(specs/routing)* respectively.

In directory *(specs/factories)* are defined all the fixtures for mocking model's instances. We are using FactoryGirl for that.

### How to spec

See [this](http://www.slideshare.net/drmanitoba/behaviour-driven-development-with-cucumber-rspec-and-shoulda) slide for an overview on BDD and the red-green-refactor cycle. Here it is explained how to do it right. 

### Some of the tools

For acceptance testing we are using Steak (see [here](https://github.com/cavalle/steak)) together with Selenium through Capybara (see [here](https://github.com/jnicklas/capybara)) for simulating a user interaction with controls within a webpage, which also allows to interact with the javascript on it.

### The Reasons for choosing Steak instead of Cucumber as a DSL for acceptance testing

We decided to go for Steak as a DSL (Domain Specific Language) for acceptance testing due it's simplicity. Whilst Cucumber is more focused on describing specs that are easy to understand for a client with no computer programming language understanding; Steak is just focused on describing quick and concrete specs which promote faster spec'ing without useless paraphernalia. 

It the case of this project using Cucumber provides no extra value, as we are not having meetings with clients where they tell us the features on the application explicitly, instead we are being guided by a set of mocks previously agreed upon.

For more information about **Steak** see [here](http://jeffkreeftmeijer.com/2010/steak-because-cucumber-is-for-vegetarians/)

### Remote Dot and Graphviz

We use the follow implementation  : 
https://github.com/jstepien/remote_dot
