#!/bin/bash

# DB Migrations and Model Generation
rails g resource user email:string password_digest:string  --force
rails g model content description:text title:string user:references  image_src:string --force

rails g migration addAncestryToContent ancestry:string:index --force
rails g uploader attachment --force
rails g model image content:references attachment:string --force
rm -rf public/uploads
mkdir public/uploads


# Controller + Misc Generation
rails g controller contents --force
rails g controller sessions --force

# DB Migration and Seeding
rake db:drop
rake db:migrate
