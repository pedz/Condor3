# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
# Stored procedure to return the basename when given a string.  In
# this case, the basename is sans any directory as well as any
# extension.
class Basename < ActiveRecord::Migration
  def self.up
    execute <<EOF
CREATE OR REPLACE FUNCTION basename(text) RETURNS text AS $$
    SELECT regexp_replace($1, E'^(.*/)?([^/.]*)(\\\\..*)?$', E'\\\\2')
$$ LANGUAGE SQL IMMUTABLE STRICT;
EOF
  end

  def self.down
    execute "DROP FUNCTION basename(text);"
  end
end
