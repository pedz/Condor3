# -*- coding: utf-8 -*-
#
# Copyright 2012 Ease Software, Inc.
# All Rights Reserved
#

# A model that represents a diff between two source files.
class SrcFileDiff
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


  ##
  # :attr: old_file
  # The old version of the file (a SrcFile)
  attr_reader :old_file

  ##
  # :attr: new_file
  # The new version of the file (a SrcFile)
  attr_reader :new_file
  
  ##
  # :attr: callbacks
  # The set of call backs used
  attr_reader :callbacks

  def initialize(old_file, new_file)
    @old_file, @new_file = old_file, new_file
    @callbacks = Callbacks.new
    # Not sure we need to save this.
    @bal = Diff::LCS.traverse_balanced(@old_file.lines, @new_file.lines, @callbacks)
  end
end
