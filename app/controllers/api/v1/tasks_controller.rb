module Api
  module V1
    class TasksController < ApplicationController
      before_action :authenticate_user!

      def index
        tasks = Task.order(created_at: :desc)
        # tasks_with_url = tasks.select{|task| task }
        # tasks_with_url.each_with_index do |task, index|
        #   task[:image_url] = "titim"
        #   # task[:image_url] = tasks[index].picture_url
        # end
        
        render json: {
          status: 'SUCCESS',
          message: 'loaded oists',
          data: {
            tasks: tasks.to_json(methods:[:picture_url]),
            current: current_user,
          },
        }
      end
    
      def show
      end
    
      def create
        task = Task.new(set_task);

        if !params[:picture].empty?
          image_match = params[:picture].match(/^data:(.*?);(?:.*?),(.*)$/)
          mime_type, encoded_image = image_match.captures
          extension = mime_type.split('/').second
          decoded_image = Base64.decode64(encoded_image)
          filename = "picture#{task.id}.#{extension}"
          image_path = "#{Rails.root}/tmp/storage/#{filename}"
          File.open(image_path, 'wb') do |f|
            f.write(decoded_image)
          end
          task.picture.attach({ io: File.open(image_path), filename: filename, content_type: mime_type })  
        end

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
        params.require(:task).permit(:title, :content, :isDone, :picture)
      end

    end    
  end
end
