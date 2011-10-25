#Performa
## Office management of performance
  Our new rails project, with **BDD, Steak, PaperTrail, Remotipart**
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
   
