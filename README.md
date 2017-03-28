# Spree Mail Settings

[![Build Status](https://travis-ci.org/spree-contrib/spree_mail_settings.svg?branch=master)](https://travis-ci.org/spree-contrib/spree_mail_settings)
[![Code Climate](https://codeclimate.com/github/spree-contrib/spree_mail_settings/badges/gpa.svg)](https://codeclimate.com/github/spree-contrib/spree_mail_settings)

---

## Installation

1. Add this extension to your Gemfile with this line:
  #### Spree >= 3.1

  ```ruby
  gem 'spree_mail_settings', github: 'spree-contrib/spree_mail_settings'
  ```

  #### Spree 3.0 and Spree 2.x

  ```ruby
  gem 'spree_mail_settings', github: 'spree-contrib/spree_mail_settings', branch: 'X-X-stable'
  ```

  The `branch` option is important: it must match the version of Spree you're using.
  For example, use `3-0-stable` if you're using Spree `3-0-stable` or any `3.0.x` version.

2. Install the gem using Bundler:
  ```ruby
  bundle install
  ```

3. Restart your server

  If your server was running, restart it so that it can find the assets properly.

---

## Contributing

See corresponding [guidelines][4]

---

## License

Copyright (c) 2014-2015 [John Hawthorn][1] and [contributors][2], released under the [New BSD License][3]

[1]: https://github.com/jhawthorn
[2]: https://github.com/spree-contrib/spree_mail_settings/graphs/contributors
[3]: https://github.com/spree-contrib/spree_mail_settings/tree/master/LICENSE.md
[4]: https://github.com/spree-contrib/spree_mail_settings/tree/master/CONTRIBUTING.md
