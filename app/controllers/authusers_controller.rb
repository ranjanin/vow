class AuthusersController < ApplicationController
 # layout_by_action [:change_role, :change_role_update] => "menu1"
  before_filter :authenticate_authuser!, :except => [:force_password_change]
  layout_by_action [:client_new, :client_edit, :invoice_format] => "menu"
  filter_access_to :all
 
  def index
   # if params[:approved] == "false"
    #  @users = Authuser.find_all_by_approved(false)
    #else
      @users = Authuser.all
  #  end
  end
 
  
  def new
    @user = Authuser.new
  end
  
 
  def show
  @user = Authuser.find(params[:id])
  @auth_user_category = AuthUserCategory.new
  end
  
  def create
    @user = Authuser.new(set_params)
    if @user.save
      redirect_to authusers_path
    else
      render action: 'new'
    end
  end
  
  
   def edit
    @user = Authuser.find(params[:id])
  end
  
  
  def update
    @user = current_authuser
    if @user.update_attributes(set_params)
     # flash[:notice]=  "Password updated successfully"
      if current_authuser.main_roles.first.role_name == 'client'
        redirect_to dashboards_client_dashboard_path
      elsif current_authuser.main_roles.first.role_name == 'user'
        redirect_to dashboards_user_dashboard_path
      elsif current_authuser.main_roles.first.role_name == 'secondary_user'
        redirect_to dashboards_secondary_user_dashboard_path
      end
    else
     render action: 'force_password_change'
      flash[:alert] = "Ensure Both the passwords are the same"
    end
  end
  
  
   def destroy
    @user = Authuser.find(params[:id])
  @user.destroy
  end
  
  #For client creation
  def admin_new
    @client = Authuser.new
    @client.address = Address.new
    @client.membership = Membership.new
    @client.bankdetail = Bankdetail.new
   # @client.permissions.build
    @client.clients.build   
    @client.users.build
    end
  
  
  def admin_create
    @client = Authuser.new
    if @client.update_attributes(set_params)
      redirect_to dashboards_admin_dashboard_path
     else
      render action: 'admin_new'
     end
    end
  
  
  #keep these for reference
  #if Authuser.joins(:permissions).where(:m_role_id => 1)
     #
 #    if Authuser.joins(:permissions).where(:m_role_id => 5)
   # Client.created_by = current_authuser.id
   # params[:client][:created_by] = current_authuser.id
  
  
  def admin_edit
    @client = Authuser.find(current_authuser.id)
  end
  
    
  def admin_update
   
    @client = current_authuser    
    if  @client.update_attributes(set_params)
    redirect_to dashboards_client_dashboard_path
    else   
    render action: 'admin_edit'
     end
    
  end
    
    #if @client.save
    #redirect_to dashboards_client_dashboard_path
    #else
     # render action: 'admin_edit'
    #end
  #end
  
  
  def activate_user
    user = Authuser.find(params[:id])
    user.update_attribute(:approved, true)
    invited_role = user.invited_by.main_roles.first.role_name
    if invited_role == "client"
      redirect_to dashboards_client_dashboard_path
    elsif invited_role == "admin"
       redirect_to dashboards_admin_dashboard_path    
    elsif invited_role == "user"
      redirect_to dashboards_user_dashboard_path
   end
  end
    
  
  def de_activate_user
    user = Authuser.find(params[:id])
    user.update_attribute(:approved, false)
    invited_role = user.invited_by.main_roles.first.role_name
    if invited_role == "client"
      redirect_to dashboards_client_dashboard_path
    elsif invited_role =="admin"
        redirect_to dashboards_admin_dashboard_path    
    elsif invited_role == "user"
      redirect_to dashboards_user_dashboard_path    
    end
  end
    
  def change_role
    @user = current_authuser
    @user_roles = current_authuser.main_roles
  end
  
  
  def change_role_update
    @user = current_authuser
#     if @user.current_role == params[:role]
#       flash[:error] = 'This role is already assigned to this user'
#       redirect_to :back
#     else
    #dashboards_admin_dashboard
    #params[:roles] = @user.current_role 
    #@user.current_role = params[:roles]'
    if params[:roles].blank?
      redirect_to authusers_change_role_path
     flash[:notice] =  "Please select a role"
    else
      user = current_authuser
      user.update_attribute('role', params[:roles])
      redirect_to public_send("dashboards_#{params[:roles]}_dashboard_url")  
  end
end
  

  def force_password_change
    @user = current_authuser
  end


