# Employee Management


A Ruby on Rails application for managing employees, built with Rails 8.1 and PostgreSQL.

## Requirements
- Ruby 3.2.2
- PostgreSQL 9.5+


## 1. Install dependencies

### Install Ruby


	brew install rbenv ruby-build                                                           
	rbenv install 3.2.2                                                                     
	rbenv global 3.2.2                                                                      


### Install Rails
 
	gem install rails                                                                      
   

### Install Postgres

	brew install postgresql@16
	brew services start postgresql@16



## 2. Run Application

### 1. Install gems
	cd employee_management
	bundle install


###	2. Start database
	rails db:create
	rails db:migrate

### 3. Start the server
	rails server
