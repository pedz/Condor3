
desc "Create TAGS and ALL-TAGS"
task :create_tags do
  sh <<-'EOF'
    # Directories to exclude within gems
    EXCLUDE="-name doc -o -name spec -o -name features -o -name test"
    # How to call ctags via xargs
    CTAGS="xargs -0 ctags -e -a"

    # Get where the gems are located
    gems=$( gem env gemdir )/gems
    # Get real gem directory names
    dirs=$( bundle list | sed -n -e "s% *\* *\([^ ]*\) (\([^)]*\)).*$%$gems/\1-\2%p" | \
            ls -d 2>/dev/null )
    # Start clean
    rm -f TAGS ALL-TAGS
    # Find tags just for application
    find . \( -type d \( -name .bundle -o -name doc \) -prune \) -o -type f -print0 | $CTAGS
    # save a copy of those
    cp TAGS sTAGS
    # append tags for gems
    find $dirs \( -type d \( $EXCLUDE \) -prune \) -o -type f -print0 | $CTAGS
    # call the big one ALL-TAGS
    mv TAGS ALL-TAGS
    # call the app only TAGS
    mv sTAGS TAGS
  EOF
end
