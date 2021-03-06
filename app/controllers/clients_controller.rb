class ClientsController < ApplicationController

 before_filter :authenticate_authuser!
  filter_access_to :all
  
  
  def index
  end
  
  def new
    @client = Client.new
  end
  
  def create
    @client = Client.new(set_params)
    @client.authuser_id = current_authuser.id
    if @client.save
      redirect_to dashboards_path
    else
      render adtion: 'new'
    end
  end
  
  def show
    @client = Client.find(params[:id])
      end
  
  def edit
    @client = Client.find(params[:id])
  end
  
  def update
    @user = current_authuser.clients.first 
    if  params[:client][:role_user] == "user"
     Permission.create(:authuser_id => current_authuser.id, :main_role_id => 3)
      users = User.where(:authuser_id => current_authuser.id)
      @users = users.first
      @users.update_attribute(:client_id, current_authuser.id)
     #@users.client_id = current_authuser.id
       #user.first.client_id = current_authuser.id
     redirect_to dashboards_client_dashboard_path
    elsif params[:client][:role_user] == "client"
      redirect_to dashboards_client_dashboard_path
      flash[:notice] = "User Role not added"
    end
  end
  
   # @client = current_authuser.clients.first 
   # if @user.update_attributes(params[:add_user_role])
    ## params[:role_user] == true
   # params[:role_user] = @user.role_user
      #@user.add_user_role = true
  #  if @user.role_user == true
      #Permission.create(:authuser_id => current_authuser.id, :main_role_id => 6)
     # User.create(:authuser_id => current_authuser.id, :client_id => current_authuser.id, :tin_number => )
   # redirect_to dashboards_client_dashboard_path
    
 # end
 #  end
  
  
  def destroy
    @client = Client.find(params[:id])
    @client.destroy
  end
  
  def user_role
    @user = current_authuser.clients.first
    #@user.client_id = current_authuser.id
  end
  
  #  @user = current_authuser
 # @user = Client.where(:authuser_id => current_authuser.id)  
  def update_user_role
   @user = current_authuser.clients.first 
    #if params[:add_user_role] == true
     # @user.add_user_role = true
      Permission.create(:authuser_id => current_authuser.id, :main_role_id => 3)
      redirect_to dashboards_client_dashboard_path
  #end
  end
  
  
  def referred
    @client = Client.find(params[:id])
  end
  
  def referral_update
    @client = Client.find(params[:id])
    if @client.update_attributes(set_params)
      redirect_to dashboards_admin_dashboard_path(current_authuser)
    end
 end
 
  
  
  private
  def set_params
    params[:client].permit(:authuser_id, :remarks,  :role_user, :referral_id,
      {:users_attributes => [:id, :tin_number, :esugam_username, :esugam_password, :authuser_id, :client_id]}
      )
  end 
    
    
end
