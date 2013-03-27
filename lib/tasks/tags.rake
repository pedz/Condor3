
desc "Create TAGS and ALL-TAGS"
task :create_tags do
  regexp = Regexp.new('^ +\* +([^ ]+) \(([^)]*)\).*$')
  ctags = "xargs -0 ctags -e -a"

  # Clean out old tags
  system "rm -f TAGS ALL-TAGS"

  # Creates tags with only application in it
  exclude = %w{ .bundle doc .git tmp cache }.map{ |n| "-name #{n}"}.join(' -o ')
  prune = "\\( -type d \\( #{exclude} \\) -prune \\)"
  cmd = %Q{find . #{prune} -o -type f -print0 | #{ctags}}
  system cmd

  # save as sTAGS
  system "cp TAGS sTAGS"
  
  # list becomes a string like
  # actionmailer-3.2.11|actionpack-3.2.11|activeldap-3.2.2|activemodel-3.2.11 ...
  list = %x[ bundle list ].split("\n").find_all { |l| regexp.match(l) }
  list = list.map { |l| l.gsub(regexp, '\1-\2') }.join('|')

  exclude = %w{ doc spec features test .git tmp cache }.map{ |n| "-name #{n}"}.join(' -o ')
  prune = "\\( -type d \\( #{exclude} \\) -prune \\)"
  want = %Q{-regex "\\./\\.bundle/.*/(#{list}).*" -type f}
  cmd = %Q{find -E . #{prune} -or #{want} -print0 | #{ctags} }
  
  # append tags for gems
  system cmd

  # Now rename
  system "mv TAGS ALL-TAGS"
  system "mv sTAGS TAGS"
end
