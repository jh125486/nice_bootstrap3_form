# NiceBootstrap3Form

A simple helper to deal with Twitter Bootstrap 3 and forms.  Also includes ActionView helpers for creating panels, buttons, buttongroups and wells.

## Installation

Add this line to your application's Gemfile:

    gem 'nice_bootstrap3_form'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nice_bootstrap3_form

## Usage

### Forms



### Helpers

#### BS3 Buttons
Button tag styled as a BS3 button
`<%= btn('This is a button') %> --> <button type="submit" name="button" class="btn btn-default">This is a button</button>`

Anchor tag styled as a BS3 button
`<%= btn('This is a Link', root_path, state: 'danger') %> --> <a href="/" class="btn btn-danger">This is a Link</a>`

Method signature: `btn(btn_text, link_to (optional), options)`
Options:
*   :state
*   :size
*   :class

* * *

Panels

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
