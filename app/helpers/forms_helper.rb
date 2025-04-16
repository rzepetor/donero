module FormsHelper
  def errors_for(field, form)
    render "shared/forms/errors", field:, form:
  end
end
