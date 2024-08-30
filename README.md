# Project: Micro-Reddit
A project for the Odin Project Rails Course

### Get started

1. Just like in the warmup, plan out what data models you would need to allow users to be on the site (don’t worry about login/logout or securing the passwords right now), to submit links (“posts”), and to comment on links. Users do NOT need to be able to comment on comments… each comment refers to a Post.
2. Generate a new rails app from the command line ($ rails new micro-reddit) and open it up. We’ll use the default SQLite3 database so you shouldn’t have to change anything on that front.
3. Generate your User model and fill out the migration to get the columns you want.
4. Run the migration with $ rails db:migrate. You can use $ rails db:rollback if you realize you forgot anything or just create a new migration for the correction (which might involve the #add_column #remove_column or #change_column commands). See the Rails API Documentation for details on syntax and available methods.

### Playing with validations

1. In a new tab, open up the $ rails console (you may use rails c for short). Try asking for all the users with > User.all. You should get back an empty array (no users yet!). Now create a blank new user and store it to a variable with > u = User.new. This user has been created in the ether of Ruby’s memory but hasn’t been saved to the database yet. Remember, if you’d used the #create method instead of the #new method, it would have just gone ahead and tried to save the new user right off the bat. Instead, we now get to play with it.
2. Check whether your new user is actually valid (e.g. will it save if we tried?). > u.valid? will run all the validations. It comes up true… surprise! We haven’t written any validations so that’s to be expected. It’s also a problem because we don’t want to have users running around with blank usernames.
3. Implement the user validations you thought of in the first step in your app/models/user.rb file. These might involve constraints on the size of the username and that it must be present (otherwise you’ll potentially have users with no usernames!) and that it must be unique.
4. Reload your console using > reload!. You’ll need to do this every time you make changes to your app so the console can reload the current version. If it still seems broken, just > quit out of it and relaunch (sometimes #reload! doesn’t seem to do the trick). Build another new user but don’t save it yet by using > u2 = User.new. Run > u2.valid? again to run the validations and it should come up false. Good.
5. How do we find out what went wrong? Rails is helpful because it actually attaches error messages directly onto your user object when you fail validations so you can read into them with the #errors method. Try out > u2.errors to see the errors or, better, > u2.errors.full_messages to return a nice friendly array of messages. If you wrote custom messages into your validations, they will show up here as well.
6. Create a user who will actually save with > u3 = User.new(your_attributes_here) and run the validations. They should come up true. Save your user with the #save method so you’ve got your first user in the database.

### Playing with associations

1. Create your Post model by referencing your data plan from the first step above, migrate the database, and add its validations.
2. Test your validations from the console, remembering to reload or relaunch it between changes.
3. Now set up your associations between User and Post models. Did you remember to include the foreign key column (user_id) in your posts table? If not, you can just add a new migration ($ rails generate migration yourmigrationname) and use the #add_column method mentioned above.
4. If you’ve properly set up your associations, you should be able to use a few more methods in the console, including finding a User’s Posts and finding the Post’s User. First test finding your lone User’s Posts – > User.first.posts. It should be an empty array since you haven’t created posts, but it shouldn’t throw an error at you.
5. Build (but don’t yet save) a new post from the console, called p1, something like > p1 = Post.new(your_attributes_here). Don’t forget to include the ID of the user in your user_id field!
6. Now build another post using the association to the user – substitute #new with #build and run through the association instead – p2 = User.first.posts.build. Don’t fill in any fields yet. Examine the object that was created and you’ll see that the ID field already got filled out for you, cool! This is a neat trick you’ll learn about in the lesson on associations.
7. Save your original new post p1 so your user has officially written something. Test that you can use the other side of the association by trying > Post.first.user, which should return the original User object whose ID you pointed to when building the post. All has come full circle!

### Add in commenting

1. You’ve now got a User and a Post and they’ve been linked. Commenting will look quite similar to your Post model but will be related not just to the post who is its “parent” but also to the user who has authored it. Set up the migration and migrate the database for your Comment model.
2. As before, add validations into your model and test them out in the console (refresh it!). Make sure you’ve required the two foreign keys (for posts and users) to be submitted, otherwise you could potentially have an orphan comment. You should not be able to save an invalid Comment and be able to save a valid Comment.
3. Build a second user and create a new comment which represents this user commenting on the first user’s post.
4. As before, add the associations you need between users, posts, and comments. You’ll need to be able to do the following methods successfully from the console (assuming your second user has an ID of 2):
- > u2 = User.find(2)
- > c1 = u2.comments.first should return that user’s comment. #comments returns an array with comments, which is why we need to use #first to actually retrieve the comment itself.
- > c1.user should return that comment’s author User (u2).
- > p1 = Post.first
- > p1.comments.first should return the comment c1.
- > c1.post should return the post p1.

If any of those don’t work, double check your associations. Sometimes the error messages can be helpful in prompting you for how to set up those associations.