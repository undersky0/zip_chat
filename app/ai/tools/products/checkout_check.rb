class Tools::Products::CheckoutCheck < RubyLLM::Tool
  description "Whenever user is ready to checkout check if user details are present and complete"

  # check if user details are present and complete and ready for checkout
  def execute
    return "User information is not available." unless user

    if user.first_name.present? && user.last_name.present? && user.address&.postcode.present? && user.phone.present? && user.email.present?
      "User details are complete. You are ready to checkout."
    else
      missing_fields = []
      missing_fields << "first name" if user.first_name.blank?
      missing_fields << "last name" if user.last_name.blank?
      missing_fields << "postcode" if user.address&.postcode.blank?
      missing_fields << "phone" if user.phone.blank?
      missing_fields << "email" if user.email.blank?

      "Please tell us your #{missing_fields.join(', ')} to proceed with checkout."
    end
  end

  attr_reader :user

  def initialize(user: )
    @user = user
  end
end
