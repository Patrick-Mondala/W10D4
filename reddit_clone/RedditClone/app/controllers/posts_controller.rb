class PostsController < ApplicationController
    before_action :require_login, except: [:show]

    def show
        @post = Post.find(params[:id])

        render :show
    end

    def new
        @post = Post.new

        render :new
    end

    def create
        @post = Post.new(post_params)

        if @post.save
            redirect_to post_url(@post)
        else
            flash.now[:errors] = @post.errors.full_messages
            render :new
        end
    end

    def edit
        @post = Post.find(params[:id])

        render :edit if current_user.op?(@post)
    end

    def update
        @post = Post.find(params[:id])

        if current_user.op?(@post)
            if @post.update(post_params)
                redirect_to post_url(@post)
            else
                flash.now[:errors] = @post.errors.full_messages
                render :edit
            end
        end
    end

    def destroy
        @post = Post.find(params[:id])
        if current_user.mod?(@post.sub) || current_user.op?(@post)
            @post.destroy
        end
    end

    private
    
    def post_params
        params.require(:post).permit(:title, :url, :content, :sub_ids)
    end
end