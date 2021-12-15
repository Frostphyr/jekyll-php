# Jekyll PHP

Jekyll PHP adds better support for PHP in Jekyll. Jekyll, as a static site 
generator, does not directly support PHP so there are inconsistencies 
regarding which features work with PHP. Jekyll PHP attempts to add support for 
PHP to the missing features, and even more.

## Requirements

Jekyll PHP requires at least Jekyll 3.2 but has no other dependencies.

## Installation

### Bundler

Add this line to your application's Gemfile:

```ruby
gem 'jekyll-php'
```

**NOTE:** You may alternatively want to use a 
[version constraint](https://guides.rubygems.org/patterns/#pessimistic-version-constraint)

And then run the command:

```console
$ bundle install
```

### Gem

Run the command:

```console
$ gem install jekyll-php
```

## Features

### Permalink Style

Jekyll has the global config variable `permalink` which sets a permalink style 
for every page, post, and collection. PHP files will now adhere to the 
permalink style.

### Composer

When using [Composer](https://getcomposer.org/), Jekyll PHP can help steamline 
the process when building the site. It will exclude the appropriate files and 
install Composer production-ready when building your site for production.

There are two ways to specify a production build. The first is using 
[environments](https://jekyllrb.com/docs/configuration/environments/) and 
setting `JEKYLL_ENV=production`. The second option is to add a `environment` 
variable to your global config file and set it to `production`.

Composer should already be installed in the root directory of your site, so it 
should contain `composer.json`, `composer.lock`, and `vendor/`. When the 
building environment is anything but production, it will simply use what is 
already installed into `vendor/`. When the building environment is production, 
it will use `composer.json` and `composer.lock` to install Composer for 
production, which basically means installing Composer with certain flags. 
Below lists all of the variables that may be changed in the global config file 
and their default values.

| Name | Type | Default Value | Description |
| ---- | ---- | ------------- | ----------- |
| environment | String | development | The build environment (development, production, etc) |
| composer | Boolean | true | Whether the Composer helper should run |
| composer_output | Boolean | false | Whether to log the output from Composer |
| composer_command | String | composer install | The command to run to install Composer for production |
| composer_flags | Array | [no-ansi, no-dev, no-interaction, no-plugins, no-progress, no-scripts, optimize-autoloader] | The flags to add to the composer_command |

## License

Jekyll PHP is licensed under [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0). 
You may also refer to the included LICENSE.txt file.