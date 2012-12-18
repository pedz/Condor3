class WelcomePresenter < Keynote::Presenter
  def welcome_form(obj, field, text_label)
    form_for obj do |f|
      out = f.label(field, text_label, :class => "form-description")
      out << f.text_field(field)
      out << f.submit("Submit")
    end
  end
end
