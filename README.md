# ConfigReader 0.0.1  [![Build Status](https://secure.travis-ci.org/TheGiftsProject/configreader.png)](http://travis-ci.org/TheGiftsProject/configreader)

 ConfigReader provides an easy way to load up your configuration YAML files into Ruby objects,
 providing a more concise API to access your configuration data, by accessing methods instead of Hash keys. It also
 allows you to configure environment aware configuration objects, keeping your code DRY.
 You can use it to access your FACEBOOK / ANALYTICS configuration YAML's for instance.

 Note: Only the first level YAML keys can be accessed as methods.

## Usage

Note: The examples are for a Rails 3 app.

* Add our gem to your Gemfile:

`gem 'configreader'`

* The most simple way to use ConfigReader is to change your existing config initializer files to use it
like so:

Let's say you have a YAML config like `config/facebook.rb`
```yaml
 development:
    id: 123
    secret_key: secret_key
 production:
    id: 456
    secret_key: secret_key
 test:
    id: 678
    secret_key: secret_key
 staging:
    id: 154
    secret_key: secret_key
```

In your config initializer, initialize an EnvConfigReader like so:
```ruby
   FACEBOOK = ConfigReader::EnvConfigReader.new("facebook.yml")
```

Then you could access FACEBOOK config from anywhere in your Rails app:
```ruby
   FACEBOOK.some_config
```

Since we are using an EnvConfigReader object, the some_config we asked for is loaded up from the current RAILS_ENVIRONMENT.
By default, ConfigReader will assume your config folder is your Rails.root/config, and will build the full path using it.

There's also a FlatConfigReader, which is the more basic version. it's useful for flat config files like so:
```yaml
   key1: 1
   key2: 2
```

```ruby
   FLAT = ConfigReader::FlatConfigReader.new("flat.yml")
   FLAT.key1
```

## Automatically creating configuration objects

A more advanced feature ConfigReader offers, is automatically loading all your configuration files during the initialization
of your Rails app.

It's turned off by default, so to turn it on, we'll need to create an initializer for ConfigReader:

`config/initializers/configreader.rb`
```ruby
   ConfigReader.initialize do
      config.auto_create_config_objects = true
   end
```

You're almost done, you'll need to move your YAML configuration files to the default configreader directory:
`#{Rails.root}/config/configreader`

The YAML files in the root configreader folder will be created with a FlatConfigReader, and the ones in the
`#{Rails.root}/config/configreader/env` will be created with an EnvConfigReader.
The configuration objects will be set as consts on Object, so you'll be able to access them from anywhere
in your Rails app, just like we already did in the initializers.

`auto_create_class` - You can also override the default auto_create behavior to set the consts instead on Object, to something else
like ConfigReader, so then you'll be able to access them using that object: `ConfigReader::EXAMPLE`

`auto_create_config_folder` - The default value to the config_folder is `#{Rails.root}/config/configreader`. Use this config
item to override it another path.

## Requirements

Ruby 1.8.7+, Rails 3.0+.