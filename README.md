# PINDD - Post-It Note Driven Development

[![Build Status](https://travis-ci.org/meowmaste/PINDD.png?branch=master)](https://travis-ci.org/meowmaste/PINDD)
[![Code Climate](https://codeclimate.com/repos/5317dfb76956803f1b0091fc/badges/7e1f80a6544859d2f288/gpa.png)](https://codeclimate.com/repos/5317dfb76956803f1b0091fc/feed)

[PINDD live](http://pindd.herokuapp.com)

## Description

A Rails 4 web app for users to manage tasks and ideas in a dynamic way. Users can sign in and create tasks as sticky notes on an online display board. Users can create groups and add other users in order to share tasks.

![ScreenShot](https://dl.dropboxusercontent.com/u/13181175/pindd.png)


## Models

```rails
class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :notes
end

class Note < ActiveRecord::Base
  belongs_to :group
end

class User < ActiveRecord::Base
  has_and_belongs_to_many :groups
end

```

## Authors

* Joslyn Rosbrook (https://github.com/meowmaste)
* Lillian Ng (https://github.com/orangeninjamidget)
* Amanda Spiegel
