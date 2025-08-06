class AiTools::Products::CheckoutCheck < RubyLLM::Tool
  description "Whenever user is ready to checkout"
  # check if user details are present and complete and ready for checkout
  def execute
    if Current.user
      if Current.user.first_name.present? && Current.user.last_name.present? &&
          Current.user.address.present? && Current.user.phone.present? && Current.user.email.present?
        { message: "You are ready to checkout with the provided details." }
      else
        { message: "Please complete your profile with first name, last name, address, phone number, and email to proceed with checkout." }
      end
    else
      { message: "Please provide your first and last name"} # maybe we could broadast a form to update the user details
    end
  end
end
