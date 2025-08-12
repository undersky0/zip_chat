class Tools::UpdateUserDetails < RubyLLM::Tool
  description "update user details - ensure user profile is complete for checkout"

  param :first_name,
    desc: "The user's first name"
  param :last_name,
    desc: "The user's last name"
  param :postcode,
    desc: "The user's postcode"
  param :phone,
    desc: "The user's phone number"
  param :email,
    desc: "The user's email address"

  # check if user details are present and complete and ready for checkout
  def execute(first_name: nil, last_name: nil, postcode: nil, phone: nil, email: nil)
    params = { first_name: first_name, last_name: last_name, postcode: postcode, phone: phone, email: email }

    updatable_fields.each do |field|
      param_value = params[field]
      if param_value.present?
        user.send("#{field}=", param_value)
      else
        missing_fields << field if user.send(field).blank?
      end
    end

    user.save(validate: false) if user.changed?

    if missing_fields.empty?
      "You are ready to checkout."
    else
      "Please tell us your #{missing_fields.join(', ')} to proceed with checkout."
    end
  end

  def updatable_fields
    [:first_name, :last_name, :postcode, :phone, :email]
  end

  attr_reader :user, :missing_fields

  def initialize(user: )
    @user = user
    @missing_fields = []
  end
end