# For user creation, views/authusers/invitations/new and edit are used. Devise_invitable is used to invite user and in the model all the required tables are invoked when user is invited

#for User update profile
  
  def client_new
    @user = current_authuser
    #@user = Authuser.new
   # @user.membership = Membership.new
   # @user.bankdetail = Bankdetail.new
   # @user.address = Address.new
   # @user.permissions.build
   # @user.users.build
  end
  
  def client_create
    @user = current_authuser
    if @user.update_attributes(set_params)
      redirect_to dashboards_user_dashboard_path
      flash[:notice] = "Profile Updated Successfully"
  else
      render action: 'client_new'
  end
end
  
# client_edit and client_update are not used now

def client_edit
  @user = current_authuser
end


  def client_update
    @user = current_authuser
      if @user.update_attributes(set_params)
        redirect_to dashboards_secondary_user_dashboard_path
        else
        render action: 'client_edit'
        end
      end
     

  def secondary_user
    @secondary_user = Authuser.new
    @secondary_user.membership = Membership.new
    @secondary_user.permissions.build
  end

  def secondary_user_create
    @secondary_user = Authuser.new
    @secondary_user.invited_by_id = current_authuser.id
    if @secondary_user.update_attributes(set_params)
      redirect_to dashboards_user_dashboard_path(current_authuser.id)
    else
      render action: 'secondary_user'
    end
  end


  def user_management   
    @users = Authuser.where(:invited_by_id => current_authuser.id).order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    @users_accepted = Authuser.where('invited_by_id = ? AND invitation_accepted_at IS NOT NULL', current_authuser.id).order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    @users_expired_invitation = Authuser.where('invited_by_id =? AND invitation_sent_at <= ? AND invitation_accepted_at IS NULL', current_authuser.id, Date.today-2.days).order('created_at DESC').paginate(:page => params[:page], :per_page => 10) 
     if current_authuser.main_roles.first.role_name == "client"
      render :layout => "application"
    elsif current_authuser.main_roles.first.role_name == "user"
      render :layout => "menu"
    end
  end

  def invite_user_again
    @user = Authuser.find(params[:id])
    if current_authuser.main_roles.first.role_name == "client"
      @user.address.delete
      @user.membership.delete
      @user.bankdetail.delete
      @user.users.delete_all
      @user.permissions.delete_all
      @user.delete
    elsif current_authuser.main_roles.first.role_name == "user"
      @user.membership.delete
      @user.permissions.delete_all
      @user.delete
    end
    #@user.update_attribute(:invitation_sent_at, Time.now)
    #redirect_to dashboards_client_dashboards_path
    redirect_to new_authuser_invitation_path
  end
  

  def user_profile_picture
    @user = current_authuser
    if current_authuser.main_roles.first.role_name == "client"
      render :layout => "application"
    elsif current_authuser.main_roles.first.role_name == "user"
      render :layout => "menu"
    end
  end


  def invoice_format
    @user = current_authuser
  end
# used from bills new page, not from update profile page -->
  def invoice_format_update
    @user = current_authuser
    role = @user.main_roles.first.role_name
   # invoice = params[:authuser][:invoice_format]
#    if !invoice.present?
    if !params[:authuser][:invoice_format].nil?
        @user.update_attributes(set_params)#(:invoice_format, params[:authuser][:invoice_format])
        redirect_to public_send("dashboards_#{role}_dashboard_url")
    else
       redirect_to authusers_invoice_format_path
       flash[:alert] = "Please select Invoice Format" 
    end
  end

 
  private
  def set_params
    params[:authuser].permit(:name, :email, :password, :password_confirmation, :approved, :invited_by_id, :invited_by_type, :date_of_birth, :image, :role, :invoice_format, :invoice_string,
     {:membership_attributes => [:id, :phone_number, :membership_start_date, :membership_end_date, :membership_status, :membership_duration]},
       {:address_attributes => [:id, :address_line_1, :address_line_2, :address_line_3, :city, :state, :country]},
      {:bankdetail_attributes => [:id, :bank_account_number, :ifsc_code]},
      {:clients_attributes => [:id, :unique_reference_key, :remarks, :char, :digits, :created_by, :company, :referral_id]}, 
     {:main_role_ids => []},
      {:users_attributes => [:id, :tin_number, :esugam_username, :esugam_password, :client_id, :company]},
      {:permissions_attributes => [:main_role_id]}
     )
  end
  
  

end
