class UsersController < ApplicationController
    before_action :find_user,only: [:edit,:update]
    def new
        @user=User.new
    end
    def create 
        @user=User.new(user_params)
        if @user.save
            flash[:notice]="Welcome To Alpha Blog,#{@user.username} Created Successfully"
            redirect_to articles_path
        else
         render :new, status: :unprocessable_entity
        end
 
     end
     def edit

     end
     def update
        if @user.update(user_params)
            flash[:notice]="User Profile is Updated"
            redirect_to articles_path
        else
            render :edit,status: :unprocessable_entity
        end
     end

     private
     def user_params
        params.require(:user).permit(:username,:email,:password)
     end
     def find_user
        @user=User.find(params[:id])
     end
end 
