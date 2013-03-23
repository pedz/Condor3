class DatabaseState
  include Singleton

  def initialize
    @state = :unknown
    @last_strategy = nil
  end

  def record_strategy
    @last_strategy = DatabaseCleaner.connections.first.strategy.class.to_s.sub(/.*::/, '').downcase.to_sym
  end

  def last_strategy
    @last_strategy
  end

  def get_to_state(state)
    determine_state
    if state != @state
      yield
    end
    @state = state
  end

  private

  def determine_state
    return if @state == :unknown
    if last_strategy == :deletion || last_strategy == :truncation
      @state = :empty
    end
  end
end
