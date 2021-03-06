class Notification < ActionMailer::Base
 # default from: "support@fhqpro.com"
  default from: "support@vatonwheels.com"
  
  
  def new_category(usercategory)
    @category = usercategory
    mail(:to => "nvranjani@gmail.com", :subject => "New category added to user")
  end
  
  def user_activated_mail(user)
    @user = user
    #@token = @user.reset_password_token.digest(@user, :reset_passowrd_token)
   #@token = Devise.token_generator.generate(@user, :reset_password_token)
    #to_adapter.find_first(reset_password_token: @token)
    mail(:to => @user.email, :subject => "Welcome to VatonWheels!! . Your Accout has been activated!")
  end


  
  def membership_end_date_reminder(user)
    @user = user
    mail(:to => @user.email, :subject => "Your account on VatonWheels will expire in 2 days, Contact your CA for further details ")
  end
  
  def new_enquiry(enquiry_form)
    @enquiry_form = enquiry_form
    mail(:to => "support@vatonwheels.com", :subject => "VatonWheels - New User Enquiry")
  end
  
  
  def new_user(user)
   @user = user
   mail(:to =>  @user.invited_by.email ,:subject => "VatOnWheels – New User #{@user.name} Registration!")
   end

  def secondary_user_mail(user)
    @user = user
    mail(:to => @user.email, :subject => "Your account in VatOnWheels has been created successfully!")
  end
  
  def customer_mail(bill)
    @bill = bill
    attachments["Bill.pdf"] = File.read("app/assets/files/bill_pdf" + @bill.authuser.id.to_s + ".pdf")
    urd_values = ["Others", "Other", "other", "others"]
    if urd_values.include? @bill.customer.name
      @email_id = @bill.unregistered_customers.first.email
      @company = @bill.unregistered_customers.first.customer_name
    else
      @email_id = @bill.customer.email
      @company = @bill.customer.company_name
    end
    mail(:to => @email_id, :subject => "Invoice")    
  end
  
end
