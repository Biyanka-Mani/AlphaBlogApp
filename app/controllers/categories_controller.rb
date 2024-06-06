class CategoriesController < ApplicationController
    before_action :find_category,only:[:edit,:update]
    before_action :require_admin,except:[:index,:show]
    def index
        @categories=Category.paginate(page: params[:page], per_page: 3)
    end
    def new
        @category=Category.new
    end
    def show
        @category=Category.find(params[:id])
        @articles=@category.articles.paginate(page: params[:page], per_page: 3)
    end
    def create
        @category=Category.create(category_params)
        if @category.save
            flash[:notice]="Category Created Successfully"
            redirect_to category_path(@category)
        else
            flash.now[:notice]="Category Creation Error Occured"
            render :new,status: :unprocessable_entity
        end

    end
    def edit
        
    end
    def update
        if @category.update(category_params)
            flash[:notice]="Category is Updated"
            redirect_to category_path(@category)
        else
            render :edit,status: :unprocessable_entity
        end
    end
    private 

    def category_params
        params.require(:category).permit(:name)
    end
    def find_category
        @category=Category.find(params[:id])
    end
    def require_admin
        if !(logged_in? && current_user.admin)
            flash[:alert]="the required action can be performed only by admin!"
            redirect_to categories_path
        end
    end

end