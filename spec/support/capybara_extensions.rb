module RSpec::CapybaraExtensions
  def rendered
    Capybara.string(@rendered)
  end

  def within(selector)
    yield rendered.find(selector)
  end
end
