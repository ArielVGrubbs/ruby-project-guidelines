# Phase One Final Project - Ariel Grubbs and Hugo Delgado

## Project Requirements (i.e. what we set out ot do)

### Command Line CRUD App

1. Access a Sqlite3 Database using ActiveRecord.
2. You should have a minimum of three models.
3. You should build out a CLI to give your user full CRUD ability for at least one of your resources. For example, build out a command line To-Do list. A user should be able to create a new to-do, see all todos, update a todo item, and delete a todo. Todos can be grouped into categories, so that a to-do has many categories and categories have many to-dos.
4. Use good OO design patterns. You should have separate classes for your models and CLI interface.

### Brainstorming and Proposing a Project Idea

We started off by brainstorming about what we wanted our project to be, what we would like to model off of real world applicaitons and what we'd like ot add that we've not seen before. We settled on creating an online ordering system for an ice cream store when Hugo told me a story about how he went to a cute frozen yogurt place, but although he enjoyed the trip, he wished they had an app for ordering ice cream to be delivered to his house. And just like that we had an idea about what to do, and the kind of features we wanted it to have.

* A user should be able to order more than one ice cream cone per order
* A user should be able to gain rewards for repeated patronage of this restaurant
* A user should be able to choose when they'd like their ice cream to be delivered
* A user should be able to see who their delivery person is and learn a little bit about them

## Code

Now I'm going to start talking the nitty gritty details of the code, don't say I didn't warn you.

I'll mainly focus this discussion on the CLI (Command Line Interface), since that was the main focus of this project.

Our CLI is all contianed within one class that we wrote in the bin/run.rb file, and all you need to do to start going through the path of the user is run that file. We started off with a very basic, very linear, path that used the responses the user typed to move through a sequence of complicated If statements that allowed the user to pick one of our ice cream options, and if the user misspelled the whole thing would break and the code would kick the user out prematurely.

Then we moved on to adding features to enrich the users experience, we created two more columns in the users table in our database with a migration, and set up a prompt for the user to input their address and method of payment, but we still weren't using that data in any way, and though we didn't realize it immediately, we weren't even saving that data to the database. Later on we added a bit of text to what the receipt method printed at the end of the user path, showing that the system had saved the users address and that was where it would send the delivery person.

Then we thought, it might be nice to be able ot choose a delivery person, rather than just having one randomly assigned so we set up a method that allowed the user to, if they wanted to, diverge from the main path for a time and check out some interesting information about our delivery people and let them select one of them to deliver their ice cream. Adding in this bit of functionality allowed our program to have more of a branching structure, and made it less linear and hopefully makes the user feel like they're driving the process without allowing them to break out of the safe code path.

We of course swung back around to working on our main path, giving the customer a little more information in the list of ice creams, and allowing them to add multiple cones ot a single order by writing an if statement that only called the ordering method again if the user wanted to add more ice cream to their order.

Adding the rewards system was fairly easy, and all we had to do was set up a method that read the number of orders made by that user instance, and if that number was larger than a predefined threshold they would get a discount on their next order, shown to them by a bit of text in the receipt before they get the discount, and also being deducted from the sum in their next order. For the sake of easily presenting this feature we set the threshold of number of orders the user needs to make fairly low, but in a real world environment I imagine it would be more like 15-20 previous orders gets you a free one, rather than our somewhat generous, three order gets you ten percent off on the fourth. In adding this feature we also needed to clean up some of our code to better adhere to best practices, as before we implemented this, our total for the order was calculated inside the receipt method, which is generally not a good idea because you don't want a method or function to be doing more than one clearly delineated task.

## Reflections

This was an amazing and exciting project, working together to create a CLI for the first time was a very rewarding learning experience. The open ended nature of this assignment gave us the freedom to do anything while simultaneously giving us the responsibility of building our own funcional coding environment from scratch, and that forced both of us to grow as coders. We're very thankful to have been given this opportunity, and know that we've grown to meet this challenge. But none of this would have been possible without the great community of Flatiron, the members of our cohort and our instructors were always there to help us if we hit a block, or needed a fresh set of eyes on the project and we can't thank them enough for all their help.