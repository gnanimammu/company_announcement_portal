# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
rails new company_announcement_portal -d mysql
Step 1: Set Up User Model
create a User model with fields for registration and login.

Generate the User model:
rails generate model User username:string email:string password_digest:string mobile_number:integer address:string job_title:string 

 gem 'bcrypt', '~> 3.1.7'
 bundle install

 Run the migration to create the users table:
rails db:migrate

Step 2: Implement User Registration (Sign Up)
create the functionality for users to register.

Create the Registration Controller:
rails generate controller Users

Step 3: Implement User Login
create functionality for users to log in.

Create Sessions Controller for Login:
rails generate controller Sessions

rails generate migration AddPhoneNumberToUsers phone_number:string

create views for users and sessions
under users folder
index.html.erb
new.html.erb
show.html.erb
edit.html.erb
under sessions folder
new.html.erb
destroy.html.erb
Generate the Post model
rails generate model Post content:text user:references image:string
rails db:migrate
Set Up Associations:

A user has many posts, and a post belongs to a user. We'll update the models accordingly.
app/models/user.rb:
has_many :posts, dependent: :destroy
 validates :username, presence: true, uniqueness: true

 app/models/post.rb:

validates :content, presence: true
  validates :user, presence: true

  # For handling image uploads (e.g., with ActiveStorage)
  has_one_attached :image

  Set Up ActiveStorage for Image Uploads: Rails provides ActiveStorage for file uploads, which we will use to handle images attached to posts. To set up ActiveStorage, run the following
  rails active_storage:install
  rails db:migrate

  We need a controller to manage creating, displaying, and editing posts.

  Generate the Posts Controller:
  rails generate controller Posts
  Implement Views for Creating, Viewing, and Editing Posts
  

  app/views/posts/index.html.erb

rails generate migration AddTitleToPosts title:string
rails db:migrate
 Commenting on Posts:
Create the Comment Model

rails g model Comment content:text post:references user:references parent_id:integer
rails db:migrate
Comment Model (app/models/comment.rb):
belongs_to :parent, class_name: 'Comment', optional: true

  has_many :comments, foreign_key: :parent_id

  validates :content, presence: true
  Generate the comments controller:
  rails generate controller Comments

  the parent_id field is used for comment nesting, linking replies to their parent comments.
   Rendering Comments Recursively (Nested Comments)
To display comments and allow nesting up to four levels, create a partial to render the comments and their replies.
we need to create
app/views/comments/_comment.html.erb
app/views/comments/_form.html.erb
This form can be used for both creating top-level comments and replying to existing comments (by passing the parent_id).
Form to create a comment (or reply):
Display Nested Comments (4 Levels)
In the partial _comment.html.erb, we’re rendering replies recursively. To restrict nesting to four levels, you can add a condition in the comment rendering logic to limit the number of nested levels.

For example, you could use the depth of the comment to limit the nesting:
<% if comment.replies.any? && comment.depth < 4 %>
  <div class="replies">
    <%= render comment.replies %>
  </div>
<% end %>
