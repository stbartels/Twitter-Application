require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task["db:reset"].invoke
    make_users
    make_microposts
    make_relationships
    
  end
  
  def make_users
    admin = User.create!(:name => "Example User",
                 :email => "user@example.com",
                 :password => "password",
                 :password_confirmation => "password"
                 )
    admin.toggle!(:admin)
    300.times do |n|
      name = Faker::Name.name
      email = "user-#{n+1}@example.com"
      password = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
  end
  
  def make_microposts
    User.all(:limit => 6).each do |user|
      50.times do
        user.microposts.create!(:content => Faker::Lorem.sentence(5))
      end
    end
  end
  
  def make_relationships
    users = User.all
    user = users.first
    following = users[1..50]
    followers = users[3..40]
    following.each {|followed| user.follow!(followed)}
    followers.each {|follower| follower.follow!(user)}
  end
end