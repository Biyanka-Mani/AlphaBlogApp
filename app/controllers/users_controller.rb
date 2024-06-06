class UsersController < ApplicationController
    before_action :find_user,only: [:edit,:update,:show,:destroy]
    before_action :require_user,only: [:edit,:update]
    before_action :require_same_user,only: [:edit,:update,:destroy]
    def new
        @user=User.new
    end
    def create 
        @user=User.new(user_params)
        if @user.save
             session[:user_id]=@user.id
            flash[:notice]="Welcome To Alpha Blog,#{@user.username} Created Successfully"
            redirect_to articles_path
        else
         render :new, status: :unprocessable_entity
        end
 
     end
     def edit

     end
     def index
        @users=User.paginate(page: params[:page], per_page: 3)
     end
     def update
        if @user.update(user_params)
            flash[:notice]="User Profile is Updated"
            redirect_to user_path(@user)
        else
            render :edit,status: :unprocessable_entity
        end
     end
     def show
        @articles=@user.articles.paginate(page: params[:page], per_page: 3)
     end
     def destroy
         @user.destroy
         if current_user == @user
            session[:user_id]=nil
         end
         flash[:notice]="User and all assoisated Articles is Deleted Successfully"
         redirect_to articles_path
     end

     private
     def user_params
        params.require(:user).permit(:username,:email,:password)
     end
     def find_user
        @user=User.find(params[:id])
     end
     def require_same_user
         if current_user != @user && !current_user.admin?
            flash[:alert]="You can only edit/Delete Your profile"
            redirect_to user_path(@user)
         end
     end
end 
