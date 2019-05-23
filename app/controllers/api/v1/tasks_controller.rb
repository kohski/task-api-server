module Api
  module V1
    class TasksController < ApplicationController
      before_action :authenticate_user!

      def index
        tasks = Task.order(created_at: :desc)
        p tasks
        render json: {
          status: 'SUCCESS',
          message: 'loaded oists',
          data: {
            tasks: tasks,
            current: current_user
          }
        }
      end
    
      def show
      end
    
      def create
        task = Task.new(set_task);
        if task.save
          render json: {
            status: 'SUCCESS',
            message: 'loaded tasks',
            data: {
              tasks: task,
            }
          }
        else
          render json: {
            status: 'FAIED',
            message: 'not posted tasks',
            data: {
              tasks: task,
            }
          }
        end
      end
    
      def destroy
        task = Task.find(params[:id])
        if task.destroy
          render json:{
            status: 'SUCCESS',
            message: 'task is deleted',
            data: {
              tasks: task,
            }

          }
        end
      end
    
      def update
        task = Task.find(params[:id])
        if task.update(set_task)
          render json: {
            status: 'SUCCESS',
            message: 'task is updated',
            data: {
              tasks: task,
            }
          }
        else
          render json: {
            status: 'Failed',
            message: 'task is not updated',
            data: {
              tasks: task,
            }
          }
        end
      end

      private

      def set_task
        params.require(:task).permit(:title, :content, :isDone)
      end

    end    
  end
end
