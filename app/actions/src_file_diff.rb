# -*- coding: utf-8 -*-
#
# Copyright 2012-2013 Ease Software, Inc.
# All Rights Reserved
#

# A misnamed service that does a diff of two sequences passed in.
# Since this is always used for files in the current application, it
# is called source file diff but it is actually somewhat generic.
class SrcFileDiff

  # Callbacks used to create the sequences describing a diff.  The
  # sequences have four types of elements.  All of them are an array
  # of three values.
  #
  # When two lines matches, the elements is:
  #   [ 'match', nil, line ]
  #
  # When a line is deleted from the old sequence, the element is:
  #   [ 'discard_a', seq#, old line or nil ]
  # The old sequence (old_seq) will have the old line while the new
  # sequence (new_seq) will have nil
  #
  # When a line is added (in the new sequences of lines but not the
  # old), the element is:
  #   [ 'discard_b', seq#, nil or new line ]
  # The old sequence will have nil while the new sequence will have
  # the new line.
  #
  # When a line changes, the element is:
  #   [ 'change', seq#, line ]
  # where line will be the old line in the old sequence and the new
  # line in the new sequence.
  #
  # The seq# is an integer and is used to match the changes up.  For
  # example if four lines are deleted, the old sequence will have the
  # four lines with the same seq # and the new sequence will have a
  # single element with the same seq # and nil for the line element.
  class Callbacks
    ##
    # :attr: old_seq
    # Change sequence of the old file
    attr_reader :old_seq

    ##
    # :attr: new_seq
    # Change sequence of the new file
    attr_reader :new_seq
    
    def initialize
      @old_seq = []
      @new_seq = []
      @diff_num = 0
      @last_match = :match
    end
    
    def match(event)
      @old_seq << ['match', nil, event.old_element]
      @new_seq << ['match', nil, event.new_element]
      @last_match = :match
    end
    
    def discard_a(event)
      unless @last_match == :discard_a
        @diff_num += 1
        @new_seq << ['discard_a', @diff_num, nil]
      end
      @old_seq << ['discard_a', @diff_num, event.old_element]
      @last_match = :discard_a
    end
    
    def discard_b(event)
      unless @last_match == :discard_b
        @diff_num += 1
        @old_seq << ['discard_b', @diff_num, nil]
      end
      @new_seq << ['discard_b', @diff_num, event.new_element]
      @last_match = :discard_b
    end
    
    def change(event)
      unless @last_match == :change
        @diff_num += 1
      end
      @old_seq << ['change', @diff_num, event.old_element]
      @new_seq << ['change', @diff_num, event.new_element]
      @last_match = :change
    end
    
    def diff_count
      @diff_num
    end
    
    private
    
    def do_event(how, event)
      num = @last_match ? nil : @diff_num
    end
  end

  # * *Args*    :
  #   - +old_lines+ -> Array of original lines.
  #   - +new_lines+ -> Array of the new lines.
  def initialize(old_lines, new_lines)
    @callbacks = Callbacks.new
    Diff::LCS.traverse_balanced(old_lines, new_lines, @callbacks)
  end

  # Returns the number of "Hunks" in the diff
  def diff_count
    @callbacks.diff_count
  end

  # Returns the old_seq of the diff algorithm
  def old_seq
    @callbacks.old_seq
  end

  # Returns the new_seq of the diff algorithm
  def new_seq
    @callbacks.new_seq
  end
end
