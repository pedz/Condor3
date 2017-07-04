#!/bin/bash

# $1 is the path to the new theme file frmo jQuery-UI -- e.g.
# .bundle/gems/ruby/2.3.0/gems/jquery-ui-rails-6.0.1/app/assets/stylesheets/jquery-ui/theme.css.erb
# or https://github.com/jquery/jquery-ui/blob/master/themes/base/theme.css
#
# The concept is this:
#   A variable in the css looks like: /*{ffDefault}*/
#   There can be multiple variables on a line.
#   e.g. background: #ffffff/*{bgColorContent}*/ /*{bgImgUrlContent}*/ /*{bgContentXPos}*/ /*{bgContentYPos}*/ /*{bgContentRepeat}*/;
#
#   1) We substitute "}*/ /*{" (the stuff between variables) with " $".
#   2) Substitute "}*/;" for ";"
#   3) Substitue the text after the ": " up to the "/*{" with a ": $"

# So... this isn't used.  WHY?  Because jQuery-UI does not use border styles or border widths.

# I ended up just removing the Sass version of the template and hand
# editing a few things at the top of condor.css.scss.

curl https://raw.githubusercontent.com/jquery/jquery-ui/master/themes/base/theme.css |
  sed -e 's%}\*/  */\*{% $%g' \
      -e 's%}\*/;%;%' \
      -e 's%:  *.*/\*{%: $%'

