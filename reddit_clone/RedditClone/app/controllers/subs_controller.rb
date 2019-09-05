class SubsController < ApplicationController
    before_action :require_login, only: [:new, :create, :edit, :update, :destroy]

    def index
        @subs = Sub.all

        render :index
    end

    def show
        @sub = Sub.find(params[:id])

        render :show
    end

    def new
        @sub = Sub.new
        render :new
    end
    
    def create
        @sub = Sub.new(sub_params)
        @sub.moderator_id = current_user.id
        if @sub.save
            redirect_to sub_url(@sub)
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :new
        end
    end

    def edit
        @sub = Sub.find(params[:id])

        render :edit if current_user.mod?(@sub)
    end

    def update
        @sub = Sub.find(params[:id])

        if current_user.mod?(@sub)
            if @sub.update(sub_params)
                redirect_to sub_url(@sub)
            else
                flash.now[:errors] = @sub.errors.full_messages
                render :edit
            end
        end
    end

    private

    def sub_params
        params.require(:sub).permit(:title, :description)
    end
end