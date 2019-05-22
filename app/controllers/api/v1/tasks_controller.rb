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
      end
    
      def destroy
      end
    
      def update
      end
    end    
  end
end
