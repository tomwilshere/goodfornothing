class Conversation::PostsController < ApplicationController

  before_filter :fetch_categories

	def index
		
		page = params[:page] || 1
		
		@category = Conversation::Category.find_by_title(params[:category].gsub('-',' ')) if params[:category]
    @bookmarks = Conversation::Bookmark.where('published = true').limit(3)

	  if @category
	    @posts = Conversation::Post.order("created_at DESC").where('category_id = ?',@category.id).page(page) 		
	  else
		  @posts = Conversation::Post.order("created_at DESC").page(page)
		end
		
		respond_to do |format|
      format.html { render :layout => true }
      format.rss { 
        @posts = @posts
        render :layout => false 
      } 
    end
		
	end

	def show
		@post = Conversation::Post.find(params[:id])
	end
	
	private
	  def fetch_categories
	    @categories = Conversation::Category.all
	  end

end
