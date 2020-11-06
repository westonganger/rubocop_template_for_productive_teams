# Rubocop Template For Productive Teams

Rubocop starter setup that is a great for teams that want to develop quickly and without restrictions.

It is imperitive for your team that your Rubocop configuration is flexible and super-powers your development workflow. Too many projects suffer from slowed development because of their Rubocop configuration. Most of this stems from that fact that the Rubocop defaults are too restrictive and opinionated in a bad way. Ruby was built for developer happiness but unfortunately using the default Rubocop setup seems to take away the joy of development. Use this template with Rubocop to bring back your Ruby joy


# Features

- Many, many cops are disabled to improve the workflow
- Focused on developer productivity and flexibility
- Doesnt force too many opinions upon the developer
- Custom Cops Loader
- Custom Cop template with basic documentation
- A few of my own custom cops

# Instructions

This is a good starting point for your organization if you want to start utilizing Rubocop.

After you copy these files into your repository then you should:

- Run it against your repository
- Decide which cops you want to additionally disable
  * Before you do this, Note that you can utilize autocorrect for a large majority of the failures
- Optional: Decide which cops your organization wants to re-enable on a case-by-case basis

# Files

- [.rubocop.yml](https://github.com/westonganger/rubocop_template_for_productive_teams/blob/master/.rubocop.yml)
- [.rubocop_rspec.yml](https://github.com/westonganger/rubocop_template_for_productive_teams/blob/master/.rubocop_rspec.yml)
- [.rubocop_minitest.yml](https://github.com/westonganger/rubocop_template_for_productive_teams/blob/master/.rubocop_minitest.yml)
- [Gemfile](https://github.com/westonganger/rubocop_template_for_productive_teams/blob/master/Gemfile)
- [rubocop/load_all_custom_cops.rb](https://github.com/westonganger/rubocop_template_for_productive_teams/blob/master/rubocop/load_all_custom_cops.rb)
- [rubocop/cop_template.rb](https://github.com/westonganger/rubocop_template_for_productive_teams/blob/master/rubocop/cop_template.rb)
- [rubocop/custom_cops/](https://github.com/westonganger/rubocop_template_for_productive_teams/tree/master/rubocop/custom_cops/)

# Credits

Created by [Weston Ganger](https://westonganger.com) - [@westonganger](https://github.com/westonganger)
