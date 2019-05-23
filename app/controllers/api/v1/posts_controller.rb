module Api
  module V1
    class PostsController < ApplicationController
      def create
        post = Post.new(post_params);

        image_match = params[:avatar].match(/^data:(.*?);(?:.*?),(.*)$/)
        mime_type, encoded_image = image_match.captures

        extension = mime_type.split('/').second
        decoded_image = Base64.decode64(encoded_image)

        filename = "avatar#{post.id}.#{extension}"
        image_path = "#{Rails.root}/tmp/storage/#{filename}"
        File.open(image_path, 'wb') do |f|
          f.write(decoded_image)
        end

        post.avatar.attach({ io: File.open(image_path), filename: filename, content_type: mime_type })

        if post.save
          render json:{
            status: 'SUCCESS',
            message: 'loaded oists',
            data: {
              post: post,
            }
          }
        else
          render json:{
            status: 'FAILED',
            message: 'nanigasika failed',
            data: {
              post: post.errors.full_messages
            }
          }
        end
    
      end
    
      def show
        post = Post.find(params[:id])
        render json: post, methods:[:avatar_url]
      end
    
      private

      def post_params
        params.require(:post).permit(:title, :avatar)
      end
    end
  end
end

