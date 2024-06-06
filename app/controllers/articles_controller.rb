class ArticlesController < ApplicationController
    before_action :find_article,only: [:show,:edit,:update,:destroy]
    before_action :require_user,except: [:show,:index]
    before_action :require_same_user,only: [:edit,:update,:destroy]

    def show
        
    end
    def index
        @articles=Article.paginate(page: params[:page], per_page: 3)
    end
    def new
        @article=Article.new
    end
    def create 
    
       @article=Article.new(articles_params)
       @article.user=User.find(current_user.id)
       if @article.save
        flash[:notice]="Article is saved successfully"
        redirect_to article_path(@article)
       else
        render :new, status: :unprocessable_entity
       end

    end
    def edit
       
    end
    def update
      
        if @article.update(articles_params)
            flash[:notice]="Article is updated succesfully"
            redirect_to article_path(@article)
        else
            render :edit, status: :unprocessable_entity
        end

    end
    def destroy
        @article.destroy
        flash[:notice]="Article is Deleted succesfully"
        redirect_to articles_path 
    end
    private 
    def find_article
        @article=Article.find(params[:id])
    end
    def articles_params
        params.require(:article).permit(:title,:Description,category_ids:[ ])
    end
    def require_same_user
        if current_user != @article.user &&  !current_user.admin?
            flash[:alert]="You can Edit or Delete Your Own Articles Only"
            redirect_to articles_path(@articles)
        end
    end
end